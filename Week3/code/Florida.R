# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: Florida.R
# Desc: Practical question for Florida
# Date: Oct 2022

rm(list=ls())
library(ggplot2)
load("../data/KeyWestAnnualMeanTemperature.RData")

#look at the data
ls()
class(ats)
head(ats)

#plot the temp and year, using base R plot
pdf("../sandbox/Florida_diagram2.pdf")
plot(ats$Year,
     ats$Temp, 
     xlab = "Year",
     ylab = "Temp (Celcius)",
     type = "l",
     col = "red")
dev.off()

#using the cor function to find the correlation coefficient b/w the year and temp with spearman method
cor_1 <- cor(ats$Year, ats$Temp, method = "spearman") 
cor_1

# reshuffle temperature data 1000 times, ensure same randomization
set.seed(1000)
cor_p <- data.frame(matrix(unlist(replicate(1000, {
  #shuffle the temperature data, without replacing the data
  temp_shuffle <- sample(ats$Temp, replace = F)
  #use cor function to find correlation of year with the new shuffled data with pearson method
  cor(ats$Year, temp_shuffle, method = c("spearman"))
}))))
#print all 1000 shuffled temp and year correlation
cor_p

#find the average asymptotic p-value by finding the sum of all correlation whether it is 
#larger than the original correlation value and then divided by the amount of
#time we shuffle the data
avg_p_value <- (sum(cor_p$matrix.unlist.replicate.1000... > cor_1))/1000

#result is zero, most observed correlation is higher than all the random 
#correlation coefficient
avg_p_value

#visualization with ggplot the histogram of 1000 permutation tests
diagram <- ggplot()+
  geom_histogram(data = cor_p,aes(matrix.unlist.replicate.1000...), fill = "blue", size = 1, bins=30)+
  xlab("Correlation Coefficient")+
  ylab("Frequency")
pdf("../sandbox/Florida_diagram.pdf")
print(diagram)
dev.off()