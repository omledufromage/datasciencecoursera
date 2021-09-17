library(lattice)

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f*x + rnorm(100, sd = 0.5)
f < factor(f, labels = "Group 1", "Group 2")
xyplot(y ~ x| f, panel = function(y, x, ...) {
        panel.xyplot(x, y, ...)
        panel.lmline(x, y, col = 2)
})






## Doesn't work... why? 
library(pwt10)
attach(pwt10.0)
c <- c("Ethiopia", "Iceland")
xyplot(rgdpe/pop ~ year | c, panel = function(y, x, ...) {
        panel.xyplot(rgdpe/pop, year, ...)
        panel.lmline(rgdpe/pop, year, col = 2)
})


library(ggplot2)

##| Obviously, there's a DATA FRAME which contains the data you're trying to plot. Then the AESTHETIC MAPPINGS determine how data are
##| mapped to color, size, etc. The GEOMS (geometric objects) are what you see in the plot (points, lines, shapes) and FACETS are the
##| panels used in conditional plots. You've used these or seen them used in the first ggplot2 (qplot) lesson.
##| There are 3 more. STATS are statistical transformations such as binning, quantiles, and smoothing which ggplot2 applies to the data.
##| SCALES show what coding an aesthetic map uses (for example, male = red, female = blue). Finally, the plots are depicted on a
##| COORDINATE SYSTEM. When you use qplot these were taken care of for you.


qplot(drv, hwy, data = mpg, geom = "boxplot", color = manufacturer)
qplot(manufacturer, hwy, data = mpg, geom = "boxplot", color = drv)

qplot(displ, hwy, data = mpg, facets = .~ drv)

g <- ggplot(mpg, aes(displ, hwy))
g+geom_point()+geom_smooth()
g+geom_point()+geom_smooth(method = "lm")
g+geom_point()+geom_smooth(method = "lm")+facet_grid(.~drv)+ggtitle("Swirl Rules!")

##| So far you've just used the default labels that ggplot provides. You can add your own annotation using functions such as xlab(),
##| ylab(), and ggtitle(). In addition, the function labs() is more general and can be used to label either or both axes as well as
##| provide a title. Now recall the expression you just typed and add a call to the function ggtitle with the argument "Swirl Rules!".
##| Now that you've seen the basics we'll talk about customizing. Each of the “geom” functions (e.g., _point and _smooth) has options to
##| modify it. Also, the function theme() can be used to modify aspects of the entire plot, e.g. the position of the legend. Two standard
##| appearance themes are included in ggplot. These are theme_gray() which is the default theme (gray background with white grid lines)
##| and theme_bw() which is a plainer (black and white) color scheme.


# Difference between constant and aesthetics influenced by variables. Variables have to be wrapped around the aes() function.
g+geom_point(color = "pink", size = 4, alpha = 1/2)
g+geom_point(aes(color = drv), size = 4, alpha = 1/2)

g+geom_point(aes(color = drv)) + labs(title = "Swirl Rules!") + labs(x = "Displacement", y = "Hwy Mileage")

## Removing the confidence interval 95% (standard error) shade from the smoother.
g+geom_point(aes(color = drv), size = 2, alpha = 1/2) + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

# Changing background and font.
g+geom_point(aes(color = drv)) + theme_bw(base_family = "Times")

## Note about axes. Comparing plot and ggplot

plot(myx, myy, type = "l", ylim = c(-3, 3))

g <- ggplot(testdat, aes(myx, myy))
g + geom_line() + ylim(-3, 3)
g + geom_line() + coord_cartesian(ylim = c(-3, 3)) ## This is the same to plot.

g <- ggplot(mpg, aes(x = displ, y = hwy, color = factor(year)))
g + geom_point() + facet_grid(drv~cyl, margins = TRUE)
# Margins tells ggplot to display the marginal totals over each row and column. So instead of seeing 3 
# rows (the number of drv factors) and 4 columns (the number of cyl factors) we see a 4 by 5 display.

