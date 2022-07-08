# Objective is two-fold

# 1. analyse the BMI of the primary holders, focusing on:
    #a. measures of tendency
    #b. measures of variability
    #c. normality

# 2. Investigate the correlation between the BMI and the amount I4U charges each
     # customer. Take a note of the correlation between these variables and what other variables I4U might use ascorrelation with charges.

# 1. Import packages
library(tidyverse)
library(moments)
library(BSDA)

# import and sense check data
health <- read.csv(file.choose(), header=TRUE)
as_tibble(health)
View(health)

summary(health)

# 1.a: Measure the central tendancies

mean(health$bmi)
median(health$bmi)

# Mean and Median are very similiar suggesting the data is tighlty distributed

# 1.a Measures statistics of extreme values

min(health$bmi)
max(health$bmi)

# 1.b Measure statistics of variability in the BMI column

# range
max(health$bmi) - min(health$bmi)

# Q1 (quartile 1)
quantile(health$bmi, 0.25)

# Q3 (quartile 3)
quantile(health$bmi, 0.75)

# IQR(inter quartile range)
IQR(health$bmi)

# variance
var(health$bmi)

# standard deviation
sd(health$bmi)

# 1.c Check for normality
# check for normality using qqnorm and qqline

qqnorm(health$bmi, col = 'blue', xlab= 'z Value', ylab= 'BMI')
qqline(health$bmi, col = 'red', lwd = 2)

# the result shows the the data points are roughly following in the reference line

shapiro.test(health$bmi)

# The p-value is 2.605e-05 meaning that the data is not normally distributed
# but according to the solution provided 2.605e-05 means that the p value is higher than 0.5 so data is normally distributed

# Check for kurtosis and skewness

kurtosis(health$bmi)
skewness(health$bmi)

# The kurtosis is 2.94 which is very slightly under 3. thus the data is just about platykurtic,
# and will produce less extreme outliers

# Skewness is 0.28 and as such is slightly right skewed


# 2. Check for correlation between the amount I4U charges and the bmi

# correlation between bmi and charges
cor(health$bmi, health$charges)
# at 0.198 there is a very weak positive correlation. This much closer to 0 than 1 so we assume that there is no correlation

# correlation between age and charges
cor(health$age, health$charges)
# Again there is a quite a weak positive correlation between agae and charges











