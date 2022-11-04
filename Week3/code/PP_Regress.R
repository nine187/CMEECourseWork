#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: PP_Dists.R
#Created: Oct 2022
#Desc: Practical on mass ditribution

require(ggplot2)
require(dplyr)

#clear the list
rm(list = ls())

#read the data
DF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# use ggplot to create the plots seperating the data by types of feeding
DF <- ggplot(DF, aes(x = Prey.mass, y = Predator.mass, colour = Predator.lifestage, extends(maybe = TRUE)))+
  geom_point(shape = 3)+
  facet_grid(rows = vars(Type.of.feeding.interaction))+
  theme_bw() +
  xlab("Prey mass in grams")+
  ylab("Predator mass in grams")+
  theme(panel.grid.minor = element_blank(), legend.position = "bottom")+
  scale_y_continuous(trans = 'log10')+
  scale_x_continuous(trans = 'log10')+
 
#output the plot to a new pdf
pdf("../results/PP_Regress_Results.pdf")
print(DF)
dev.off()

#convert mg to g
DF$Prey.mass[which(DF$Prey.mass.unit=="mg")] <- DF$Prey.mass[which(DF$Prey.mass.unit=="mg")]/1000
DF$Prey.mass.unit[which(DF$Prey.mass.unit=="mg")] <- "g"
graphics.off()

#csv
DF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

#linear model using dlply
Lm_output <- dlply(DF,.(Predator.lifestage, Type.of.feeding.interaction), 
                      function(x) lm(Predator.mass~Prey.mass, data = x))

# pull the output of intercept and slope (first coefficient is intercept(y), second 
# coefficient is slope(m), y=mx+c)
reg_res <-ldply (Lm_output, function(x) {
  slope <- summary(x)$coefficients[2]
  intercept <- summary(x)$coefficients[1]
  data.frame(slope, intercept)})

# output to result file
write.csv(reg_res, "../results/PP_Regress_Results.csv")