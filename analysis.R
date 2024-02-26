library(tidyverse)
library(agricolae)
library(lme4)
library(emmeans)
library(reshape)
library(reshape2)
library(car)

df <- readxl::read_excel("./input/SCASI_Field_Trials_Data_2022ALL_20230409_Adama.xlsx",sheet = "MergePart2Part1")
head(df)

# Wheat
df <- df %>% filter(Plot_crop=="Wheat")

# Homogeneity of variance
leveneTest(GrainYield~Woreda, data=df)

# Convert to factor
df$Rep <- as.factor(df$Rep)
df$Treatment <- as.factor(df$Treatment)
df$Woreda <- as.factor(df$Woreda)

# Analysis of variance
model <- lm(GrainYield~ Treatment + Woreda + (Treatment:Woreda) +
              (Woreda:Rep),data=df)
anova(model)

# Posthoc analysis
ls <- LSD.test(y=model,trt="Treatment")
lsdst<- ls$statistics
ls <- ls$groups
print(ls)
