#setwd("Documents/CMEECourseWork/Miniproject/code")
rm(list=ls())
graphics.off()
source("functions.R")
#nlsLM
library("minpack.lm")
#read the file

############################preallocating dataframes#######################

cat("Preallocating Dataframes")

data <- read.csv("../results/Wrangled_Data.csv", header = TRUE)
#replace Inf and -Inf to NA
data[is.na(data) | data == "Inf" | data == "-Inf"] <- NA
length(unique(data$Citation))
length(unique(data$Medium))
###pre allocating data frames####

pre_df <- data.frame(#Unique IDs
                      ID = c(1:285),
                     #Quadratic
                      Q_AIC = rep(0,285),
                        Q_BIC = rep(0,285),
                        Q_intercept = rep(0,285),
                        Q_slope = rep(0,285),
                     #Cubic
                      C_AIC = rep(0,285),
                        C_BIC = rep(0,285),
                        C_intercept = rep(0,285),
                        C_slope = rep(0,285),
                     #Logistic
                     L_AIC = rep(0,285),
                       L_BIC = rep(0,285),
                       L_Rmax = rep(0,285),
                      L_K = rep(0,285),
                      L_N0 = rep(0,285),
                     #Gompertz
                     G_AIC = rep(0,285),
                      G_BIC = rep(0,285),
                      G_rmax = rep(0,285),
                      G_K = rep(0,285),
                      G_N0 = rep(0,285),
                      G_tlag = rep(0,285),
                     Medium = rep(0,285),
                     Cite = rep(0,285),
                     Species = rep(0,285)
                    )

#assign the unique cite, species, and medium corresponding each ID
for (i in unique(data$ID)) {
  temp_df <- data[which(data$ID == i),]
  #browser()
  pre_df$Cite[i] <- temp_df$Citation
  pre_df$Species[i] <- temp_df$Species
  pre_df$Medium[i] <- temp_df$Medium
}

#create an initial value
Initial_value <- data.frame(ID = c(1:285), 
                           N0 = rep(0,285),
                           K = rep(0,285),
                           rmax = rep(0,285),
                           t_lag = rep(0,285))

#log the PopBio data
data$LOGPopBio <- log10(data$PopBio)

#same randomization
set.seed(1234)

#create unique subset for each unique IDs
for (i in unique(Initial_value$ID)){
  
  #creates a temporary dataframes for each unique ID
  temp_df <- subset(data, data$ID == i)  
  
  #each unique IDs
  Initial_value[i,1] <- i
  
  # lowest population size
  Initial_value[i,2] <- min(temp_df$LOGPopBio)
  
  # highest population size
  Initial_value[i,3] <- max(temp_df$LOGPopBio)
  
  #Rmax- setting the upper and lower bound
  Initial_value[i,4] <- runif(1, min = 10^-10, max = 10^-2)
  
  # find last timepoint of lag phase
  Initial_value[i,5] <- temp_df$Time[which.max(diff(diff(temp_df$LOGPopBio)))]
}

#change all initial values that are inf and -inf to NA
Initial_value[is.na(Initial_value) | Initial_value == "Inf" | Initial_value == "-Inf"] <- NA

##################################model fitting############################