g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") + 
        labs(x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")


### EXTRAS. 

str(diamonds) ## Data set included in ggplot2 package
qplot(carat, price, data = diamonds, color = cut, facets = .~cut) + geom_smooth(method = "lm")

#| Let's divide the data into 3 pockets, so 1/3 of the data falls into each. We'll use the R command quantile to do this. Create the
#| variable cutpoints and assign to it the output of a call to the function quantile with 3 arguments. The first is the data to cut,
#| namely diamonds$carat; the second is a call to the R function seq. This is also called with 3 arguments, (0, 1, and length set equal
#| to 4). The third argument to the call to quantile is the boolean na.rm set equal to TRUE.

cutpoints <- quantile(diamonds$carat, seq(0, 1, length = 4), na.rm = TRUE)

cutpoints
# 0% 33.33333% 66.66667%      100% 
#        0.20      0.50      1.00      5.01 
#
#| That's a job well done!
#
#  |=====================================================================================================                          |  80%
#| We see a 4-long vector (explaining why length was set equal to 4). We also see that .2 is the smallest carat size in the dataset and
#| 5.01 is the largest. One third of the diamonds are between .2 and .5 carats and another third are between .5 and 1 carat in size. The
#| remaining third are between 1 and 5.01 carats. Now we can use the R command cut to label each of the 53940 diamonds in the dataset as
#| belonging to one of these 3 factors. Create a new name in diamonds, diamonds$car2 by assigning it the output of the call to cut. This
#| command takes 2 arguments, diamonds$carat, which is what we want to cut, and cutpoints, the places where we'll cut.

seq(0, 1, length = 4)
# [1] 0.0000000 0.3333333 0.6666667 1.0000000

diamonds$car2 <- cut(diamonds$carat, cutpoints)

#| Now we can continue with our multi-facet plot. First we have to reset g since we changed the dataset (diamonds) it contained (by
#| adding a new column). Assign to g the output of a call to ggplot with 2 arguments. The dataset diamonds is the first, and a call to
#| the function aes with 2 arguments (depth,price) is the second.

g <- ggplot(diamonds, aes(depth, price))

#| Now add to g calls to 2 functions. This first is a call to geom_point with the argument alpha set equal to 1/3. The second is a call
#| to the function facet_grid using the formula cut ~ car2 as its argument.

g + geom_point(alpha=1/3) + facet_grid(cut ~ car2)

#| We see a multi-facet plot with 5 rows, each corresponding to a cut factor. Not surprising. What is surprising is the number of
#| columns. We were expecting 3 and got 4. Why?
        
# The first 3 columns are labeled with the cutpoint boundaries. The fourth is labeled NA and shows us where the data points with missing
#| data (NA or Not Available) occurred. We see that there were only a handful (12 in fact) and they occurred in Very Good, Premium, and
#| Ideal cuts. We created a vector, myd, containing the indices of these datapoints. Look at these entries in diamonds by typing the
#| expression diamonds[myd,]. The myd tells R what rows to show and the empty column entry says to print all the columns.

diamonds[myd,]
# A tibble: 12 × 11
#carat cut       color clarity depth table price     x     y     z car2 
#<dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl> <fct>
#        1   0.2 Premium   E     SI2      60.2    62   345  3.79  3.75  2.27 NA   
#2   0.2 Premium   E     VS2      59.8    62   367  3.79  3.77  2.26 NA   
#3   0.2 Premium   E     VS2      59      60   367  3.81  3.78  2.24 NA   
#4   0.2 Premium   E     VS2      61.1    59   367  3.81  3.78  2.32 NA   
#5   0.2 Premium   E     VS2      59.7    62   367  3.84  3.8   2.28 NA   
#6   0.2 Ideal     E     VS2      59.7    55   367  3.86  3.84  2.3  NA   
#7   0.2 Premium   F     VS2      62.6    59   367  3.73  3.71  2.33 NA   
#8   0.2 Ideal     D     VS2      61.5    57   367  3.81  3.77  2.33 NA   
#9   0.2 Very Good E     VS2      63.4    59   367  3.74  3.71  2.36 NA   
#10   0.2 Ideal     E     VS2      62.2    57   367  3.76  3.73  2.33 NA   
#11   0.2 Premium   D     VS2      62.3    60   367  3.73  3.68  2.31 NA   
#12   0.2 Premium   D     VS2      61.7    60   367  3.77  3.72  2.31 NA   

#| We see these entries match the plots. Whew - that's a relief. The car2 field is, in fact, NA for these entries, but the carat field
#| shows they each had a carat size of .2. What's going on here?
        
#  Actually our plot answers this question. The boundaries for each column appear in the gray labels at the top of each column, and we
#| see that the first column is labeled (0.2,0.5]. This indicates that this column contains data greater than .2 and less than or equal
#| to .5. So diamonds with carat size .2 were excluded from the car2 field.

#| Finally, recall the last plotting command (g+geom_point(alpha=1/3)+facet_grid(cut~car2)) or retype it if you like and add another
#| call. This one to the function geom_smooth. Pass it 3 arguments, method set equal to the string "lm", size set equal to 3, and color
#| equal to the string "pink".

g + geom_point(alpha=1/3) + facet_grid(cut ~ car2) + geom_smooth(method = "lm", size = 3, color = "pink")
#`geom_smooth()` using formula 'y ~ x'

#| Nice thick regression lines which are somewhat interesting. You can add labels to the plot if you want but we'll let you experiment on
#| your own.

#| Lastly, ggplot2 can, of course, produce boxplots. This final exercise is the sum of 3 function calls. The first call is to ggplot with
#| 2 arguments, diamonds and a call to aes with carat and price as arguments. The second call is to geom_boxplot with no arguments. The
#| third is to facet_grid with one argument, the formula . ~ cut. Try this now.

ggplot(diamonds, aes(carat, price)) + geom_boxplot() + facet_grid(.~cut)
#Warning message:
#Continuous x aesthetic -- did you forget aes(group=...)? 


