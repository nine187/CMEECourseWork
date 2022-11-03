#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: PP_Dists.R
#Created: Oct 2022
#Desc:

rm(list = ls())
library(ggplot2)
library(tidyverse)

#read the data
DF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dplyr::glimpse(DF)

log_pd_mass = log(DF$Predator.mass)
log_py_mass = log(DF$Prey.mass)
py_pd_rat = (DF$Prey.mass/DF$Predator.mass)
log_rat = log(py_pd_rat)


DF2 = data.frame(DF$Type.of.feeding.interaction, log_pd_mass,log_py_mass, log_rat, py_pd_rat)

#convert mg to g
for (i in 1:nrow(DF)){
  if (DF$Prey.mass.unit[i] == "mg"){
    DF$Prey.mass.unit[i] = "g"
    DF$Prey.mass[i] = DF$Prey.mass[i] / 1000
  }
}

#figure 1: Predator Subplot
#add description and explaination later
pd_ins <- ggplot(data = subset(DF, Type.of.feeding.interaction == "insectivorous"))+
  geom_histogram(aes(log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of predator mass")+
  ylab("Frequency")+
  ggtitle("Insectivorous")
pd_ins

pd_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "piscivorous"))+
  geom_histogram(aes(log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of predator mass")+
  ylab("Frequency")+
  ggtitle("Piscivorous")
pd_pis

pd_pla <- ggplot(data = subset(DF, Type.of.feeding.interaction == "planktivorous"))+
  geom_histogram(aes(log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of predator mass")+
  ylab("Frequency")+
  ggtitle("Piscivorous")
pd_pla

pd_pre <- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious"))+
  geom_histogram(aes(log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of predator mass")+
  ylab("Frequency")+
  ggtitle("Predacious")
pd_pla

pd_pre_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious/piscivorous"))+
  geom_histogram(aes(log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of predator mass")+
  ylab("Frequency")+
  ggtitle("Predacious/piscivorous")
pd_pre_pis

pd_main <- ggarrange(pd_ins, pd_pis, pd_pla, pd_pre, pd_pre_pis, labels="AUTO")

annotate_figure(pd_main, top = "Predator Subplot")

pdf("../results/Prey_Subplots.pdf")
print(pd_main)
dev.off()

#figure 2: Prey Subplot

py_ins <- ggplot(data = subset(DF, Type.of.feeding.interaction == "insectivorous"))+
  geom_histogram(aes(log(Prey.mass)), color="blue", size = 5, bins=30)+
  xlab("log of prey mass")+
  ylab("Frequency")+
  ggtitle("Insectivorous")
py_ins

py_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "piscivorous"))+
  geom_histogram(aes(log(Prey.mass)), color="blue", size = 5, bins=30)+
  xlab("log of prey mass")+
  ylab("Frequency")+
  ggtitle("Piscivorous")
py_pis

py_pla <- ggplot(data = subset(DF, Type.of.feeding.interaction == "planktivorous"))+
  geom_histogram(aes(log(Prey.mass)), color="blue", size = 5, bins=30)+
  xlab("log of prey mass")+
  ylab("Frequency")+
  ggtitle("Planktivorous")
py_pla

py_pre <- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious"))+
  geom_histogram(aes(log(Prey.mass)), color="blue", size = 5, bins=30)+
  xlab("log of prey mass")+
  ylab("Frequency")+
  ggtitle("Predacious")
py_pre

py_pre_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious/piscivorous"))+
  geom_histogram(aes(log(Prey.mass)), color="blue", size = 5, bins=30)+
  xlab("log of prey mass")+
  ylab("Frequency")+
  ggtitle("Predacious/piscivorous")
py_pre_pis

py_main <- ggarrange(py_ins, py_pis, py_pla, py_pre, py_pre_pis, labels="AUTO")

annotate_figure(pd_main, top = "Prey Subplot")

pdf("../results/Prey_Subplots.pdf")
print(py_main)
dev.off()

#figure 3: Size-Ratio Subplot

rat_ins <- ggplot(data = subset(DF, Type.of.feeding.interaction == "insectivorous"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Insectivorous")
rat_ins

rat_ins <- ggplot(data = subset(DF, Type.of.feeding.interaction == "insectivorous"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Insectivorous")

rat_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "piscivorous"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Piscivorous")
rat_pis

rat_pla <- ggplot(data = subset(DF, Type.of.feeding.interaction == "planktivorous"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Planktivorous")
rat_pla

rat_pre<- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Predacious")
rat_pre

rat_pre_pis <- ggplot(data = subset(DF, Type.of.feeding.interaction == "predacious/piscivorous"))+
  geom_histogram(aes(log(Prey.mass)/log(Predator.mass)), color="blue", size = 5, bins=30)+
  xlab("log of the prey/predator mass ratio")+
  ylab("Frequency")+
  ggtitle("Predacious/piscivorous")
rat_pre_pis

rat_main <- ggarrange(rat_ins, rat_pis, rat_pla, rat_pre, rat_pre_pis, labels="AUTO")

annotate_figure(rat_main, top = "Ratio of Prey and Predator Distribution Plots")

pdf("../results/Prey_Subplots.pdf")
print(rat_main)
dev.off()

#calculate the log of mean,median,feeding types, other variables into a csv file
PP_csv1 = names(table(DF2$DF.Type.of.feeding.interaction))
ins = subset(DF2,DF2$DF.Type.of.feeding.interaction == "insectivorous")
pis = subset(DF2, DF2$DF.Type.of.feeding.interaction == "piscivorous")
pla = subset(DF2, DF2$DF.Type.of.feeding.interaction == "planktivorous")
pre = subset(DF2,DF2$DF.Type.of.feeding.interaction == "predacious")
pre_pis = subset(DF2,DF2$DF.Type.of.feeding.interaction == "predacious/piscivorous")
log_py_means = c(mean(ins$log_py_mass), mean(pis$log_py_mass), mean(pla$log_py_mass), mean(pre$log_py_mass), mean(pre_pis$log_py_mass))
log_py_medians = c(median(ins$log_py_mass), median(pis$log_py_mass), median(pla$log_py_mass), median(pre$log_py_mass), median(pre_pis$log_py_mass))
log_pd_means = c(mean(ins$log_pd_mass), mean(pis$log_pd_mass), mean(pla$log_pd_mass), mean(pre$log_pd_mass), mean(pre_pis$log_pd_mass))
log_pd_medians = c(median(ins$log_pd_mass), median(pis$log_pd_mass), median(pla$log_pd_mass), median(pre$log_pd_mass), median(pre_pis$log_pd_mass))
log_rat_means = c(mean(ins$log_rat), mean(pis$log_rat),mean(pla$log_rat),mean(pre$log_rat), mean(pre_pis$log_rat))
log_rat_medians = c(median(ins$log_rat), median(pis$log_rat),median(pla$log_rat),median(pre$log_rat), median(pre_pis$log_rat))

PP_res = data.frame(type = PP_csv1, log_py_means, log_py_medians, log_pd_means, log_pd_medians, log_rat_means, log_rat_medians)
write.csv(PP_res, "../results/PP_Results.csv")

