# Project 1

# How do earnings differ among California workers with no college, some college,
# and a completed bachelor's degree, and does the education premium vary by 
# occupation, industry, or demographic group?

library(tidyverse)
library(fixest)
library(modelsummary)
library(ggplot2)
library(ipumsr)

setwd("~/ca-education-wage-premium")
df <- read_csv("data/usa_00001.csv")

glimpse(df)
summary(df)
nrow(df)
names(df)