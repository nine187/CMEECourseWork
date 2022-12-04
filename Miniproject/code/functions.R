###########################model function######################

# logistic model
logistic_model <- function(t, r_max, K, N_0){ # The classic logistic equation
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

# gompertz model
gompertz_model <- function(N_0, K, r_max, t_lag, t){
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}

####################################################


#AIC
aic_function <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
}

#AIC w/o log (for Gompertz model)
aic_function_forG <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * ((2 * pi) / n) + n * (rss) + 2 * p
}

#AICc function (second order estimate)
#k = the number of models tested
#n = 
aicc_function <- function(AIC, k, n){
  AIC_c = AIC + (2 * k * (k + 1))/(n - k - 1)
  return(AIC_c)
}

#BIC
bic_function <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * log((2 * pi) / n) + n * log(rss) + p * log(n)
}

#BIC w/o log (for Gompertz model)
bic_function_forG <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * ((2 * pi) / n) + n * (rss) + p * log(n)
}