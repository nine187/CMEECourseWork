#!/usr/bin/env R

# Title: PP_regress_loc.R
# Author details: Dashing_Dogins
# Date: Nov 2022

#package loading
require(tidyverse)


#load data
MyDF <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))
#check title names
dplyr::glimpse(MyDF)

#define function to do regression analysis, then store parameters needed
linear_regression<-function(input_data){
    regressionlm<-lm(log(Predator.mass)~log(Prey.mass),data= input_data)
    sum_parameters<-summary(regressionlm)
    parameters<-data.frame(Intercept = sum_parameters$coeff[1],
    Slope = sum_parameters$coeff[2],
    r_squared = sum_parameters$r.squared,
    F.value = sum_parameters$coefficients[,'t value'],
    p.value = sum_parameters$coefficients[,'Pr(>|t|)'])
    return(parameters)
}


results <- data.frame()
#apply linear_regression on selected factors
results <- MyDF %>%
  group_by(Type.of.feeding.interaction, Predator.lifestage, Location) %>%
  group_modify(~ linear_regression(.))

head(results)

#save results to csv
write.csv(results, "../results/PP_Regress_loc_Results.csv")