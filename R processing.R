library(tidyverse)
library(ggplot2)
library(modelr)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

setwd("C:/Users/Amin Gulamani/Desktop/EE Files/Data/CSV files")
bulgaria <- read.csv("Bulgaria.csv")
bulgaria1 <- read.csv("Bulgaria1.csv")

plot <- ggplot(bulgaria1) + geom_point(aes(x = Year, y = FDI))+ ylab("FDI Inflows (% of GDP)")
plot
plot <- ggplot(bulgaria1) + geom_point(aes(x = Year, y = Unemp))+ ylab("Unemployment % ILO est.")
plot

bulgaria1<- mutate(bulgaria1, "2010 or Later" = "Year" %in%c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))
fdiunemp <- ggplot(data = bulgaria1)
fdiunemp <- fdiunemp + geom_point(aes(x = FDI, y = Unemployment, color = Year < 2010), size = 5)
fdiunemp <- fdiunemp + xlab("FDI Inflows (% of GDP)") + ylab("Unemployment % ILO est.")
fdiunemp

fdiunemp <- ggplot(data = filter(bulgaria1, Year %in%c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)))
fdiunemp <- fdiunemp + geom_point(aes(x = FDI, y = Unemployment, color = Year), size = 5)
fdiunemp <- fdiunemp + xlab("FDI Inflows (% of GDP)") + ylab("Unemployment % ILO est.")
fdiunemp


#after 2013
bulg13 <- filter(bulgaria, Year %in% c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))

#Making Models
model1 <- lm(Unemp ~ netExports + FDI, family = binomial, data = filter(bulgaria, Year %in% c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)))
model2 <- lm(Unemp ~ netExports + FDI + FDI1, family = binomial, data = filter(bulgaria, Year %in% c(2011,2012,2013,2014,2015,2016,2017,2018,2019)))
model3 <- lm(Unemp ~ netExports + FDI + FDI1 + FDI2, family = binomial, data = filter(bulgaria, Year %in% c(2012,2013,2014,2015,2016,2017,2018,2019)))
model4 <- lm(Unemp ~ netExports + FDI + FDI1 + FDI2 + FDI3, family = binomial, data = filter(bulgaria, Year %in% c(2013,2014,2015,2016,2017,2018,2019)))


bulg13mod <-
  bulg13 %>%
  #filter(Year %in% c("Bailey", "Vinatieri", "Zuerlein")) %>%
  add_predictions(model = model1, var = "pred1", type = "response") %>%
  add_predictions(model = model2, var = "pred2", type = "response") %>%
  add_predictions(model = model3, var = "pred3", type = "response") %>%
  add_predictions(model = model4, var = "pred4", type = "response")

#model 1, final prediction
scatter <- ggplot(data = bulg13mod)
scatter <- scatter + geom_point(aes(x = Year, y = Unemployment, color = "Actual"))
scatter <- scatter + scale_x_continuous(limits = c(2013,2019))+scale_y_continuous(limits = c(0,15))===
scatter <- scatter + geom_point(aes(x = Year, y = pred1, color = "Model 2"))
scatter <- scatter + geom_point(aes(x = Year, y = pred2, color = "Model 1"))
scatter <- scatter + geom_point(aes(x = Year, y = pred3, color = "Model 3"))
scatter <- scatter + geom_point(aes(x = Year, y = pred4, color = "Model 4"))
scatter <- scatter + labs(colour = "Legend")
scatter <- scatter + xlab("Year") + ylab("Unemployment % ILO est.")
scatter


summary(model4)
summary(model3)
summary(model2)
summary(model1)

tab_model(model4)
tab_model(model3)
tab_model(model2)
tab_model(model1)

#VAR Models
#
#
#Making Models
modelA <- lm(Unemp ~ netExports1 + FDI1+Unemp1, family = binomial, data = filter(bulgaria, Year %in% c(2011,2012,2013,2014,2015,2016,2017,2018,2019)))
modelB <- lm(Unemp ~ netExports1 + FDI1 + FDI2 +netExports2+Unemp1+Unemp2, family = binomial, data = filter(bulgaria, Year %in% c(2012,2013,2014,2015,2016,2017,2018,2019)))
modelC <- lm(Unemp ~ FDI1 + Unemp1, family = binomial, data = filter(bulgaria, Year %in% c(2011, 2012,2013,2014,2015,2016,2017,2018,2019)))
modelD <- lm(Unemp ~ FDI1 + FDI2 + Unemp1 + Unemp2, family = binomial, data = filter(bulgaria, Year %in% c(2012, 2013,2014,2015,2016,2017,2018,2019)))


VAR <-
  bulg13 %>%
  #filter(Year %in% c("Bailey", "Vinatieri", "Zuerlein")) %>%
  add_predictions(model = modelA, var = "pred1", type = "response") %>%
  add_predictions(model = modelB, var = "pred2", type = "response") %>%
  add_predictions(model = modelC, var = "pred3", type = "response") %>%
  add_predictions(model = modelD, var = "pred4", type = "response") 

#model 1, final prediction
scatter <- ggplot(data = VAR)
scatter <- scatter + geom_point(aes(x = Year, y = Unemp, color = "Actual"))
scatter <- scatter + scale_x_continuous(limits = c(2013,2019))+scale_y_continuous(limits = c(0,15))
scatter <- scatter + geom_point(aes(x = Year, y = pred1, color = "Model A"))
scatter <- scatter + geom_point(aes(x = Year, y = pred2, color = "Model B"))
scatter <- scatter + geom_point(aes(x = Year, y = pred3, color = "Model C"))
scatter <- scatter + geom_point(aes(x = Year, y = pred4, color = "Model D"))
scatter <- scatter + labs(colour = "Legend")
scatter <- scatter + xlab("Year") + ylab("Unemployment % ILO est.")
scatter
VAR

write_csv(VAR, "VAR.csv", append = FALSE)

summary(modelA)
summary(modelB)
summary(modelC)
summary(modelD)


tab_model(modelA)
tab_model(modelB)
tab_model(modelC)
tab_model(modelD)
=