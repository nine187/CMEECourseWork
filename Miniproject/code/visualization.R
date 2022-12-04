rm(list=ls())
library(ggplot2)
library(gtable)
library(gridExtra)
library(grid)
library(viridis)

data <- read.csv("../results/Wrangled_Data.csv", header = TRUE)
#model_fitting <- read.csv("../results/Pre_analysis_data.csv", header = TRUE)
tally_AICc <- read.csv("../results/AICc_tallies.csv", header = TRUE)
tally_AIC <- read.csv("../results/AIC_tallies.csv", header = TRUE)
tally_BIC <- read.csv("../results/BIC_tallies.csv", header = TRUE)
tally_AICc$percentage <- factor(tally_AICc$percentage, levels = tally_AICc$percentage)
Citation_1 <- read.csv("../results/Cite1_tallies.csv")
Citation_2 <- read.csv("../results/Cite2_tallies.csv")
Citation_3 <- read.csv("../results/Cite3_tallies.csv")
Citation_4 <- read.csv("../results/Cite4_tallies.csv")
Citation_5 <- read.csv("../results/Cite5_tallies.csv")
Citation_6 <- read.csv("../results/Cite6_tallies.csv")
Citation_7 <- read.csv("../results/Cite7_tallies.csv")
Citation_8 <- read.csv("../results/Cite8_tallies.csv")
Citation_9 <- read.csv("../results/Cite9_tallies.csv")
Citation_10 <- read.csv("../results/Cite10_tallies.csv")

################visualizing the tallies for AICc###########

#AICc
tally_AICc$Model <- factor(tally_AICc$Model, levels = tally_AICc$Model)
# Generate barplot of tallies
p1 <- ggplot(tally_AICc , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
      y = " Number of Models Fitted",
      title = "AICc")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Quadratic" ,"Cubic", "Logistic", "Gompertz")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#p1

#AIC
tally_AIC$Model <- factor(tally_AIC$Model, levels = tally_AIC$Model)
p2 <- ggplot(tally_AIC , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
       y = " Number of Models Fitted",
       title= "AIC")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Quadratic" ,"Cubic", "Logistic", "Gompertz")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank(),
        plot.title = element_text(hjust = 0.5))+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#p2

#BIC
tally_BIC$Model <- factor(tally_BIC$Model, levels = tally_BIC$Model)
p3 <- ggplot(tally_BIC , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
       y = " Number of Models Fitted",
       title= "BIC")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Quadratic" ,"Cubic", "Logistic", "Gompertz")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank(),
        plot.title = element_text(hjust = 0.5))+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#p3

#combine the plots
cat("Arranging diagram 1")
p <- grid.arrange(
  p1,
  p2,
  p3,
  nrow = 1,
  bottom = textGrob(
    "",
    gp = gpar(fontface = 3, fontsize = 9),
    hjust = 1,
    x = 1
  )
)

#p
ggsave("../results/All_barplot.png", p, dpi = 1500, width = 12, height = 8)

#############visualization of BIC value for each citation################
#dont loop cause need to modify each graph visual
c1 <- ggplot(Citation_1 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Bae et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c1

c2 <- ggplot(Citation_2 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 1, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Bernhardt et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c2

c3 <- ggplot(Citation_3 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Galarz et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c3

c4 <- ggplot(Citation_4 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Gill et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c4

c5 <- ggplot(Citation_5 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 0.5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Phillips et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c5

c6 <- ggplot(Citation_6 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 1, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Roth et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c6

c7 <- ggplot(Citation_7 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 1, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Silva et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c7

c8 <- ggplot(Citation_8 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 1, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Sivonen et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c8

c9 <- ggplot(Citation_9 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 0.5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Stannard et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))
#c9

c10 <- ggplot(Citation_10 , aes(Model, Tally, fill = Model)) + 
  geom_text(aes(label = Tally), nudge_y = 0.5, size = 3) + 
  labs(x = "Models",
       y = "Models Fitted",
       title = "Zwietering et al.")+
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, 
                     labels = c("Cubic", "Gompertz", "Logistic", "Quadratic")) +
  geom_bar(stat = "identity", position = "Dodge") +
  theme(panel.background = element_rect(fill = "transparent"),
        axis.ticks.x = element_blank())+
  theme_bw() +
  theme(legend.position = "left",
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5))

cat("Arranging diagram 2")
#combine all 10 citations
c <- grid.arrange(
  c1,
  c2,
  c3,
  c4,
  c5,
  c6,
  c7,
  c8,
  c9,
  c10,
  nrow = 4,
  bottom = textGrob(
    "",
    gp = gpar(fontface = 3, fontsize = 9),
    hjust = 1,
    x = 1
  )
)
ggsave("../results/All_citebarplot.png", c, dpi = 100, width = 10, height = 10)