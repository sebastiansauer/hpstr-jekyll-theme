find_funs <- function(f) {
  # Returns dataframe with two columns:
  # `package_name`: packages(s) which the function is part of (chr)
  # `builtin_package`:  whether the package comes with standard R (a 'builtin'  package)

  # Arguments:
  # f: name of function for which the package(s) are to be identified.


  if ("tidyverse" %in% rownames(installed.packages()) == FALSE) {
    cat("tidyverse is needed for this fuction. Please install. Stopping")
    stop()}

  suppressMessages(library(tidyverse))


  # search for help in list of installed packages
  help_installed <- help.search(paste0("^",f,"$"), agrep = FALSE)

  # extract package name from help file
  pckg_hits <- help_installed$matches[,"Package"]

  # get list of built-in packages

  pckgs <- installed.packages()  %>% as_tibble
  pckgs %>%
    dplyr::filter(Priority %in% c("base","recommended")) %>%
    dplyr::select(Package) %>%
    distinct -> builtin_pckgs_df

  # check for each element of 'pckg hit' whether its built-in (via match). Then print results.

  results <- data_frame(
    package_name = pckg_hits,
    builtin_pckage = match(pckg_hits, builtin_pckgs_df$Package, nomatch = 0) > 0
  )

  return(results)

}

# code inspired by code from Ben Bolker
# https://stackoverflow.com/questions/10553755/name-of-a-package-for-a-given-function-in-r