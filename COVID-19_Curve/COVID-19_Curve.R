# https://towardsdatascience.com/https-towardsdatascience-com-everything-you-need-to-know-about-animated-bar-charts-be033f398619

library(tidyverse)
library(plotly)
library(directlabels)

setwd("~/GitHub/Visualizations")

covid <- read_csv("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-03-24.csv")

# Rename column countries and territories
names(covid)[7] <- "Countries_and_territories"

# Rename GeoId NA into NAM 
covid <- covid %>% mutate(GeoId = ifelse(is.na(GeoId), "NAM", GeoId))

# Create ID column
covid <- covid %>% mutate(ID = 1:nrow(covid)) %>% .[,c(9, 1:8)]

# Convert DateRep into date object
covid <- covid %>% mutate(DateRep = as.Date(DateRep, format = "%d/%m/%Y"))

# Convert char into factor
covid <- mutate_if(covid, is.character, as.factor)

# Aggregated Cases
all_GeoIds <- unique(covid$GeoId)
new_df <- data.frame()
for( idx in all_GeoIds ){

  new_entries <-
    covid %>% 
    filter(GeoId == idx) %>% 
    mutate(CumCases = rev(cumsum(rev(Cases)))) %>%
    select(ID, CumCases)
  
  new_df <-
    rbind(new_df, new_entries)
}
covid <- covid %>% left_join(., new_df, by = c("ID" = "ID"))

# DayCount from Case #50 onwards

new_df <- data.frame()
for( idx in all_GeoIds ){
  
  val <-
    covid %>%
    group_by(GeoId) %>%
    summarize(SumUp = sum(CumCases >= 50)) %>%
    filter(GeoId == idx) %$%
    as.vector(as.matrix(.[2]))
  
  new_entries <-
    covid %>% 
    filter(GeoId == idx) %>% 
    mutate(DayCount = ifelse(CumCases >= 50, val:1, NA))  %>%
    select(ID, DayCount)
  
  new_df <-
    rbind(new_df, new_entries)
}
covid <- covid %>% left_join(., new_df, by = c("ID" = "ID"))

ger <- covid %>% 
  filter(GeoId == "DE") %>% 
  filter(DayCount == max(DayCount, na.rm = T)) 

ger_marker_settings <-
  list(
    x = ger$DayCount,
    y = ger$CumCases,
    text = "Germany",
    xref = "x",
    yref = "y",
    showarrow = TRUE,
    arrowhead = 7,
    ax = -40,
    ay = -100
  )

plot <-
covid %>%
  filter(!is.na(DayCount)) %>%
  ggplot(aes(x = DayCount, y = CumCases)) +
  geom_line(aes(color = Countries_and_territories)) +
  geom_dl(aes(label=Countries_and_territories, color=Countries_and_territories), method = list("last.points")) +
  guides(color = FALSE) +
  theme(plot.caption =element_text(size=12, hjust=0.5, face="italic", color="red"),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="red"),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="red", vjust=-1),
        legend.position="none") +
  labs(title = 'Development of COVID-19 cases worldwide from case #50 onwards',
       x = "Days after case #50 occured",
       y = "",
       caption  = "Data Source: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide") +
  theme_minimal() 

ggplotly(plot) %>% 
  layout(showlegend = FALSE) %>%
  add_markers() %>%
  layout(annotations = ger_marker_settings)

  

