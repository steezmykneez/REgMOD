<h1> MOTOR TREND: ROAD TESTS THE EFFECTS OF TRANSMISSION ON MPG </h1>

<h2> Executive Summary</h2>
<p>
This is the course project for the Regression Models course offered by Johns Hopkins University through the Coursra specialization. For this assignment, we will analyze the "mtcars" data set inorder to explore the relationships between a set of variables and the miles per gallon(MPG).

<p>Our objectives for this research are:</p>

<ul>
<li>Is an automatic or manual transmission better for MPG?</li>
<li>Quantifying how different is the MPG between automatic and manual transmissions?</li>
</ul>
<p>The results from our analysis were: </p>

<ul>
<li>Manual transmission is better for MPG by a factor of 1.8 compared to automatic transmission.</li>
<li>Means and medians for automatic and manual transmission cars are significantly different.</li>
</ul>

</p>

<h2> Set the WD and Load Knitr</h2>
<p>Load our working directory and apply Knitr package</p>


```r
setwd("~/Desktop/Regression Models Assignment")
```

```
## Error: cannot change working directory
```

```r
library(knitr)
```

<h2> Data Processing and Transformation</h2>
<p> Load the data set, perform the transformations below and factor the necessary variables. We will look at the results of this data in the following section</p>

```r
data(mtcars)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am,labels=c('Automatic','Manual'))
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : Factor w/ 2 levels "0","1": 1 1 2 2 1 2 1 2 2 2 ...
##  $ am  : Factor w/ 2 levels "Automatic","Manual": 2 2 2 1 1 1 1 1 1 1 ...
##  $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
##  $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...
```
<h2> Exploratory Data Analysis </h2>
<p>Exploring relationships between our data and variables of interest. First, we plot relationships between all variables in the data set (Figure 2 in Appendix).Notice variables: drat, hp, cyl,disp,wt,vs and am have a strong correlation with mpg. We will use linear models 2 quantify that in the regression analysis.</p>

<p>Use boxplots of the variable mpg when am is Automatic or Manual (Figure 1 in the Appendix). An increase in mpg happens when the transmission is manual.  </p>

<h2> Regression Analysis</h2>

<p> Building linear regression models bason on different variables. We are trying to find the best model fit and compare it with out base model</p>

<h3>Model Building and Selection</h3>
<p>Based on the pairs plot, where many variables had a high correlation with mpg, we built an initial model with variables as predictors and perform stepwise model selection to select significant predictors for our "best model". Done with the "step" method with runs "lm" multple times to build multiple regression models and select the best vars. Use of the AIC algorithm using forward selection and backward elimation. </p>

```r
init_model <- lm(mpg ~ ., data = mtcars)
best_model <- step(init_model, direction = "both")
```

```
## Start:  AIC=76.4
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df Sum of Sq RSS  AIC
## - carb  5     13.60 134 69.8
## - gear  2      3.97 124 73.4
## - am    1      1.14 122 74.7
## - qsec  1      1.24 122 74.7
## - drat  1      1.82 122 74.9
## - cyl   2     10.93 131 75.2
## - vs    1      3.63 124 75.4
## <none>              120 76.4
## - disp  1      9.97 130 76.9
## - wt    1     25.55 146 80.6
## - hp    1     25.67 146 80.6
## 
## Step:  AIC=69.83
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear
## 
##        Df Sum of Sq RSS  AIC
## - gear  2      5.02 139 67.0
## - disp  1      0.99 135 68.1
## - drat  1      1.19 135 68.1
## - vs    1      3.68 138 68.7
## - cyl   2     12.56 147 68.7
## - qsec  1      5.26 139 69.1
## <none>              134 69.8
## - am    1     11.93 146 70.6
## - wt    1     19.80 154 72.2
## - hp    1     22.79 157 72.9
## + carb  5     13.60 120 76.4
## 
## Step:  AIC=67
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - drat  1      0.97 140 65.2
## - cyl   2     10.42 149 65.3
## - disp  1      1.55 141 65.4
## - vs    1      2.18 141 65.5
## - qsec  1      3.63 143 65.8
## <none>              139 67.0
## - am    1     16.57 156 68.6
## - hp    1     18.18 157 68.9
## + gear  2      5.02 134 69.8
## - wt    1     31.19 170 71.5
## + carb  5     14.65 124 73.4
## 
## Step:  AIC=65.23
## mpg ~ cyl + disp + hp + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - disp  1      1.25 141 63.5
## - vs    1      2.34 142 63.8
## - cyl   2     12.33 152 63.9
## - qsec  1      3.10 143 63.9
## <none>              140 65.2
## + drat  1      0.97 139 67.0
## - hp    1     17.74 158 67.0
## - am    1     19.47 160 67.4
## + gear  2      4.80 135 68.1
## - wt    1     30.72 171 69.6
## + carb  5     13.05 127 72.1
## 
## Step:  AIC=63.51
## mpg ~ cyl + hp + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - qsec  1       2.4 144 62.1
## - vs    1       2.7 144 62.1
## - cyl   2      18.6 160 63.5
## <none>              141 63.5
## + disp  1       1.2 140 65.2
## + drat  1       0.7 141 65.4
## - hp    1      18.2 159 65.4
## - am    1      18.9 160 65.5
## + gear  2       4.7 137 66.4
## - wt    1      39.6 181 69.4
## + carb  5       2.3 139 73.0
## 
## Step:  AIC=62.06
## mpg ~ cyl + hp + wt + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - vs    1       7.3 151 61.7
## <none>              144 62.1
## - cyl   2      25.3 169 63.2
## + qsec  1       2.4 141 63.5
## - am    1      16.4 160 63.5
## + disp  1       0.6 143 63.9
## + drat  1       0.3 143 64.0
## + gear  2       3.4 140 65.3
## - hp    1      36.3 180 67.3
## - wt    1      41.1 185 68.1
## + carb  5       3.5 140 71.3
## 
## Step:  AIC=61.65
## mpg ~ cyl + hp + wt + am
## 
##        Df Sum of Sq RSS  AIC
## <none>              151 61.7
## - am    1       9.8 161 61.7
## + vs    1       7.3 144 62.1
## + qsec  1       7.0 144 62.1
## - cyl   2      29.3 180 63.3
## + disp  1       0.6 150 63.5
## + drat  1       0.2 151 63.6
## + gear  2       1.4 150 65.4
## - hp    1      31.9 183 65.8
## - wt    1      46.2 197 68.2
## + carb  5       5.6 145 70.4
```

