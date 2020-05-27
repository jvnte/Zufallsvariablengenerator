shinyUI(
  navbarPage(title = "Zufallsvariablengenerator",
                 navbarMenu(title = "Diskrete Zufallsvariablen",
                            tabPanel(title = "Binomialverteilung",
                                     sidebarLayout(
                                       sidebarPanel(
                                         wellPanel(
                                           h3("Parametereinstellungen"),
                                           sliderInput(inputId = "binomnum", 
                                                       label = "Anzahl der binomialverteilten Beobachtungen", 
                                                       value = 500, min = 1, max = 1000),
                                           numericInput(inputId = "n",
                                                        label = "Anzahl der Versuche: n",
                                                        value = 2, min = 0),
                                           numericInput(inputId = "pi",
                                                        label = HTML("Gewinnwahrscheinlichkeit: &pi;"),
                                                        value = 0.5, min = 0, max = 1, step = 0.1),
                                           actionButton("rebinom", "Ziehe neue Zahlen")
                                         ),
                                         wellPanel(
                                           h3("Statistische Momente"),
                                           tableOutput(outputId = "binomtable")
                                         ),
                                         wellPanel(
                                           h3("Observationsbereich"),
                                           numericInput(inputId = "binommin",
                                                        label = "Minimaler x-Wert",
                                                        value = 0),
                                           numericInput(inputId = "binommax",
                                                        label = "Maximaler x-Wert",
                                                        value = 2)
                                         )
                                       ),
                                       mainPanel(
                                         h3("Wahrscheinlichkeitsfunktion"),
                                         plotOutput("WFbinom"),
                                         hr(),
                                         h3("Verteilungsfunktion"),
                                         plotOutput("VFbinom")
                                       )
                                     )
                                     
                            ),
                            tabPanel(title = "Exponentialverteilung",
                                     sidebarLayout(
                                       sidebarPanel(
                                         wellPanel(
                                           h3("Parametereinstellungen"),
                                           sliderInput(inputId = "expnum", 
                                                       label = "Anzahl der exponentialverteilten Beobachtungen", 
                                                       value = 500, min = 1, max = 1000),
                                           numericInput(inputId = "lambda",
                                                        label = HTML("Rate: &lambda;"),
                                                        value = 2, min = 0, step = 0.5),
                                           actionButton("reexp", "Ziehe neue Zahlen")
                                         ),
                                         wellPanel(
                                           h3("Statistische Momente"),
                                           tableOutput(outputId = "exptable")
                                         ),
                                         wellPanel(
                                           h3("Observationsbereich"),
                                           numericInput(inputId = "expmin",
                                                        label = "Minimaler x-Wert",
                                                        value = 0),
                                           numericInput(inputId = "expmax",
                                                        label = "Maximaler x-Wert",
                                                        value = 3)
                                         )
                                       ),
                                       mainPanel(
                                         h3("Wahrscheinlichkeitsfunktion"),
                                         plotOutput("WFexp"),
                                         hr(),
                                         h3("Verteilungsfunktion"),
                                         plotOutput("VFexp")
                                       )
                                     )
                                     
                            )
                 ),
                 navbarMenu(title = "Stetige Zufallsvariablen",
                            tabPanel(title = "Gleichverteilung",
                                     sidebarLayout(
                                       sidebarPanel(
                                         wellPanel(
                                           h3("Parametereinstellungen"),
                                           sliderInput(inputId = "unifnum", 
                                                       label = "Anzahl an gleichverteilten Beobachtungen (n)", 
                                                       value = 500, min = 1, max = 1000),
                                           numericInput(inputId = "min",
                                                        label = "Minimum",
                                                        value = 0),
                                           numericInput(inputId = "max",
                                                        label = "Maximum",
                                                        value = 1),
                                           actionButton("reunif", "Ziehe neue Zahlen")
                                         ),
                                         wellPanel(
                                           h3("Statistische Momente"),
                                           tableOutput(outputId = "uniftable")
                                         ),
                                         wellPanel(
                                           h3("Observationsbereich"),
                                           numericInput(inputId = "unifmin",
                                                        label = "Minimaler x-Wert",
                                                        value = 0),
                                           numericInput(inputId = "unifmax",
                                                        label = "Maximaler x-Wert",
                                                        value = 1)
                                         )
                                       ),
                                       mainPanel(
                                         h3("Wahrscheinlichkeitsfuntion"),
                                         plotOutput("WFunif"),
                                         hr(),
                                         h3("Verteilungsfunktion"),
                                         plotOutput("VFunif")
                                       )
                                     )
                                     
                            ),
                            tabPanel(title = "Normalverteilung",
                                     sidebarLayout(
                                       sidebarPanel(
                                         wellPanel(
                                           h3("Parametereinstellungen"),
                                           sliderInput(inputId = "normnum", 
                                                       label = "Anzahl an normalverteilten Beobachtungen (n)", 
                                                       value = 500, min = 1, max = 1000),
                                           numericInput(inputId = "mu",
                                                        label = HTML("Erwartungswert: &mu;"),
                                                        value = 0),
                                           numericInput(inputId = "sigma",
                                                        label = HTML("Varianz: &sigma;<sup>2</sup>"),
                                                        value = 1, min = 1),
                                           actionButton("renorm", "Ziehe neue Zahlen")
                                         ),
                                         wellPanel(
                                           h3("Statistische Momente"),
                                           tableOutput(outputId = "normtable")
                                         ),
                                         wellPanel(
                                           h3("Observationsbereich"),
                                           numericInput(inputId = "normmin",
                                                        label = "Minimaler x-Wert",
                                                        value = -3),
                                           numericInput(inputId = "normmax",
                                                        label = "Maximaler x-Wert",
                                                        value = 3)
                                         )
                                       ),
                                       mainPanel(
                                         h3("Wahrscheinlichkeitsfunktion"),
                                         plotOutput("WFnorm"),
                                         hr(),
                                         h3("Verteilungsfunktion"),
                                         plotOutput("VFnorm"),
                                         hr()
                                       )
                                     )
                            )
                 )
)
)
