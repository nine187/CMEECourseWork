rm(list=ls())
source("functions.R")
library(dplyr)
#used to calculate percentage (percent())
library(formattable)
data <- read.csv("../results/Pre_analysis_data.csv", header = TRUE)
data_raw <- read.csv("../results/Wrangled_Data.csv",header = TRUE)

#Change all the zeroes to NA
data[is.na(data) | data == 0 | data == 0] <- NA

#############1. Calculate the percentage of each individual models and how many fitted in the data############

#percentage of how many individual model(i.e. linear) fit within each unique ID
#AIC
#Quadratic
#percent of how many fitted (not equal to zero) over all 285 datasets
percent((length(which(data$Q_AIC != 0)))/285)
#Cubic
percent(length(which(data$C_AIC != 0))/285)
#Logistic
percent(length(which(data$L_AIC != 0))/285)
#Gompertz
percent(length(which(data$G_AIC != 0))/285)
#interestingly Gompertz fitted the lowest

percent((length(which(data$Q_BIC != 0)))/285)
#Cubic
percent(length(which(data$C_BIC != 0))/285)
#Logistic
percent(length(which(data$L_BIC != 0))/285)
#Gompertz
percent(length(which(data$G_BIC != 0))/285)
#interestingly Gompertz fitted the lowest

#see how many unique variables are there for citation, medium, and species
#try to categorize 
length(unique(data$Cite))
#10
length(unique(data$Medium))
#18
length(unique(data$Species))
#45 

#going to try and find out which model works best for each citation cause it got the lowest variation
#might be reasonable to do considering the time I have left..

######################Calculating ACCc########################

#extract AIC and BIC value of each model into a new dataframe with subset

AIC_all <- data.frame(ID = c(1:285),
                      Q_AIC = rep(0,285),
                      C_AIC = rep(0,285),
                      L_AIC = rep(0,285),
                      G_AIC = rep(0,285),
                      Best_fit = rep(0,285),
                      cite = rep(0,285))

BIC_all <- data.frame(ID = c(1:285),
                     Q_BIC = rep(0,285),
                     C_BIC = rep(0,285),
                     L_BIC = rep(0,285),
                     G_BIC = rep(0,285),
                     Best_fit = rep(0, 285),
                     cite = rep(0,285))

#creates a new data frame to store the AICc values
AICc_all <- data.frame(ID = c(1:285),
                       Q_AICc = rep(0,285),
                       C_AICc = rep(0,285),
                       L_AICc = rep(0,285),
                       G_AICc = rep(0,285),
                       Best_fit = rep(0,285),
                       cite = rep(0,285))

#move all the AIC and BIC values to the separate table 
AIC_all$Q_AIC <- data$Q_AIC
AIC_all$C_AIC <- data$C_AIC
AIC_all$L_AIC <- data$L_AIC
AIC_all$G_AIC <- data$G_AIC
AIC_all$cite <- data$Cite

BIC_all$Q_BIC <- data$Q_BIC
BIC_all$C_BIC <- data$C_BIC
BIC_all$L_BIC <- data$L_BIC
BIC_all$G_BIC <- data$G_BIC
BIC_all$cite <- data$Cite
#calculate the AICc for each models

#for every unique ID in the list
for (i in unique(AICc_all$ID)) {
  #try and use the AICc function on the 
  #browser()
  try(AICc_all$Q_AICc[i] <- aicc_function
                                          (AIC = AIC_all$Q_AIC[i],
                                            k = 4, 
                                            n = AIC_all$Q_AIC[i]))
  
  try(AICc_all$C_AICc[i] <- aicc_function(AIC = AIC_all$C_AIC[i],
                                          k = 4,
                                          n = AIC_all$C_AIC[i]))
  
  try(AICc_all$L_AICc[i] <- aicc_function(AIC = AIC_all$L_AIC[i],
                                             k = 4,
                                             n = AIC_all$L_AIC[i]))
  
  try(AICc_all$G_AICc[i] <- aicc_function(AIC = AIC_all$G_AIC[i],
                                            k = 4,
                                            n = AIC_all$G_AIC[i]))

}

########Percentage of which model won for AICc####################
#find out which AICc value is the lowest
#use tally to calculate the model
for ( i in unique(AICc_all$ID)){
  #find the minimum AIC from all the columns selected
  AICc_all$Best_fit[i] <- which.min(AIC_all[i,2:5])
  
  if (AICc_all[i,2]== AICc_all[i,3] &
      AICc_all[i,2]== AICc_all[i,4]&
      AICc_all[i,2]== AICc_all[i,5]) {
    AIC_all$Best_fit[i] <0
  }
}

