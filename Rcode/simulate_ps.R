
simulate_ps <- function(n = 1e06, k = 20){

  # arguments:
  # n: number of rows
  # k: number of columns
  # returns: proportion of significant (p<.05) t-tests

  set.seed(42)

  # simulate data
  df <- data.frame(replicate(k,rnorm(n = n, mean = rnorm(1, 0, 1), sd = 1)))

  # matrix for t-test results
  m <- matrix(nrow = k, ncol = k)

  # cartesian product of all t-tests
  for (i in seq_len(ncol(df))) {
    for (j in seq_len(ncol(df))) {
      m[i, j] <- t.test(df[i], df[j])$p.value
    }
  }

  # take-out redundant cells
  m[lower.tri(m)] <- NA
  m[diag(m)] <- NA

  # compute matrix to count number of significant t-tests
  m_significant <- apply(m, c(1,2), function(x) x < .05)


  # count
  sum_significant <- sum(m_significant, na.rm = TRUE)

  sum_distinct_tests <- (k*k - k)/2

  prop_significant <- sum_significant / sum_distinct_tests

  rm(df)
  return(prop_significant)

}
