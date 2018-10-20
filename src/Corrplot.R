##Immunisation corrplot
library(lavaan)
library(semPlot)
options (scipen = 999)
library(dplyr)
library(corrplot)
library(glmnet)
library(gapminder)
library(openintro)
library(ggplot2)
library(Amelia)
library(missMDA)
#read in the data for 2016 only
Data <-read.csv('../cleaned_data/2016_data.csv')
str(Data)
#Filter and clean data to get only the variables we really want

geo_data <- Data %>%
  select(postcode, state, year, age, pc_immun, caution, pc_immun_class, PHN_number, IEO_SCORE, IER_SCORE, IRSAD_SCORE, IRSD_SCORE, electorate, mean_tax_000s, political_score)
# Remove NA values
Data <- Data[complete.cases(Data), ]
#Need to make the factors ordered factors to work in Lavaan
Data$postcode = postcode_factor_ordered <- factor(Data$postcode, ordered = TRUE)
Data$state = state_factor_ordered <- factor(Data$state, ordered = TRUE)
Data$pc_immun = pc_immun_factor_ordered <- factor(Data$pc_immun, ordered = TRUE)
Data$PHN_code = PHN_code_factor_ordered <- factor(Data$PHN_code, ordered = TRUE)
Data$electorate = electorate_factor_ordered <- factor(Data$electorate, ordered = TRUE)
M <- cor(cplot)
p.mat <- cor.mtest(M)
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, 
         method = "color",
         order= "hclust",
         type="full",
         col=col(200),
         diag =F,
         title="Correlation of Numeric Variables",
         addCoef.col = "black",
         sig.level = 0.05,
         insig ="blank",
         mar=c(0,0,3,0))
