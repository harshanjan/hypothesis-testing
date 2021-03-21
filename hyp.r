# Hypothesis Testing

library("readr")
library(readxl)

# Load the Dataset
cutlets <- read.csv(file.choose())
View(cutlets)
sum(is.na(cutlets)) #having na values
cutlets <- cutlets[1:35,]  #removing na values
View(cutlets)
attach(cutlets)

# Normality test
# Ho: Data are normal
# Ha: Data are not normal --> take action = transformation

shapiro.test(cutlets$Unit.A)
# p-value = 0.32 > 0.05 so p high null fly => It follows normal distribution

shapiro.test(cutlets$Unit.B)
# p-value = 0.522 > 0.05 so p high null fly => It follows normal distribution


# Variance test
var.test(Unit.A, Unit.B)
# p-value = 0.3136 > 0.05 so p high null fly => Equal variances


# 2 sample t Test assuming equal variances
t.test(Unit.A, Unit.B, alternative = "two.sided", conf.level = 0.95, var.equal = T)

# alternative = "two.sided" means we are checking for equal and unequal means
# null Hypothesis -> Equal means
# Alternate Hypothesis -> Unequal Hypothesis
# p-value = 0.4722 > 0.05 failed to reject null Hypothesis => equal

?t.test
t.test(Unit.A,Unit.B, alternative = "greater")

# alternative = "greater means true difference is greater than 0
# Null Hypothesis -> (InterestRateWaiver-StandardPromotion) < 0
# Alternative Hypothesis -> (StandardPromotion - InterestRateWaiver) > 0
# p-value = 0.2362 > 0.05 => p high null fly => failed to reject null Hypothesis

# Conclusion:
# no difference in the diameter of the cutlet between two units.





# Load the data: labtat Data
labtat <- read.csv(file.choose())
View(labtat)
attach(labtat)


# Normality test
shapiro.test(Laboratory_1) #It follows normal distribution
shapiro.test(Laboratory_2) #It follows normal distribution
shapiro.test(Laboratory_3) #It follows normal distribution
shapiro.test(Laboratory_4) #It follows normal distribution

# Variance test
var.test(Laboratory_1, Laboratory_2) #equal variance
var.test(Laboratory_1, Laboratory_3) #equal variance
var.test(Laboratory_1, Laboratory_4) #equal variance
var.test(Laboratory_2, Laboratory_3) #equal variance
var.test(Laboratory_2, Laboratory_4) #equal variance
var.test(Laboratory_3, Laboratory_4) #equal variance

Stacked_Data <- stack(labtat)
?stack
View(Stacked_Data)

attach(Stacked_Data)
colnames(Stacked_Data)

Anova <- aov(values ~ ind, data = Stacked_Data)
summary(Anova)

# p-value is  less than 0.05 => p low null go => accept alternate hypothesis
# 4 laboratories turn around time  are not equal



#load dataset : creating a dataframe

east = c(50,550)
west = c(142,351)
north = c(131,480)
south = c(70,350)
modata <- data.frame(east = c(50,550),west = c(142,351),
                     north = c(131,480),
                     south = c(70,350))
View(modata)
row.names(modata) <- c("males","females")
modata
#here there is no need of performing chisquare test as the data is very small and can interpret results by looking at the data
#Male female buyers rations are not similar across the regions.
#NORTH and SOUTH falls in close range

##load dataset : customerOrder form
cofo <- read.csv(file.choose())
View(cofo)
cof <- cofo[1:300,] 
attach(cof)
cof <- as.vector(cof)
stack_data1 <- stack(lapply(cof,as.character))
colnames(stack_data1) <- as.character(stack_data1[1,2])
colnames(stack_data1)[1] <- "defective"
colnames(stack_data1)[2] <- "country"
install.packages("dummy")
stack_data1 <- cbind(stack_data1 , dummy(stack_data1$defective , sep = " "))
stack_data1 <- stack_data1[,2:3]
stack_data1
attach(stack_data1)
colnames(stack_data1)[2] <- "defective"
attach(stack_data1)
table <- table(country,defective)
table
?chisq.test
chisq.test(table(country,defective))
#p-value is greater than 0.05 => p high null fly => failed to reject null hypothesis
# all proportions are equal



## Load the data: fantaloons
fantaloons <- read.csv(file.choose()) 
View(fantaloons)
fantaloons <- fantaloons[1:400,]

attach(fantaloons)
?table
table1 <- table(fantaloons$Weekdays)
table1
table2 <- table(fantaloons$Weekend)
table2
table3 <- table(Weekdays, Weekend)
table3

?prop.test
prop.test(x = c(167,66), n = c(287,113), conf.level = 0.95, alternative = "two.sided") #weekdays
#p-value is greater than 0.05 i.e, equal proportion => failed to reject null hypothesis
prop.test(x = c(167,66), n = c(233,167), conf.level = 0.95, alternative = "two.sided") #weekends
# two.sided -> means checking for equal proportions of male and female on days
#p-value is less than 0.05 i.e, unequal proportion => accept alternate hypothesis
#p-value is greater than 0.05 i.e, equal proportion => failed to reject null hypothesis