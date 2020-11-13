library(tidyverse)
library(ggplot2)
library(modelr)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

setwd("C:/Users/Amin Gulamani/Desktop/FEH PowerCreep")
funits <- read.csv("funits.csv")
funits <-
  funits %>%
  mutate(DSR2 = DSR * DSR)


model <- lm(Hibst ~ DSR, family = binomial, data = funits)
modelA <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Armored"))
modelC <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Cavalry"))
modelF <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Flying"))
modelI <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Infantry"))
summary(modelIR2)
tab_model(modelIR2)
tab_model(modelC)
tab_model(modelF)
tab_model(modelI)


plot <- ggplot(filter(funits, MT == "Infantry"))  + geom_point(aes(x = DSR, y = Hibst, colour = Range))
plot <- plot + geom_abline(intercept = 1.464e+02, slope = 1.407e-02)
plot <- plot + geom_abline(intercept = 1.570e+02, slope = 1.352e-02)
plot

funitsIR <- filter(funits, MT == "Infantry", Range== "Ranged")
funitsIM <- filter(funits, MT == "Infantry", Range== "Melee")
plot <- ggplot(filter(funits, MT == "Infantry"), aes(x = DSR, y = Hibst, colour = Range)) + geom_point()
#plot <- plot + geom_abline(intercept = 1.570e+02, slope = 1.352e-02)
plot <- plot + stat_smooth(data = funitsIR, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="purple")+
                stat_smooth(data = funitsIM, method="lm", se=TRUE,
                           formula= y ~ poly(x, 2, raw=TRUE),colour="blue")
plot





modelIM <- lm(Hibst ~ DSR, family = binomial, data = funitsIM)
modelIR <- lm(Hibst ~ DSR, family = binomial, data = funitsIR)
modelIR2 <- lm(Hibst ~ DSR + DSR2, family = binomial, data = filter(funits, MT == "Infantry", Range== "Ranged"))



plot <- ggplot(funits)  + geom_point(aes(x = DSR, y = Hibst, colour = Range))
plot <- plot + geom_abline(intercept = 1.528e+02, slope = 1.158e-02)
plot

plot <- ggplot(funits) + geom_point(aes(x = DSR, y = Lowbst))+ geom_point(aes(x = DSR, y = Hibst, color = 'red'))
plot <- plot + geom_abline(intercept = 1.514e+02, slope = 1.138e-02) + geom_abline(intercept = 1.528e+02, slope = 1.158e-02, color = 'red')
plot


