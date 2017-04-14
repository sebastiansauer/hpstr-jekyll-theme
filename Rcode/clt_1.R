

stipros <- function(n_stipros = 1000, mean = 100, sd = 15, n = 30, distribution = "normal"){
  if (distribution == "normal") {
    result <- replicate(n_stipros, mean(rnorm(n = n, mean = mean, sd = sd)))
    hist(result, main = "Histogramm zu Stichproben \naus einer Normalverteilung")
    }
  if (distribution == "uniform") {
    result <- replicate(n_stipros, mean(runif(n = n, min=0, max=1)))
    hist(result, main = "Histogramm zu Stichproben \naus einer Gleichverteilung")
  }
}

simu_p <- function(n_samples = 1000, mean = 100, sd = 15, n = 30, distribution = "normal", sample_mean = 107){

  library(ggplot2)
  library(dplyr)



  if (distribution == "normal") {
    samples <- replicate(n_samples, mean(rnorm(n = n, mean = mean, sd = sd)))

    df <- data.frame(samples = samples)

    df %>%
      mutate(perc_num = percent_rank(samples),
             max_5perc = ifelse(perc_num > 950, 1, 0),
             greater_than_sample = ifelse(samples > sample_mean, 1, 0)) -> df

    p_value <- round(mean(df$greater_than_sample), 3)

    p <- ggplot(df) +
      aes(x = samples) +
      geom_histogram() +
      labs(title = paste("Histogram of ", n_samples, " samples", "\n from a normal distribution", sep = ""),
           caption = paste("mean-pop=", mean, ", sd-pop=",sd, sep = "", ", mean in sample=", sample_mean),
           x = "sample means") +
      geom_histogram(data = dplyr::filter(df, perc_num > .95), fill = "red") +
      theme(plot.title = element_text(hjust = 0.5)) +
      geom_vline(xintercept = sample_mean, linetype = "dashed", color = "grey40") +
      ggplot2::annotate("text", x = Inf, y = Inf, label = paste("p =",p_value), hjust = 1, vjust = 1)
    print(p)
  }


  if (distribution == "uniform") {
    samples <- replicate(n_samples, mean(runif(n = n, min=0, max=1)))
    df <- data.frame(samples = samples)

    if (sample_mean > 1) sample_mean <- .99


    df %>%
      mutate(perc_num = percent_rank(samples),
             max_5perc = ifelse(perc_num > 950, 1, 0),
             greater_than_sample = ifelse(samples > sample_mean, 1, 0)) -> df

    p_value <- round(mean(df$greater_than_sample), 3)


    p <- ggplot(df) +
      aes(x = samples) +
      geom_histogram() +
      labs(title = paste("Histogram of ", n_samples, " samples", "\n from a uniform distribution", sep = ""),
           caption = paste("sample mean =", sample_mean, ", min-pop = 0, max-pop = 1"),
           x = "sample means") +
      geom_histogram(data = dplyr::filter(df, perc_num > .95), fill = "red") +
      theme(plot.title = element_text(hjust = 0.5)) +
      geom_vline(xintercept = sample_mean, linetype = "dashed", color = "grey40") +
      ggplot2::annotate("text", x = Inf, y = Inf, label = paste("p =",p_value), hjust = 1, vjust = 1)
    print(p)

  }
return(df)

}

