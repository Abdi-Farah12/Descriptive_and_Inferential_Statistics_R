# 1. Install the packages

library (tidyverse)  # Activate the tidyverse package.
install.packages("moments")
library (moments)  # Activate the moments package.

# 2. Import and sense-check the data

# [1] Import the data into R:

drive1 <- read.csv (file.choose (), header = TRUE) 

View (drive1)  # [2] View the data set.
summary (drive1)  # [3] View a summary of the data set.

#The data set consists of 25 rows and seven columns. Each column shows 
#the average time, in seconds, that a customer stayed at each stage of 
#the drive-through process, from the car stopping to the car leaving.

#3. Remove unnecessary columns

# [1] Assign data to the object and [2] remove the 'number' column:

drive2 <- select (drive1, -n) 

# [3] Print/convert the data set into a tibble:
as_tibble (drive2)

#The output shows the data in the form of a data frame with 25 rows 
#and six columns – the column () has been removed.


# Next, let’s address the difference in rounding that can be seen in the values. 
#To do this, we:

# [1] Create new object and [2] specify the function: 
drive3 <- round(drive2, 2)

# [3] Print/convert the data set into a tibble
as_tibble(drive3)

#The output shows the drive3 data frame, and we 
#can see that the values are now rounded to 
#two decimal places, where applicable, for uniformity.

#The total_seconds column contains the total time taken for a customer 
#to arrive at and then leave the drive-through. It is the key variable in 
#SpeedyEats sample and will form the focus of the statistical tests we’ll undertake.


#4. Check for normal distribution

# Check for normal dist using qqplot

#Specify the qqnorm() function and pass drive3$total_seconds, then set the colour to blue, the -axis label to "z Value" and the -axis label to "Time".
qqnorm(drive3$total_seconds,col = 'blue', xlab="z Value", ylab="Time" )

#Specify the qqline() function and pass drive3$total_seconds, then set the colour to red and the line width to 2.
qqline(drive3$total_seconds, col = 'red', lwd = 2)

# Run shapiro-wilk test to check p-value
shapiro.test(drive3$total_seconds)

# the p-value is >0.05 so we can conclude that the data is normally distributed

# run kurtosis and skewness test
kurtosis(drive3$total_seconds)
skewness(drive3$total_seconds)

# kurtosis is below 3 so it the data is platykurtic and will produce less extreme outliers
# skewness is more than zero but less than 1 at 0.03. It is very sligly skewed to the right

#Now that we’re satisfied that the data is normally distributed, let’s run a one-sample t-test to test our hypothesis. 


# 5. Perform t-test

#Let’s perform the t-test on the data set at the 95% confidence interval. Confidence intervals indicate the precision of a 
#measurement or, in other words, can be referred to as the margin of error during measurements. A 95% confidence interval 
#is a set of values that you can be 95% sure contains the true mean of the population

# [1] Specify the t.test function; set [1a] the data source, [1b] the confidence interval (95%), and [1c] the theoretical mean:  
t.test (drive3$total_seconds, conf.level = 0.95, mu = 120) # mu is the theoretical mean which is chosen because speedy wants drive throughs to take less than 120 seconds

#The key value for us is the p-value. Our p-value is 2.617e-14, less than 0.05, the significance level for a 95% confidence interval.
#The mean of the total time was statistically significantly lower than the target mean of 120, with a p-value = 2.617e-14.  The e-14 indicates that the value is very small with 16 zeros 0.00000000...2.617etc
# In other words the results did not happen by chance.

#This suggests that the new drive-through process is effective, and customers are getting their food before 120 seconds have passed. 
#SpeedyEats can now feel fairly confident to proceed with its new drive-through process across all its restaurants.

#6. Perform the z-test

# We use a z-test on a sample when we know the population’s standard deviation.

# As in a t-test we set a null hypothesis and alternate hypothesis
# Null hypothesis: mu <= 120 (seconds) -- we assume that hypothesis is true unless we have suffiecient edivence that its not.
# Alternate hypothesis: mu >= 120

# The BSDA library contains the z-test function
install.packages("BSDA")
library(BSDA)

# we are using one sample which is the total_seconds so we will use a one-sample test

# we need the standard deviation for the z-test
sd(drive3$total_seconds)

#z-test
 z.test(drive3$total_seconds, mu=120, sigma.x=28.65) # sigma.x is the standard deviation

# The z statistic is -4.93 standard deviations below the mean. 
 
 #Pearson’s correlation coefficient in R
 
#Pearson’s correlation coefficient () determines the linear or statistical relationship between independent and dependent continuous variables. 
#It gives us the:
    # 1. magnitude of the association
    # 2. direction of the relationship. 
 
#Correlation values range from -1 to 1. Note that  identifies whether there is a relationship between the variables. 
#Hence, Pearson’s correlation coefficient is an indicator of correlation, not causation.  

#Let’s go back to the drive-through data set. SpeedyEats, confident that its new process is paying dividends, decides 
#to see whether there is a way to make the drive-through process even faster. It decides to return to its test data set 
#to see whether there is a correlation between:
   
#1. the time customers spent arriving or waiting in line (or car_stop) and the time they spent leaving (or car_go)
#2. the time customers spent placing their order (or take_order) and the time they spent receiving their order (or hand_over_order).

#If there is evidence of a strong linear correlation between these variables, they could then investigate causality between the variables
# to guide business decisions.

# we can use cor() to calculate the correlation coefficient
# and we can use cor.test() to test the correlation between two samples
 
# we'll use cor() to return Pearson correlation coeffcient alone.

# but first we need to check if the variables are normally distributed
# as the Pearson correlation only works on variables with normal distribution
 
# To do this we will again use the shapiro-wilk test
 
 shapiro.test(drive3$car_stop)
 shapiro.test(drive3$car_go)

# both p-values are greater than 0.05 suggesting that the data is normally distributed
 
# now lets check correlation
 
 # [1] Specify the cor function; set the [1a] first and [1b] second variables:
 
 cor (drive1$car_stop, drive1$car_go)
 
 # [2] Specify the cor function again and set first and second variables:
 cor (drive1$take_order, drive1$hand_over_order) 
 
# In the first computation there is a weak negative correlation of -0.213
# The value is closer to 0 than -1 so its a weak correlation. We can conclude here
# that there is no correlation

# The second compution at 0.268 is weak positive correlation as its closer to 0 than 1

# We can check for correlation in the entire dataset by inputing just the df and rounding to 2 decimal points
 
round(cor(drive1),2)
 

 
 
 


 
 
 
 