#for each unique ID in the data
for (i in unique(data$ID)){
  #browser()
  
  #creates a temporary dataframe
  temp_df <- data[which(data$ID == i),]

  # use rnorm to random sample 100 iterations
  N0 <- rnorm(100, mean = Initial_value$N0[1])
  K <- rnorm(100, mean = Initial_value$K[1])
  rmax <- rnorm(100, mean = Initial_value$rmax[1])
  t_lag <- rnorm(100, mean = Initial_value$t_lag[1])
  
  #creates a log stat dataframe to store different tries in each loop
  l_stats <- data.frame(AIC = rep(NA, 100),
                          BIC = rep(NA ,100),
                          rmax = rep(NA, 100),
                          K = rep(NA, 100),
                          N0 = rep(NA, 100))
  g_stats <- data.frame(AIC = rep(NA, 100),
                           BIC = rep(NA ,100),
                           rmax = rep(NA, 100),
                           K = rep(NA, 100),
                           N0 = rep(NA, 100),
                           t_lag = rep(NA, 100))
  
  ######Linear Model######
  #quadratic linear model
  tryCatch(
    q_model <- lm(temp_df$PopBio ~ poly(temp_df$Time, 2, raw = TRUE))
  )
  
  #cubic linear model
  tryCatch(
    c_model <- lm(temp_df$PopBio ~ poly(temp_df$Time, 3, raw = TRUE))
  )
  
cat("Starting a new 'i' loop of Model Fitting \n")

  for (j in 1:100){

    cat("Starting a new 'j' loop of Model Fitting \n")
    
  
  ####nonlinear model######

    tryCatch(
      #use nlsLM with starting value from random sampling
      {
        l_model <- nlsLM(temp_df$PopBio ~ logistic_model(t = Time, rmax, K ,N0), temp_df,
                           start = list(rmax = rmax[j],
                                        N0 = N0[j],
                                        K = K[j]),
                           control = nls.lm.control(maxiter = 100))
        #store the successful fit in the pre-allocated dataframe
        l_stats[j,] <- c(aic_function(l_model, temp_df),
                           bic_function(l_model, temp_df),
                           coef(l_model)["rmax"],
                           coef(l_model)["K"],
                           coef(l_model)["N0"])
        #store NA in all 5 columns of data frame if there is an error & ignore the error
      },error = function(e){l_stats[j,] <- c(rep(NA,5))},
      silent = TRUE)
    
    #store the best replication (the one with the lowest AIC) in a log best dataframe
    try(l_best <- subset(l_stats, l_stats$AIC == min(l_stats$AIC, na.rm = TRUE)))
    
    #Gompertz
    tryCatch(
      {
        
        g_model <- nlsLM(temp_df$LOGPopBio ~ gompertz_model(t = Time, rmax, K, N0, t_lag), temp_df,
                         start = list(rmax = rmax[j],
                                      K = K[j],
                                      N0 = N0[j],
                                      t_lag = t_lag[j]),
                         control = nls.lm.control(maxiter = 100))
        
  
        g_stats[j,] <- c(aic_function_forG(g_model, temp_df),
                            bic_function_forG(g_model, temp_df),
                           coef(g_model)["rmax"],
                           coef(g_model)["K"],
                           coef(g_model)["N0"],
                           coef(g_model)["t_lag"])
        #store NA in all 6 columns of data frame if there is an error & ignore the error
        }, error = function(e){g_stats[j,] <- c(rep(NA, 6))},
      slient = TRUE)
    
    try(g_best <- subset(g_stats, g_stats$AIC == min(g_stats$AIC, na.rm = TRUE)))

  }
  
  #put everyting in the pre-allocated dataframe
  #Qudratic
  pre_df$Q_AIC[i] <- aic_function(q_model, temp_df)
  pre_df$Q_BIC[i] <- bic_function(q_model, temp_df)
  pre_df$Q_intercept[i] <- coef(q_model)[1]
  pre_df$Q_slope[i] <- coef(q_model)[2]
  
  #Cubic
  pre_df$C_AIC[i] <- aic_function(c_model, temp_df)
  pre_df$C_BIC[i] <- bic_function(c_model, temp_df)
  pre_df$C_intercept[i] <- coef(c_model)[1]
  pre_df$C_slope[i] <- coef(c_model)[2]
  
  #use silent = TRUE cause some might not fit
  #Logistic
  try((pre_df$L_AIC[i] <- l_best$AIC), silent = TRUE)
  try((pre_df$L_BIC[i] <- l_best$BIC), silent = TRUE)
  try((pre_df$L_K[i] <- l_best$K), silent = TRUE)
  try((pre_df$L_Rmax[i] <- l_best$rmax), silent = TRUE)
  try((pre_df$L_N0[i] <- l_best$N0), silent = TRUE)
  
  #Gompertz
  try((pre_df$G_AIC[i] <- g_best$AIC), silent = TRUE)
  try((pre_df$G_BIC[i] <- g_best$BIC), silent = TRUE)
  try((pre_df$G_K[i] <- g_best$K), silent = TRUE)
  try((pre_df$G_N0[i] <- g_best$N0), silent = TRUE)
  try((pre_df$G_rmax[i] <- g_best$rmax), silent = TRUE)
  try((pre_df$G_tlag[i] <- g_best$t_lag), silent = TRUE)
  } 

#change all Inf and -Inf to NA
data[is.na(data) | data == "Inf" | data == "-Inf"] <- NA
#do the same for initial value df later

#change all the Inf and -Inf to NA for easier analysis
pre_df[is.na(pre_df) | pre_df == "Inf" | pre_df == "-Inf"] <- NA

#export the results and analyse it in a new script
write.csv(pre_df, "../results/Pre_analysis_data.csv", row.names = TRUE)