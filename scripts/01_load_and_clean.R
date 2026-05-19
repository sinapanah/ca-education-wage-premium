# Step 4 ----------------------------------------------------------------------

library(tidyverse)
library(fixest)
library(modelsummary)
library(ggplot2)
library(ipumsr)
library(estimatr)

setwd("~/ca-education-wage-premium")
df <- read_csv("data/usa_00001.csv")

glimpse(df)
summary(df)
nrow(df)
names(df)

df_clean <- df %>%
  filter(
    AGE >= 25, AGE <= 64,
    EMPSTAT %in% c(1,2),
    INCWAGE > 0,
    INCWAGE < 9999999
  ) %>%
  mutate(
    ln_wage = log(INCWAGE),
    educ_group = case_when(
      EDUC <= 6 ~ "No College",
      EDUC <= 9 ~ "Some College",
      EDUC >= 10 ~ "Bachelor's+"
    ),
    educ_group = factor(educ_group,
                        levels = c("No College", "Some College", "Bachelor's+")),
    female = ifelse(SEX == 2, 1, 0),
    race_eth = case_when(
      HISPAN != 0 ~ "Hispanic",
      RACE == 1 ~ "White NH",
      RACE == 2 ~ "Black NH",
      RACE %in% c(4,5,6) ~ "Asian NH",
      TRUE ~ "Other"
    )
  )



# Step 5 ----------------------------------------------------------------------

datasummary(
  ln_wage + AGE + female ~ educ_group * (Mean + SD),
  data = df_clean,
  fmt = 2,
  title = "Summary Statistics by Education Group ~ California ACS 2022"
)

# Step 6 ----------------------------------------------------------------------

model_1 <- feols(ln_wage ~ educ_group + AGE + I(AGE^2),
                 data = df_clean, vcov = "HC1")

model_2 <- feols(ln_wage ~ educ_group + AGE + I(AGE^2) + female + race_eth,
                 data = df_clean, vcov = "HC1")

model_3 <- feols(ln_wage ~ educ_group + AGE + I(AGE^2) + female + race_eth | OCC2010,
                 data = df_clean, vcov = "HC1")

etable(model_1, model_2, model_3,
       title = "Returns to Education - California ACS 2022")

# Step 7 ----------------------------------------------------------------------

ggplot(df_clean, aes(x = ln_wage, fill = educ_group)) +
  geom_density(alpha = 0.4) +
  scale_fill_manual(values = c("steelblue", "coral", "darkgreen")) +
  labs(title = "Log Wage Distribution by Education Group - California ACS 2022",
       x = "Log Annual Wages",
       y = "Density",
       fill = "Education Group") +
  theme_minimal()

ggsave("output/wage_distribution_by_education.png", width = 8, height = 5)