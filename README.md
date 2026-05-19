# California Education Wage Premium

## Research Question
**How do earnings differ among California workers with no college, some college, and a completed bachelor's degree, and does the education premium vary by occupation, industry, or demographic group?**

## Overview
This project analyzes the returns to education in the California labor market using American Community Survey (ACS) microdata from 2022. Using standard applied microeconomics methods, I estimate the wage premium associated with each level of educational attainment and examine whether that premium varies across occupations, industries, and demographic groups.

## Data
**Source:** American Community Survey (ACS) 2022, 1-year sample via [IPUMS USA](https://usa.ipums.org)

The raw data file is not included in this repository per IPUMS terms of use. To replicate this analysis:
1. Register at [ipums.org](https://usa.ipums.org)
2. Select the ACS 2022 sample
3. Request the following variables: `STATEFIP, AGE, SEX, RACE, HISPAN, EDUC, EMPSTAT, OCC2010, INCWAGE`
4. Filter to STATEFIP = 6 (California)
5. Download as CSV and place in the `data/` folder as `usa_00001.csv`

## Methods
- Sample restricted to California working-age adults (25–64) in the labor force with positive wage income
- Education groups: No college (less than some college), Some college (associate's degree or some college), Bachelor's degree or higher
- Outcome: Log annual wage income (`ln_wage`)
- OLS regression with heteroskedasticity-robust standard errors (HC1)
- Specifications: raw premium → demographic controls → occupation fixed effects

## Repository Structure
```
ca-education-wage-premium/
├── data/           # Raw data (not tracked — see above to replicate)
├── scripts/        # R analysis scripts
├── output/         # Tables and figures
└── README.md
```

## Tools
R — tidyverse, fixest, modelsummary, ggplot2

## Author
Sina Panah
