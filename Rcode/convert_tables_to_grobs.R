



tab2plot <- function(path = "") {

  # Print csv-dataframes as plots using ggplot2 - for easier handling in Powerpoint & friends
  # Arguments
  # path: are the csv-files in a subdirectory? Then specify here. Defaults to "" (working directory)
  # Value:
  # None. Saves each csv-file as png file of the table.

  library(tidyverse)
  library(stringr)
  library(gridExtra)
  library(grid)

    df <- data_frame(
    file_name = list.files(path = path, pattern = "\\w+.csv"),
    title = str_extract(file_name, pattern = "\\w+")
  )

  tt <- ttheme_default(core=list(fg_params=list(hjust=0, x=0.1)))


  for (i in seq_along(df$file_name)) {
    cat(paste0(df$file_name[i], "\n"))
    csv_i <- read.csv(paste0(path, df$file_name[i]))
    #csv_i <- read.csv("includes/Befehle_Cluster.csv")
    csv_i %>%
      rownames_to_column %>%
      dplyr::select(-rowname) -> csv_i
    p <- arrangeGrob(tableGrob(csv_i, theme = tt))
    ggsave(file = paste0("images/Tabellen/","Tabelle_",df$title[i],".png"),  p)
  }

}

