#Author: Dashing Dingos
#Script: TAutoCorr.R
#Created: Dec 2022
#Desc: Groupwork Practical

rm(list=ls())
data <- load("../data/KeyWestAnnualMeanTemperature.RData")

#plot the graph 
png("../results/TAuto1.png")
plot(ats$Year,
     ats$Temp, 
     xlab = "Year",
     ylab = "Temp (Celcius)",
     type = "l",
     col = "red")
dev.off()

#create 2 df
ats_2 <- data.frame(Temp1 = ats$Temp[1:length(ats$Temp)-1], 
                    Temp2 = ats$Temp[2:length(ats$Temp)])

#calculate the correlation b/w the successive year, spearman method
cor_1 <- cor(ats_2$Temp1, ats_2$Temp2, method = "spearman")

#repeat this calculation 10000 times, recalculating the correlation coefficiency 
#and store it in the dataframe
#ensure same number is randomized each time
set.seed(1000)

#creates empty df 
temp <- replicate(10000,  sample(ats$Temp,replace = F))

#test the correlation for the permuation
cor_2 <- vector("numeric", 10000)
for (i in 1 : 10000) {
  random_temp <- cor(temp[2:100,i], temp[1:99,i], method = "spearman")
  cor_2[i] <- random_temp
}

#plot the histogram of the correlation coefficient
png(file="../results/TAuto2.png",
    width=1000, height=600)
hist(cor_2,
     col = "red",
     main = "Histogram of correlation coefficients with 10000 permutated sequence",
     ylim = c(0, 2000),
     axes = TRUE)
dev.off()

#calculate the p-value, the number how many permutation test is more than
#the observed data divided by the number of test
fraction = length(cor_2[cor_2>cor_1])/10000

#option to remove E-notation in fraction
options(scipen = 100, digits = 4)

paste("The sucessive year correlation is", round(cor_1, digits = 3),
      "and the p-value is", fraction)