import pandas as pd
import scipy 
from scipy import stats
import statsmodels.api as sm


#load the dataset: cutlet 
cutlet=pd.read_csv("C:/Users/user/Desktop/datasets/Cutlets.csv")
cutlet = cutlet.iloc[1:35,:]
cutlet = cutlet.rename(columns={'Unit A': 'unitA' , 'Unit B' : 'unitB'})



##########Normality Test ############
print(stats.shapiro(cutlet.unitA))    #Shapiro Test
# p-value = 0.3 > 0.05 so p high null fly => It follows normal distribution
print(stats.shapiro(cutlet.unitB))
# p-value = 0.55 > 0.05 so p high null fly => It follows normal distribution


######## Variance test #########
scipy.stats.levene(cutlet.unitA,cutlet.unitB)
help(scipy.stats.levene)
# p-value = 0.41 > 0.05 so p high null fly => Equal variances

######## 2 Sample T test ################
help(scipy.stats.ttest_ind)
scipy.stats.ttest_ind(cutlet.unitA,cutlet.unitB)
# p-value = 0.4722 > 0.05 failed to reject null Hypothesis => equal
# no difference in the diameter of the cutlet between two units.

#load dataset : labtat
from statsmodels.formula.api import ols

labtat=pd.read_csv("C:/Users/user/Desktop/datasets/lab_tat_updated.csv")
labtat
labtat.columns= "lab1","lab2","lab3","lab4" #renaming col names 

##########Normality Test ############

print(stats.shapiro(labtat.lab1))    #follows normal distribution
print(stats.shapiro(labtat.lab2))    #follows normal distribution
print(stats.shapiro(labtat.lab3))    #follows normal distribution
print(stats.shapiro(labtat.lab4))    #follows normal distribution

############## Variance test #########
scipy.stats.levene(labtat.lab1,labtat.lab2)
scipy.stats.levene(labtat.lab1,labtat.lab3)
scipy.stats.levene(labtat.lab1,labtat.lab4)
scipy.stats.levene(labtat.lab2,labtat.lab3)
scipy.stats.levene(labtat.lab2,labtat.lab4)
scipy.stats.levene(labtat.lab3,labtat.lab4)


############# One - Way Anova###################
F, p = stats.f_oneway(labtat.lab1,labtat.lab2,labtat.lab3,labtat.lab4)
# p-value is  less than 0.05 => p low null go => accept alternate hypothesis
# 4 laboratories turn around time  are not equal


##load datset : Buyerratio

data = pd.read_csv("C:/Users/user/Desktop/datasets/BuyerRatio.csv")
data
#here there is no need of performing chisquare test as the data is very small and can interpret results by looking at the data
#Male female buyers rations are not similar across the regions.
#NORTH and SOUTH falls in close similar range

##load dataset : fantaloons

fant = pd.read_csv("C:/Users/user/Desktop/datasets/Fantaloons.csv")
fant = fant.iloc[1:400,:] #removing empty observations 
from statsmodels.stats.proportion import proportions_ztest

tab1 = fant.Weekdays.value_counts()
tab1
tab2 = fant.Weekend.value_counts()
tab2

# crosstable table
pd.crosstab(fant.Weekdays, fant.Weekdays)

count = np.array([167, 66])
nobs = np.array([233,167])

stats, pval = proportions_ztest(count, nobs, alternative = 'two-sided') 
print(pval)
 # P-value is less than 0.05
#p low null go => accept alternate hypothesis