<p>Best model obtained from the computations and consist of vars: cyl, wt and hp as confounders and "am" as the independant variable. </p>

```r
summary(best_model)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + hp + wt + am, data = mtcars)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.939 -1.256 -0.401  1.125  5.051 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  33.7083     2.6049   12.94  7.7e-13 ***
## cyl6         -3.0313     1.4073   -2.15   0.0407 *  
## cyl8         -2.1637     2.2843   -0.95   0.3523    
## hp           -0.0321     0.0137   -2.35   0.0269 *  
## wt           -2.4968     0.8856   -2.82   0.0091 ** 
## amManual      1.8092     1.3963    1.30   0.2065    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.41 on 26 degrees of freedom
## Multiple R-squared:  0.866,	Adjusted R-squared:  0.84 
## F-statistic: 33.6 on 5 and 26 DF,  p-value: 1.51e-10
```


```r
base_model <- lm(mpg ~ am, data = mtcars)
anova(base_model, best_model)
```

```
## Analysis of Variance Table
## 
## Model 1: mpg ~ am
## Model 2: mpg ~ cyl + hp + wt + am
##   Res.Df RSS Df Sum of Sq    F  Pr(>F)    
## 1     30 721                              
## 2     26 151  4       570 24.5 1.7e-08 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
<h2> Residuals and Diagnostics </h2>
<p>Residual plots of our regession model and also the computation of the regression diagnostics for our model. Looking for outliers in the data set.
</p>

```r
par(mfrow = c(2, 2))
plot(best_model)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 
<p>Notice:</p>
<ul>
<li>Residual vs Fitted plot seems 2 be randomly scattered on the plot and verify the independent condition</li>
<li>Notmal Q-Q consists of points which fall on the line indiciating the residuals are distributed normally</li>
<li>Scale-Location consists of point scattered in a consistant band patter, indicating constant variance<li>
<li> Some distinct points of interest (outliers) in top right </li>
</ul>

<p> Compute top 3 points in each case of influence measures</p>

```r
leverage <- hatvalues(best_model)
tail(sort(leverage),3)
```

```
##       Toyota Corona Lincoln Continental       Maserati Bora 
##              0.2778              0.2937              0.4714
```


```r
influential <- dfbetas(best_model)
tail(sort(influential[,6]),3)
```

```
## Chrysler Imperial          Fiat 128     Toyota Corona 
##            0.3507            0.4292            0.7305
```
<p>Our analysis is correct, the same cars are in the residual plots</p>

<h2> Inference </h2>
<p>T-test assuming that the transmission data has a normal distribution and clearly see that the manual and automatic transmissions are different</p>


```r
t.test(mpg ~ am, data = mtcars)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  mpg by am
## t = -3.767, df = 18.33, p-value = 0.001374
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -11.28  -3.21
## sample estimates:
## mean in group Automatic    mean in group Manual 
##                   17.15                   24.39
```
<h2>Conclusion</h2>
<p> From out best fit mode, we can conclude:</p>
<ol>
  <li>Cars with "Manual" transmission get more miles per gallen (mpg) vs Automatic transmission</li>
  <li>MPG will decrease by 2.5 for each 1000lb increase in weight (wt)</li>
  <li>MPG decreases negligibly with increase of horse power (hp)</li>
  <li>If number of cylinders, cyl, increases from 4 to 6 to 8 mpg and will decrease by factor of 3 and 2.2 respectively (adjusted by hp, wt and am)</li>
</ol>
<h2> Appendix </h2>

```r
boxplot(mpg ~ am, data = mtcars, xlab = "Transmission (0 = automatic, 1 = manual)")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 



```r
pairs(mtcars)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 
