---
title: "Convert logit to probability"
author: "Sebastian Sauer"
layout: post
tags: [rstats, stats, tutorial]
---




Logistic regression may give a headache initially. While the structure and idea is the same as "normal" regression, the interpretation of the b's (ie., the regression coefficients) can be more challenging.

This post explains how to convert the output of the `glm` function to a probability. Or more generally, to convert *logits* (that's what spit out by `glm`) to a probabilty.

---
*Note:* The objective of this post is to explain the mechanics of logits. There are more convenient tools out there.
---


# Example time

So, let's look at an example. First load some data (package need be installed!):

```r
data(titanic_train, package = "titanic")
d <- titanic_train  # less typing
```


Compute a simple glm:


```r
glm1 <- glm(Survived ~ Pclass, data = d, family = "binomial")
```

The coeffients are the interesting thing:


```r
coef(glm1)
```

```
## (Intercept)      Pclass 
##   1.4467895  -0.8501067
```

These coefficients are in a form called 'logits'.

# Takeaway

>    If coefficient (logit) is positive, the effect of this predictor is positive and vice versa.

Here `pclass` coefficient is negative indicating that the *higher*  `Pclass` the *lower* is the probability of survival.


# Conversion rule: logit to probability

To convert a logit (`glm` output) to probability, follow these 3 steps:

- Take `glm` output coefficient (logit)
- compute e-function on logit using `exp()` "de-logarithimize" (you'll get odds then)
- convert odds to probability using this formula odds = `rate_yes / rate_no + rate_yes)`


# R function to rule 'em all (ahem, to convert logits to probability)

This function converts logits to probability.

```r
logit2prob <- function(logit){
  odds <- exp(logit)
  prob <- odds / (1 + odds)
  return(prob)
}
```


For convenience, you can source the function like this:

```r
source("https://sebastiansauer.github.io/Rcode/logit2prob.R")
```


For our glm:


```r
logit2prob(coef(glm1))
```

```
## (Intercept)      Pclass 
##   0.8095038   0.2994105
```

# How to convert logits to probability

How to interpret:

- The survival probability is .70 if pclass were zero.
- However, you cannot just add the probability of `Pclass` to survival probability.

Instead, consider that the *logit* of survival changes by -.20 per unit of `Pclass`. So in first class for example survival rate would be:


```r
(prob_1st <- .84 * -.20)
```

```
## [1] -0.168
```

Now we can convert to probability:


```r
logit2prob(-.168)
```

```
## [1] 0.4580985
```

Remember that $$e^1 \approx 2.71$$ and that $$e^2 \approx 7.38$$:


```r
exp(1)
```

```
## [1] 2.718282
```

```r
exp(2)
```

```
## [1] 7.389056
```

```r
1/exp(1)
```

```
## [1] 0.3678794
```

```r
exp(-1)
```

```
## [1] 0.3678794
```



However, more convenient would be to use the `predict` function instance of `glm`. For example:
```r
predict(glm1, newdata=data.frame(Pclass=1), type="response")
```

(Thanks to Jack's comment who made me adding this note.)


# Conversion table

Here's a look up table for the conversion:


```r
logit_seq <- seq(-10, 10, by = 2)
```


```r
prob_seq <- round(logit2prob(logit_seq), 3)

df <- data.frame(Logit = logit_seq,
                 Probability = prob_seq)
```






```r
library(htmlTable)
htmlTable(df)
```

<table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Logit</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Probability</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>-10</td>
<td style='text-align: center;'>0</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>-8</td>
<td style='text-align: center;'>0</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>-6</td>
<td style='text-align: center;'>0.002</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>-4</td>
<td style='text-align: center;'>0.018</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>-2</td>
<td style='text-align: center;'>0.119</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>0</td>
<td style='text-align: center;'>0.5</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>0.881</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>4</td>
<td style='text-align: center;'>0.982</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>6</td>
<td style='text-align: center;'>0.998</td>
</tr>
<tr>
<td style='text-align: left;'>10</td>
<td style='text-align: center;'>8</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>11</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>10</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>1</td>
</tr>
</tbody>
</table>


A handy function is `datatable`, does not work in this environment however, it appears.


```r
library(DT)
datatable(df)
```

![plot of chunk unnamed-chunk-13](https://sebastiansauer.github.io/images/2017-01-24/unnamed-chunk-13-1.png)


# Conversion plot

More convenient for an overview is a plot like this.


```r
library(ggplot2)


logit_seq <- seq(-10, 10, by = .1)

prob_seq <- logit2prob(logit_seq)

rm(df)

df <- data.frame(Logit = logit_seq,
                 Probability = prob_seq)

ggplot(df) +
  aes(x = logit_seq, y = prob_seq) +
  geom_point(size = 2, alpha = .3) +
  labs(x = "logit", y = "probability of success")
```

![plot of chunk unnamed-chunk-14](https://sebastiansauer.github.io/images/2017-01-24/unnamed-chunk-14-1.png)


# Convenience function

The package [mfx](https://cran.r-project.org/web/packages/mfx/mfx.pdf) provides a convenient functions to get odds out of a logistic regression (Thanks for Henry Cann's comment for pointing that out!).



# Takeway

>   The relationship between logit and probability is not linear, but of s-curve type.


Happy glming!


# sessionInfo

```r
sessionInfo()
```

```
## R version 3.3.2 (2016-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: macOS Sierra 10.12.2
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] htmlTable_1.8 DT_0.2        ggplot2_2.2.1 knitr_1.15.1 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.8         magrittr_1.5        munsell_0.4.3      
##  [4] colorspace_1.3-2    stringr_1.1.0       highr_0.6          
##  [7] plyr_1.8.4          tools_3.3.2         webshot_0.4.0      
## [10] grid_3.3.2          checkmate_1.8.2     gtable_0.2.0       
## [13] htmltools_0.3.5     yaml_2.1.14         lazyeval_0.2.0.9000
## [16] assertthat_0.1      digest_0.6.11       rprojroot_1.1      
## [19] tibble_1.2          htmlwidgets_0.8     evaluate_0.10      
## [22] rmarkdown_1.3       labeling_0.3        stringi_1.1.2      
## [25] scales_0.4.1        backports_1.0.4     jsonlite_1.2
```

