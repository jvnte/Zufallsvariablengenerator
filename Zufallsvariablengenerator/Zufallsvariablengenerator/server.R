shinyServer(function(input, output) {
  
  rv <- reactiveValues(
    norm = rnorm(500),
    mu = 0,
    sigma = 1,
    normmin = -4,
    normmax = 4,
    unif = runif(500),
    min = 0,
    max = 1,
    unifmin = 0,
    unifmax = 1,
    binom = rbinom(500, 2, 0.5),
    n = 2,
    pi = 0.5,
    binommin = 0,
    binommax = 2,
    exp = rexp(500, 2),
    lambda = 2,
    expmin = 0,
    expmax = 5)
  
  # Normalverteilung
  observeEvent(input$renorm, { 
    rv$norm <- rnorm(input$normnum, mean = input$mu, sd = input$sigma)
    rv$mu <- input$mu
    rv$sigma <- input$sigma
  })
  # Gleichverteilung
  observeEvent(input$reunif, { 
    rv$unif <- runif(input$unifnum, min = input$min, max = input$max)
    rv$min <- input$min
    rv$max <- input$max
  })
  # Binomialverteilung
  observeEvent(input$rebinom, { 
    rv$binom <- rbinom(n = input$binomnum, size = input$n, prob = input$pi)
    rv$pi <- input$pi
    rv$n <- input$n
  })
  # Exponentialverteilung
  observeEvent(input$reexp, { 
    rv$exp <- rexp(n = input$expnum, rate = input$lambda)
    rv$lambda <- input$lambda
  })
  
  # Normalverteilung
  output$WFnorm <- renderPlot({
    ggplot(as.tibble(rv$norm), aes(x = value, y = dnorm(value, rv$mu, rv$sigma))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = dnorm(value, rv$mu, rv$sigma), ymin = 0)) +
      coord_cartesian(xlim = c(input$normmin, input$normmax)) +
      ggtitle(paste(length(rv$norm), "Züge einer normalverteilten Zufallsvariable mit mu = ", 
                    rv$mu, "und sigma = ", rv$sigma)) +
      labs(y = "P(X=x)",
           x = "x")
  })
  output$VFnorm <- renderPlot({
    ggplot(as.tibble(rv$norm), aes(x = value, y = pnorm(value, rv$mu, rv$sigma))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = pnorm(value, rv$mu, rv$sigma), ymin = 0)) +
      coord_cartesian(xlim = c(input$normmin, input$normmax)) +
      ggtitle(paste(length(rv$norm), "Züge einer normalverteilten Zufallsvariable mit mu = ", 
                    rv$mu, "und sigma = ", rv$sigma)) +
      labs(y = "F(X=x)",
           x = "x")
  })
  output$normtable <- renderTable({
    tibble(Moment = c("Erwartungswert","Varianz","Standardabweichung", "Schiefe", "Kurtosis"),
           Theoretisch = c(rv$mu,
                           rv$sigma^2,
                           rv$sigma,
                           0,
                           3),
           Empirisch = c(mean(rv$norm),
                         var(rv$norm),
                         sd(rv$norm),
                         skewness(rv$norm),
                         kurtosis(rv$norm)))
  })
  
  # Gleichverteilung
  output$WFunif <- renderPlot({
    ggplot(as.tibble(rv$unif), aes(x = value, y = dunif(value, rv$min, rv$max))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = dunif(value, rv$min, rv$max), ymin = 0)) +
      coord_cartesian(xlim = c(input$unifmin, input$unifmax)) +
      ggtitle(paste(length(rv$unif), "Züge einer gleichverteilten Zufallsvariable mit min = ", 
                    rv$min, "und max = ", rv$max)) +
      labs(y = "P(X=x)",
           x = "x")
  })
  output$VFunif <- renderPlot({
    ggplot(as.tibble(rv$unif), aes(x = value, y = punif(value, rv$min, rv$max))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = punif(value, rv$min, rv$max), ymin = 0)) +
      coord_cartesian(xlim = c(input$unifmin, input$unifmax)) +
      ggtitle(paste(length(rv$unif), "Züge einer gleichverteilten Zufallsvariable mit min = ", 
                    rv$min, "und max = ", rv$max)) +
      labs(y = "F(X=x)",
           x = "x")
  })
  output$uniftable <- renderTable({
    tibble(Moment = c("Erwartungswert","Varianz","Standardabweichung", "Schiefe", "Kurtosis"),
           Theoretisch = c((rv$max+rv$min)/2,
                           1/12*(rv$max-rv$min)^2,
                           (rv$max-rv$min)/(2*sqrt(3)),
                           0,
                           9/5),
           Empirisch = c(mean(rv$unif),
                         var(rv$unif),
                         sd(rv$unif),
                         skewness(rv$unif),
                         kurtosis(rv$unif)))
  })
  
  # Binomialverteilung
  output$WFbinom <- renderPlot({
    ggplot(as.tibble(rv$binom), aes(x = value, y = dbinom(value, rv$n, rv$pi))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = dbinom(value, rv$n, rv$pi), ymin = 0)) +
      coord_cartesian(xlim = c(input$binommin, input$binommax)) +
      ggtitle(paste(length(rv$binom), "Züge einer binomialverteilten Zufallsvariable mit n = ", 
                    rv$n, "und pi = ", rv$pi)) +
      labs(y = "P(X=x)",
           x = "x")
  })
  output$VFbinom <- renderPlot({
    ggplot(as.tibble(rv$binom), aes(x = value, y = pbinom(value, rv$n, rv$pi))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = pbinom(value, rv$n, rv$pi), ymin = 0)) +
      coord_cartesian(xlim = c(input$binommin, input$binommax)) +
      ggtitle(paste(length(rv$binom), "Züge einer binomialverteilten Zufallsvariable mit n = ", 
                    rv$n, "und pi = ", rv$pi)) +
      labs(y = "F(X=x)",
           x = "x")
  })
  output$binomtable <- renderTable({
    tibble(Moment = c("Erwartungswert","Varianz","Standardabweichung", "Schiefe", "Kurtosis"),
           Theoretisch = c(rv$n*rv$pi,
                           rv$n*(1-rv$pi)*rv$pi,
                           sqrt(rv$n*(1-rv$pi)*rv$pi), 
                           (1-2*rv$pi)/sqrt(rv$n*(1-rv$pi)*rv$pi),
                           (1-(6*(1-rv$pi)*rv$pi))/(rv$n*(1-rv$pi)*rv$pi)+3),
           Empirisch = c(mean(rv$binom),
                         var(rv$binom),
                         sd(rv$binom),
                         skewness(rv$binom),
                         kurtosis(rv$binom)))
  })
  
  # Exponentialvertelung
  output$WFexp <- renderPlot({
    ggplot(as.tibble(rv$exp), aes(x = value, y = dexp(value, rv$lambda))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = dexp(value, rv$lambda), ymin = 0)) +
      coord_cartesian(xlim = c(input$expmin, input$expmax)) +
      ggtitle(paste(length(rv$exp), "Züge einer exponentialverteilten Zufallsvariable mit lambda = ", 
                    rv$lambda)) +
      labs(y = "P(X=x)",
           x = "x")
  })
  output$VFexp <- renderPlot({
    ggplot(as.tibble(rv$exp), aes(x = value, y = pexp(value, rv$lambda))) + 
      geom_point() +
      geom_linerange(aes(x = value, ymax = pexp(value, rv$lambda), ymin = 0)) +
      coord_cartesian(xlim = c(input$expmin, input$expmax)) +
      ggtitle(paste(length(rv$exp), "Züge einer exponentialverteilten Zufallsvariable mit lambda = ", 
                    rv$lambda)) +
      labs(y = "F(X=x)",
           x = "x")
  })
  output$exptable <- renderTable({
    tibble(Moment = c("Erwartungswert","Varianz","Standardabweichung", "Schiefe", "Kurtosis"),
           Theoretisch = c(1/rv$lambda,
                           1/(rv$lambda)^2,
                           1/rv$lambda,
                           2,
                           6),
           Empirisch = c(mean(rv$exp),
                         var(rv$exp),
                         sd(rv$exp),
                         skewness(rv$exp),
                         kurtosis(rv$exp)))
  })
})