#tally all the AICc count in each model
tallies <- c(length(AICc_all$Best_fit[which(AICc_all$Best_fit == 1)]),
             length(AICc_all$Best_fit[which(AICc_all$Best_fit == 2)]),
             length(AICc_all$Best_fit[which(AICc_all$Best_fit == 3)]),
             length(AICc_all$Best_fit[which(AICc_all$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_AICc", "C_AICc", "L_AICc", "G_AICc"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
#export the results
write.csv(tally_table, "../results/AICc_tallies.csv")



#Tally AIC
for ( i in unique(AIC_all$ID)){
  #find the minimum AIC from all the columns selected
  AIC_all$Best_fit[i] <- which.min(AIC_all[i,2:5])
  #
  if (AIC_all[i,2]== AIC_all[i,3] &
      AIC_all[i,2]== AIC_all[i,4]&
      AIC_all[i,2]== AIC_all[i,5]) {
    AIC_all$Best_fit[i] <0
  }
}

#tally all the AICc count in each model
tallies <- c(length(AIC_all$Best_fit[which(AIC_all$Best_fit == 1)]),
             length(AIC_all$Best_fit[which(AIC_all$Best_fit == 2)]),
             length(AIC_all$Best_fit[which(AIC_all$Best_fit == 3)]),
             length(AIC_all$Best_fit[which(AIC_all$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_AIC", "C_AIC", "L_AIC", "G_AIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/AIC_tallies.csv")

#Tally BIC
for ( i in unique(BIC_all$ID)){
  #find the minimum AIC from all the columns selected
  BIC_all$Best_fit[i] <- which.min(BIC_all[i,2:5])
  if (BIC_all[i,2]== BIC_all[i,3] &
      BIC_all[i,2]== BIC_all[i,4]&
      BIC_all[i,2]== BIC_all[i,5]) {
    BIC_all$Best_fit[i] <0
  }
}

#tally all the AICc count in each model
tallies <- c(length(BIC_all$Best_fit[which(BIC_all$Best_fit == 1)]),
             length(BIC_all$Best_fit[which(BIC_all$Best_fit == 2)]),
             length(BIC_all$Best_fit[which(BIC_all$Best_fit == 3)]),
             length(BIC_all$Best_fit[which(BIC_all$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/BIC_tallies.csv")

########################seperate by citation#########################
#better loop!(no time)
#seperate the main dataframe into 10 different citation subset for BIC
Citation_1 <- subset(BIC_all, cite=='Bae, Y.M., Zheng, L., Hyun, J.E., Jung, K.S., Heu, S. and Lee, S.Y., 2014. Growth characteristics and biofilm formation of various spoilage bacteria isolated from fresh produce. Journal of food science, 79(10), pp.M2072-M2080.')
Citation_2 <- subset(BIC_all, cite=='Bernhardt, J.R., Sunday, J.M. and O’Connor, M.I., 2018. Metabolic theory and the temperature-size rule explain the temperature dependence of population carrying capacity. The American naturalist, 192(6), pp.687-697.')
Citation_3 <- subset(BIC_all, cite=='Galarz, L.A., Fonseca, G.G. and Prentice, C., 2016. Predicting bacterial growth in raw, salted, and cooked chicken breast fillets during storage. Food Science and Technology International, 22(6), pp.461-474.')
Citation_4 <- subset(BIC_all, cite=='Gill, C.O. and DeLacy, K.M., 1991. Growth of Escherichia coli and Salmonella typhimurium on high-pH beef packed under vacuum or carbon dioxide. International journal of food microbiology, 13(1), pp.21-30.')
Citation_5 <- subset(BIC_all, cite=='Phillips, J.D. and Griffiths, M.W., 1987. The relation between temperature and growth of bacteria in dairy products. Food Microbiology, 4(2), pp.173-185.')
Citation_6 <- subset(BIC_all, cite=='Roth, N.G. and Wheaton, R.B., 1962. Continuity of psychrophilic and mesophilic growth characteristics in the genus Arthrobacter. Journal of bacteriology, 83(3), pp.551-555.')
Citation_7 <- subset(BIC_all, cite=='Silva, A.P.R.D., Longhi, D.A., Dalcanton, F. and Aragão, G.M.F.D., 2018. Modelling the growth of lactic acid bacteria at different temperatures. Brazilian Archives of Biology and Technology, 61.')
Citation_8 <- subset(BIC_all, cite=='Sivonen, K., 1990. Effects of light, temperature, nitrate, orthophosphate, and bacteria on growth of and hepatotoxin production by Oscillatoria agardhii strains. Appl. Environ. Microbiol., 56(9), pp.2658-2666.')
Citation_9 <- subset(BIC_all, cite=='Stannard, C.J., Williams, A.P. and Gibbs, P.A., 1985. Temperature/growth relationships for psychrotrophic food-spoilage bacteria. Food Microbiology, 2(2), pp.115-122.')
Citation_10 <- subset(BIC_all, cite=='Zwietering, M.H., De Wit, J.C., Cuppers, H.G.A.M. and Van\'t Riet, K., 1994. Modeling of bacterial growth with shifts in temperature. Appl. Environ. Microbiol., 60(1), pp.204-213.')

###tallying for each citation dataframe###
#citation 1
#tally all the AICc count in each model
tallies <- c(length(Citation_1$Best_fit[which(Citation_1$Best_fit == 1)]),
             length(Citation_1$Best_fit[which(Citation_1$Best_fit == 2)]),
             length(Citation_1$Best_fit[which(Citation_1$Best_fit == 3)]),
             length(Citation_1$Best_fit[which(Citation_1$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite1_tallies.csv")

#citation 2
tallies <- c(length(Citation_2$Best_fit[which(Citation_2$Best_fit == 1)]),
             length(Citation_2$Best_fit[which(Citation_2$Best_fit == 2)]),
             length(Citation_2$Best_fit[which(Citation_2$Best_fit == 3)]),
             length(Citation_2$Best_fit[which(Citation_2$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite2_tallies.csv")

#citation3
tallies <- c(length(Citation_3$Best_fit[which(Citation_3$Best_fit == 1)]),
             length(Citation_3$Best_fit[which(Citation_3$Best_fit == 2)]),
             length(Citation_3$Best_fit[which(Citation_3$Best_fit == 3)]),
             length(Citation_3$Best_fit[which(Citation_3$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite3_tallies.csv")

#citation4
tallies <- c(length(Citation_4$Best_fit[which(Citation_4$Best_fit == 1)]),
             length(Citation_4$Best_fit[which(Citation_4$Best_fit == 2)]),
             length(Citation_4$Best_fit[which(Citation_4$Best_fit == 3)]),
             length(Citation_4$Best_fit[which(Citation_4$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite4_tallies.csv")

#citation5
tallies <- c(length(Citation_5$Best_fit[which(Citation_5$Best_fit == 1)]),
             length(Citation_5$Best_fit[which(Citation_5$Best_fit == 2)]),
             length(Citation_5$Best_fit[which(Citation_5$Best_fit == 3)]),
             length(Citation_5$Best_fit[which(Citation_5$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite5_tallies.csv")

#citation6
tallies <- c(length(Citation_6$Best_fit[which(Citation_6$Best_fit == 1)]),
             length(Citation_6$Best_fit[which(Citation_6$Best_fit == 2)]),
             length(Citation_6$Best_fit[which(Citation_6$Best_fit == 3)]),
             length(Citation_6$Best_fit[which(Citation_6$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite6_tallies.csv")

#citation7
tallies <- c(length(Citation_7$Best_fit[which(Citation_7$Best_fit == 1)]),
             length(Citation_7$Best_fit[which(Citation_7$Best_fit == 2)]),
             length(Citation_7$Best_fit[which(Citation_7$Best_fit == 3)]),
             length(Citation_7$Best_fit[which(Citation_7$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite7_tallies.csv")

#citation8
tallies <- c(length(Citation_8$Best_fit[which(Citation_8$Best_fit == 1)]),
             length(Citation_8$Best_fit[which(Citation_8$Best_fit == 2)]),
             length(Citation_8$Best_fit[which(Citation_8$Best_fit == 3)]),
             length(Citation_8$Best_fit[which(Citation_8$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite8_tallies.csv")

#citation9
tallies <- c(length(Citation_9$Best_fit[which(Citation_9$Best_fit == 1)]),
             length(Citation_9$Best_fit[which(Citation_9$Best_fit == 2)]),
             length(Citation_9$Best_fit[which(Citation_9$Best_fit == 3)]),
             length(Citation_9$Best_fit[which(Citation_9$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite9_tallies.csv")

#citation10
tallies <- c(length(Citation_10$Best_fit[which(Citation_10$Best_fit == 1)]),
             length(Citation_10$Best_fit[which(Citation_10$Best_fit == 2)]),
             length(Citation_10$Best_fit[which(Citation_10$Best_fit == 3)]),
             length(Citation_10$Best_fit[which(Citation_10$Best_fit == 4)]))

#tally the number of models that won and divide by overall to get the percentage
percent <- c(tallies[1] / sum(tallies),
             tallies[2] / sum(tallies),
             tallies[3] / sum(tallies),
             tallies[4] / sum(tallies))

#transform percent value into... percentage and transfer it to a table
tally_table <- data.frame(Model = c("Q_BIC", "C_BIC", "L_BIC", "G_BIC"),
                          Tally = tallies, percentage = scales::percent(percent))
#tally_table
write.csv(tally_table, "../results/Cite10_tallies.csv")