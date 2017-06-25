---
title: "Preparation of extraversion survey data"
author: "Sebastian Sauer"
layout: post
tags: [rstats, psychometrics, survey]
---




For teaching purposes and out of curiosity towards some psychometric questions, I have run a survey on extraversion [here](https://docs.google.com/forms/d/e/1FAIpQLSfD4wQuhDV_edx1WBfN3Qos7XqoVbe41VpiKLRKtGLeuUD09Q/viewform?usp=sf_link). The dataset has been published at [OSF](https://osf.io/4kgzh/) (DOI 10.17605/OSF.IO/4KGZH). The survey is base on a google form, which in turn saves the data in Google spreadsheet. Before the data can be analyzed, some preparation and makeup is in place. This posts shows some general makeup, typical for survey data.



# Download the data and load packages

Download the data from source (Google spreadsheets); the package `gsheet` provides an easy interface for that purpose.


```r
library(gsheet)
extra_raw <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1Ln8_0xSJ5teHY2QkwGaYxDLxpcdjOsQ0gIAEZ5az5BY/edit#gid=305064170")
```

```
## Warning: Missing column names filled in: 'X23' [23]
```


```r
library(tidyverse)  # data judo
library(purrr)  # map
library(lsr)  # aad
library(modeest)  # mlv
#devtools::install_github("sebastiansauer/prada")
library(prada)
```



# Prepare variable names

First, save item names in a separate object for later retrieval and for documentation.


```r
extra_names <- names(extra_raw) 
head(extra_names)
```

```
## [1] "Zeitstempel"                                                                                                                                                                                       
## [2] "Bitte geben Sie Ihren dreistellen anonymen Code ein (1.: Anfangsbuchstabe des Vornamens Ihres Vaters; 2.: Anfangsbuchstabe des Mädchennamens Ihrer Mutter; 3: Anfangsbuchstabe Ihres Geburstsorts)"
## [3] "Ich bin gerne mit anderen Menschen zusammen."                                                                                                                                                      
## [4] "Ich bin ein Einzelgänger. (-)"                                                                                                                                                                     
## [5] "Ich bin in vielen Vereinen aktiv."                                                                                                                                                                 
## [6] "Ich bin ein gesprächiger und kommunikativer Mensch."
```


Next, replace the lengthy col names by 'i' followed by a number:


```r
extra <- extra_raw
names(extra) <- c("timestamp", "code", paste0("i",1:26))
```



Then we rename some of the variables with new names.



```r
extra <-
  extra %>%
  rename(n_facebook_friends = i11,
         n_hangover = i12,
         age = i13,
         sex = i14,
         extra_single_item = i15,
         time_conversation = i16,
         presentation = i17,
         n_party = i18,
         clients = i19,
         extra_vignette = i20,
         extra_vignette2 = i22,
         major = i23,
         smoker = i24,
         sleep_week = i25,
         sleep_wend = i26)
```


# Parse numbers from chr columns 

Some columns actually assess a number but the field in the survey form was liberally open to characters. So we have to convert the character to numbers, or, more precisely, suck out the numbers from the character variables.


```r
extra$n_hangover <- parse_number(extra$n_hangover)
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 2 parsing failures.
## row # A tibble: 2 x 4 col     row   col expected actual expected   <int> <int>    <chr>  <chr> actual 1   132    NA a number Keinen row 2   425    NA a number      .
```

```r
extra$n_facebook_friends <- parse_number(extra$n_facebook_friends)
extra$time_conversation <- parse_number(extra$time_conversation)
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 2 parsing failures.
## row # A tibble: 2 x 4 col     row   col expected      actual expected   <int> <int>    <chr>       <chr> actual 1   153    NA a number       Opfer row 2   633    NA a number Eine Minute
```

```r
extra$n_party <- parse_number(extra$n_party)
```

```
## Warning: 1 parsing failure.
## row # A tibble: 1 x 4 col     row   col expected actual expected   <int> <int>    <chr>  <chr> actual 1   270    NA a number      u
```

The parsing left the dataframe with some rather ugly attributes, albeit with interesting informations. After checking them, however, I feel inclined to delete them.


```r
attributes(extra$n_hangover) <- NULL
attributes(extra$time_conversation) <- NULL
attributes(extra$n_party) <- NULL
attributes(extra$sleep_wend) <- NULL
attr(extra, "spec") <- NULL
```



# Recode items

Some extraversion items (variables i2, i6) need to be recoded, ie., reversed. 



```r
extra %>% 
  mutate(i2 = 5-i2,
            i6 = 5-i6) %>% 
  rename(i2r = i2,
         i6r = i6) -> extra
```


# Compute summaries (extraversion score)

Let's compute the mean but also the median and mode for each *person* (ie., row) with regard to the 10 extraversion items.


```r
extra %>% 
  rowwise %>% 
  summarise(extra_m = mean(c(i3, i4r, i5, i6, i7, i8r, i9, i10, i11, i12), na.rm = TRUE),
            extra_md = median(c(i3, i4r, i5, i6, i7, i8r, i9, i10, i11, i12), na.rm = TRUE),
            extra_aad = aad(c(i3, i4r, i5, i6, i7, i8r, i9, i10, i11, i12), na.rm = TRUE),
            extra_mode = prada::most(c(i3, i4r, i5, i6, i7, i8r, i9, i10, i11, i12)),
            extra_iqr = IQR(c(i3, i4r, i5, i6, i7, i8r, i9, i10, i11, i12), na.rm = TRUE)) -> extra_scores
```

```
## Error in summarise_impl(.data, dots): Evaluation error: object 'i4r' not found.
```

```r
extra %>% 
  bind_cols(extra_scores) -> extra
```
