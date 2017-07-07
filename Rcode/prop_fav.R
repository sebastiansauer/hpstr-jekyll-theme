prop_fav <- function(df, value, group, g1, g2){
  value <- enquo(value)
  group <- enquo(group)


  df %>%
   filter((!!group) == g1) %>%
   select(!!value) %>%
   pull -> values_g1

  df %>%
    filter((!!group) == g2) %>%
    select(!!value) %>%
    pull -> values_g2

  values_g1 <- na.omit(values_g1)

  comp_grid <- expand.grid(values_g1, values_g2)

  fav_vec <- comp_grid[["Var1"]] > comp_grid[["Var2"]]

  fav_sum <- sum(fav_vec)

  fav_prop <- fav_sum / nrow(comp_grid)

  return(fav_prop)

}






prop_fav2 <- function(df, value, g1, g2){

  if (!(require(tidyverse))) stop("package tidyverse is needed but not loaded.")

  filter_clause1 <- quo(!!group == g1)
  filter_clause2 <- quo(!!group == g2)

  value <- enquo(value)

  df %>%
    filter(!!filter_clause1) %>%
    select(!!value) %>%
    pull -> values_g1

  values_g1 <- na.omit(values_g1)

  df %>%
    filter(!!filter_clause2) %>%
    select(!!value) %>%
    pull -> values_g2

  values_g2 <- na.omit(values_g2)

  comp_grid <- expand.grid(values_g1, values_g2)

  fav_vec <- comp_grid[["Var1"]] > comp_grid[["Var2"]]

  fav_sum <- sum(fav_vec)

  fav_prop <- fav_sum / nrow(comp_grid)

  return(fav_prop)

}

