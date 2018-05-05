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

```{r}
setwd("~/Desktop/Regression Models Assignment")
library(knitr)
```

<h2> Data Processing and Transformation</h2>
<p> Load the data set, perform the transformations below and factor the necessary variables. We will look at the results of this data in the following section</p>
```{r}
data(mtcars)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am,labels=c('Automatic','Manual'))
str(mtcars)
```
<h2> Exploratory Data Analysis </h2>
<p>Exploring relationships between our data and variables of interest. First, we plot relationships between all variables in the data set (Figure 2 in Appendix).Notice variables: drat, hp, cyl,disp,wt,vs and am have a strong correlation with mpg. We will use linear models 2 quantify that in the regression analysis.</p>

<p>Use boxplots of the variable mpg when am is Automatic or Manual (Figure 1 in the Appendix). An increase in mpg happens when the transmission is manual.  </p>

<h2> Regression Analysis</h2>

<p> Building linear regression models bason on different variables. We are trying to find the best model fit and compare it with out base model</p>

<h3>Model Building and Selection</h3>
<p>Based on the pairs plot, where many variables had a high correlation with mpg, we built an initial model with variables as predictors and perform stepwise model selection to select significant predictors for our "best model". Done with the "step" method with runs "lm" multple times to build multiple regression models and select the best vars. Use of the AIC algorithm using forward selection and backward elimation. </p>
```{r}
init_model <- lm(mpg ~ ., data = mtcars)
best_model <- step(init_model, direction = "both")
```

<p>Best model obtained from the computations and consist of vars: cyl, wt and hp as confounders and "am" as the independant variable. </p>
```{r}
summary(best_model)
```

```{r}
base_model <- lm(mpg ~ am, data = mtcars)
anova(base_model, best_model)
```
<h2> Residuals and Diagnostics </h2>
<p>Residual plots of our regession model and also the computation of the regression diagnostics for our model. Looking for outliers in the data set.
</p>
```{r}
par(mfrow = c(2, 2))
plot(best_model)
```
<p>Notice:</p>
<ul>
<li>Residual vs Fitted plot seems 2 be randomly scattered on the plot and verify the independent condition</li>
<li>Notmal Q-Q consists of points which fall on the line indiciating the residuals are distributed normally</li>
<li>Scale-Location consists of point scattered in a consistant band patter, indicating constant variance<li>
<li> Some distinct points of interest (outliers) in top right </li>
</ul>

<p> Compute top 3 points in each case of influence measures</p>
```{r}
leverage <- hatvalues(best_model)
tail(sort(leverage),3)
```

```{r}
influential <- dfbetas(best_model)
tail(sort(influential[,6]),3)
```
<p>Our analysis is correct, the same cars are in the residual plots</p>

<h2> Inference </h2>
<p>T-test assuming that the transmission data has a normal distribution and clearly see that the manual and automatic transmissions are different</p>

```{r}
t.test(mpg ~ am, data = mtcars)
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
```{r}
boxplot(mpg ~ am, data = mtcars, xlab = "Transmission (0 = automatic, 1 = manual)")
```


```{r}
pairs(mtcars)
```