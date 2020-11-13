library(tidyverse)
library(ggplot2)
library(modelr)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

setwd("C:/Users/Amin Gulamani/Desktop/FEH PowerCreep")
funits <- read.csv("funits.csv")

model <- lm(Hibst ~ DSR, family = binomial, data = funits)
modelA <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Armored"))
modelC <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Cavalry"))
modelF <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Flying"))
modelI <- lm(Hibst ~ DSR, family = binomial, data = filter(funits, MT == "Infantry"))
summary(model)
tab_model(modelA)
tab_model(modelC)
tab_model(modelF)
tab_model(modelI)

funitsI <- (filter(funits, MT == "Infantry"))
funitsIR <- (filter(funits, MT == "Infantry", Range == "Ranged"))
funitsIM <- (filter(funits, MT == "Infantry", Range == "Melee"))

plot <- ggplot(filter(funits, MT == "Infantry"))  + geom_point(aes(x = DSR, y = Hibst, colour = Ratings))
plot


plot <- ggplot(funitsI, aes(x = DSR, y = Hibst, color = Range))+ geom_point()
plot <- plot + stat_smooth(method = "lm", data = funitsIR, formula = y ~ poly(x, 2), size = 1) +
                stat_smooth(method = "lm", data = funitsIM, formula = y ~ poly(x, 2), size = 1)
plot

plot <- ggplot(funits) + geom_point(aes(x = DSR, y = Lowbst))+ geom_point(aes(x = DSR, y = Hibst, color = 'red'))
plot <- plot + geom_abline(intercept = 1.514e+02, slope = 1.138e-02) + geom_abline(intercept = 1.528e+02, slope = 1.158e-02, color = 'red')
plot


