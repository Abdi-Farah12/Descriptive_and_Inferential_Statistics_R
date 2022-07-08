# Import the necessary libraries
library(ggplot2)
library(tidyverse)
library(dplyr)

# Import the insurance data set
health <- read.csv (file.choose (), header = T)

# Sense check the data set
head(health)
str(health)

# Measure central tendencies of BMI. We'll do mean first, then median.
mean(health$bmi)
median(health$bmi)

# Statistics of extreme values
min (health$bmi) # Function to determine the minimum value.
max (health$bmi) # Function to determine the maximum value.

# Measure the variability of BMI values.
max (health$bmi)- min(health$bmi)  # Range = Maximum - Minimum.
quantile (health$bmi, 0.25)  # Function to calculate Q1.
quantile (health$bmi, 0.75)   # Function to calculate Q2.
IQR (health$bmi)    # Function to calculate IQR.
var (health$bmi) # Function to determine the variance.
sd (health$bmi) # Function to return the standard deviation.

# Measure normality in BMI values.
# With a qqplot.
qqnorm((health$bmi))
# Add a reference line
qqline(health$bmi, col="green")

# With a Shapiro-Wilk test
shapiro.test((health$bmi))
# Our p-value is well above 0.05, and we can conclude normal distribution.

# Check for skewness.
# First import the moments package and library.
install.packages("moments")
library(moments)

# Now we can check for skewness
skewness(health$bmi)
# Our output suggests a positive skewness

#Check for kurtosis.
kurtosis(health$bmi)

# Our kurtosis value is less than 3, suggesting our data is platykurtic

# Check correlation between BMI and client age
# Let's first check for normality in the client age values
shapiro.test(health$age)

# Our output is greater than 0.5, and we can assume normality

# Check correlation between BMI and age using Pearson's correlation
cor(health$bmi, health$age)

# Our correlation coefficient of 0.11 suggests a weak positive correlation
