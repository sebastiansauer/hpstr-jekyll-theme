logit2prob <- function(logit){
  # this function converts logits to probabilities. Useful for interpretation of glm.
  # input: logit
  # output: probability of logit
  odds <- exp(logit)
  prob <- odds / (1 + odds)
  return(prob)
}
