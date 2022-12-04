rm(list =ls())
library(ggplot2)
data$LogN <- log(data$N)

# visualise
ggplot(data, aes(x = t, y = LogN)) + 
  geom_point(size = 3) +
  labs(x = "Time (Hours)", y = "log(cell number)")

gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

N_0_start <- min(data$LogN) # lowest population size, note log scale
K_start <- max(data$LogN) # highest population size, note log scale
r_max_start <- 0.62 # use our previous estimate from the OLS fitting from above
t_lag_start <- data$Time[which.max(diff(diff(data$LogN)))] # find last timepoint of lag phase

diff(diff(data$LogN)) # get the differentials of the differentials (approx 2nd order derivatives)

fit_gompertz <- nlsLM(LogN ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), data,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start))

summary(fit_gompertz)
