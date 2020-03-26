coords <- 
  read_csv("worldcities_coordinates.csv") %>% 
  filter(capital == "primary") %>% # Only capital cities
  select(country, city, iso2, lat, lng) %>%
  group_by(country) %>%
  summarise(city = city[1], # If more than 1 capital, select first
            iso2 = unique(iso2),
            lat = lat[1],
            lng = lng[1])

coords <-
  coords %>% mutate(iso2 = ifelse(is.na(iso2), "NAM", iso2))

write_csv(coords, "worldcities_coordinates_adjusted.csv")