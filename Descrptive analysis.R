#1. Import tidyverse and create a new object

library(tidyverse)  # [1] Import the tidyverse package.

# [2] Create a new object 'speedy'and import hte CSV file:
speedy <- read_csv(file.choose (), header = TRUE) 

View(speedy)

as_tibble(speedy) # [3] View the new object as a 'tibble'.

# 2. Find the mean and median

# Find the mean and median total_minutes custs spend in the restuarant

#Mean
mean(speedy$total_minutes)

#Median
median(speedy$total_minutes)

#3. Measure the variability in values

#a) min()
min(speedy$total_minutes)

#b) max()
max(speedy$total_minutes)

#c) Range = max() - min()
max(speedy$total_minutes) -
  min(speedy$total_minutes)

#d) quantile() first quater
quantile(speedy$total_minutes, 0.25)

#e) quantile() third quater
quantile(speedy$total_minutes, 0.75)

#f) IQR()
IQR(speedy$total_minutes)

#G) var()
var(speedy$total_minutes)

#h) sd()
sd(speedy$total_minutes)


#4. Determine normality (histogram and boxplot)

#Normal tests are used to determine the normality of a data set, that is 
#whether the data distribution follows a normal distribution. Multiple 
#statistical tests such as t-testsand confidence intervals require a normally distributed population.

# [1] Specify histogram function: 
hist (speedy$total_minutes) 

# [2] Specify boxplot function:
boxplot(speedy$total_minutes) 

#The histogram suggests that the data is slightly skewed to the left 
#and hence does not follow a normal distribution. 
# The boxplot shows no visible outliers.

#5. Determine normality (qqplots)

#Another visual check for normality is to use a qqplot (quantile-quantile plot), 
#like we have done before in Python. If the data points roughly follow a straight 
#line on the qqplot, one may argue that there exists evidence in favour of normality. 
#Let’s try it out. To plot a qqplot in R, we:


# [1] Specify qqnorm function (draw a qqplot):
qqnorm (speedy$total_minutes)

#The plot suggests that the data points are roughly following a straight 
#line from the bottom left to the top right of the graph, and it looks 
#like we can assume normality. We can add a reference line using the 
#qqline() function to confirm the position of the data points. To do this, we:

qqline (speedy$total_minutes) # [1] Specify qqline function.

#The reference line shows that the points are roughly circling a straight line, but whether this confirms normality is unclear.

#6. Determine normality (Shapiro-Wilk test)

#Finally, let’s use the Shapiro-Wilk test to test the normality of the data set.
#The Shapiro-Wilk test is a statistical test used to check whether a continuous 
#variable follows a normal distribution. The sample size for the test to work 
#in R needs to be between 3 and 5,000. We have a sample of 50 here, so we can safely run the test.

# [1] Specify shapiro.test function (Shapiro-Wilk test):

shapiro.test (speedy$total_minutes)

#Recall that the p-value is the probability of achieving results at least as extreme 
#as the observed ones, assuming the null hypothesis is true (in this case, that the 
#data are normally distributed). If the p-value is small - less than 5%, say - we would 
#conclude that the assumption of normality is a poor fit for the data. The output here 
#indicates that the p-value is large, so there is little evidence that total_minutes is not normally distributed.


# 7. Determine normality (skewness and kurtosis)

## Skewness
#There are further tests we can run to check the distribution or shape of a data set, such as the skewness()
#and kurtosis() functions. A data distribution that is not symmetric is said to be skewed. Negative skewness 
#generally means that the mean is less than the median and the data is left-leaning. Positive skewness means the 
#opposite, where the mean is larger than the median and data leans to the right.


## Kurtosis
#Kurtosis measures the tailedness of the distribution, in other words, whether the distribution tails are light 
#or heavy. Our point of reference is the normal distribution, which has a coefficient of kurtosis equal to 3. 
#A value higher than 3 indicates a leptokurtic (or heavy-tailed) distribution, that is, one with more extreme 
#outliers than the normal distribution. By contrast, a value less than 3 indicates a platykurtic (or light-tailed) distribution.

# [1] Install the moments package and load the library:

install.packages("moments") 
library(moments)

# Specify [2] the skewness and [3] kurtosis functions:
skewness(speedy$total_minutes) 
kurtosis(speedy$total_minutes) 

#As you can observe in the output, skewness is less than 1 but greater than 0. This is positive skewness,
#which suggests that the distribution is slightly right-skewed and biased towards higher values, a relatively 
#common scenario in data from the social sciences, which could include our restaurant chain data (ProgrammingR 2022). 
#The output also shows that kurtosis is less than 3. This suggests that the data is platykurtic 
#and will produce less extreme outliers than the normal distribution.











