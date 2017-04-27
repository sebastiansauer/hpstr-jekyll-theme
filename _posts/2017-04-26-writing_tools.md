---
title: "Tools for Academic Writing - Comparison"
author: "Sebastian Sauer"
date: "26 4 2017"
layout: post
tags: [writing, reproducibility]
---




Many tools exist for academic writing including the notorious W.O.R.D.; but many more are out there. Let's have a look at those tools, and discuss what's important (what we expect the tools to deliver, eg., beautiful typesetting).


# Typical tools for academic writing

- *MS Word*: A "classical" choice, relied upon by myriads of white collar workers... I myself have used it extensively for academic writing; the main advantage being its simplicity, that is, well, everybody knows it, and knows more or less how to handle it. It's widespread use is of course an advantage.

- TeX: The purist's choice. The learning curve can be steep, but its beauty and elegance of typesetting if unreached.

- *Overleaf*, *Authorea*: Web-based apps that make it easy to enjoy modern functionality by making the entry hurdle as low as possible. These riches do not come for free; commercial organizations would like to see some return of investment.

- *Full*: With the "full" approach I refer to a blended version of several tools, mainly:
    - R
    - RStudio
    - RMarkdown (ie., knitr + markdown + pandoc)
    - Git + Github
    - stylesheets such as [papaja](https://github.com/crsh/papaja) (APA6 stylesheet)
  
- *Markdown*: Markdown is a simple variant of markup languages such as HTLM or LaTeX. Its marked feature is its simplicity. In fact, it can be learned in 5 minutes (whereas TeX may need 5-50 years, some say...).

- *Google Docs*: Easy, no (direct) costs, comfortable, but some features are lacking - There's no easy for citations. In addition, some say intellectual rights are transferred to Google by using G Docs (I have no clue whether that's true).


# Tool comparison table


```r
libs <- c("readr", "tidyverse", "pander", "emo")
pacman::p_load(char = libs)
```



```r
tools <- read_csv("academic_writing_tools_competition.csv")
```






```r
pander(df)
```



-----------------------------------------------------------------------------
        Criterion           Word   Tex   Overleaf_Authorea   Full   Markdown 
-------------------------- ------ ----- ------------------- ------ ----------
  Beautiful typesetting      1      3            3            3        3     

 Different output formats    2      3            3            3        3     

        Citations            2      3            3            3        3     

       Integrate R           1      1            1            3        1     

     Version control         2      1            3            3        1     

Reproducibility of writing   1      3            2            3        1     

      Collaboration          1      1            3            2        1     

        Simplicity           3      1            2            1        2     

 Style sheets (eg., APA)     1      2            3            2        1     

        Stability            1      3            2            3        3     

        Open code            1      3            2            3        3     

Option for private writing   3      3            1            3        3     
-----------------------------------------------------------------------------

Table: Table continues below

 
--------
 G_Docs 
--------
   1    

   2    

   1    

   1    

   2    

   1    

   3    

   3    

   1    

   2    

   1    

   3    
--------



# Criterion weight

Let's assume we have some weights that we assign to the critera:


-----------------------------------
Criterion                  Weight  
-------------------------- --------
Beautiful typesetting      1       

Different output formats   2       

Citations                  3       

Integrate R                2       

Version control            2       

Reproducibility of writing 2       

Collaboration              3       

Simplicity                 2       

Style sheets (eg., APA)    2       

Stability                  3       

Open code                  2       

Option for private writing 2       
-----------------------------------


# Scores by tool

So we are able to devise a score or a ranking.


-------------------------
tool_name         score  
----------------- -------
Full              69     

Overleaf_Authorea 61     

Tex               58     

Markdown          54     

G_Docs            47     

Word              41     
-------------------------



```r
score %>% ggplot + aes(x = reorder(tool_name, score), y = score) + 
    geom_point() + coord_flip() + xlab("tool")
```

<img src="https://sebastiansauer.github.io/images/2017-04-26/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="70%" style="display: block; margin: auto;" />


# And the winner is...

**The full approach**. The full approach gets most points (disclaimer: well, I designed this compeition, and I like this approach 😄.


