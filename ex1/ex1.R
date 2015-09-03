#% Machine Learning Online Class - Exercise 1: Linear Regression

#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  linear exercise. You will need to complete the following functions 
#  in this exericse:
#
#     warmUpExercise.m
#     plotData.m
#     gradientDescent.m
#     computeCost.m
#     gradientDescentMulti.m
#     computeCostMulti.m
#     featureNormalize.m
#     normalEqn.m
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#
# x refers to the population size in 10,000s
# y refers to the profit in $10,000s
#

#% Initialization
rm(list=ls())

#% ==================== Part 1: Basic Function ====================
source("warmUpExercise.R")
# Complete warmUpExercise.m 
cat('Running warmUpExercise ... \n');
cat('5x5 Identity Matrix: \n');
warmUpExercise()

readline("Press <return to continue") 


#% ======================= Part 2: Plotting =======================
source("plotData.R")
cat('Plotting Data ...\n')
data <- read.table("ex1data1.txt", header=FALSE, sep=",")
X <- data[, 1] 
y <- data[, 2]
m = length(y) # number of training examples

# Plot Data
# Note: You have to complete the code in plotData.m
plotData(data)

cat('Program paused. Press enter to continue.\n')
readline("Press <return to continue") 

##% =================== Part 3: Gradient descent ===================
source('computeCost.R')
source('gradientDescent.R')
cat('Running Gradient Descent ...\n')
#
X = cbind(rep(1, m), X) # Add a column of ones to x
theta = rep(0, 2) # initialize fitting parameters
#
## Some gradient descent settings
iterations = 1500
alpha = 0.01

## compute and display initial cost
#
## run gradient descent
res <- gradientDescent(X, y, theta, alpha, iterations)
theta <- res$Theta
J_history <- res$Hist
#
## print theta to screen
cat('Theta found by gradient descent: ')
cat('theta: ',theta[1], ' ', theta[2], '\n')
#
## Plot the linear fit
temp <- cbind(data, X%*%theta) #add regression y values
df <- as.data.frame(temp)
colnames(df) <- c("X","y","pred")
## ggplot2 way
require(ggplot2)
require(reshape2)
df <- melt(df, id.var="X")
p2 <- ggplot(df, aes(x=X, y=value)) 
p2 <- p2 + geom_point(data=df[df$variable=='y',], aes(colour=variable), shape='x', size=5)
p2 <- p2 + geom_line(data=df[df$variable=='pred',], aes(colour=variable) )
p2 <- p2 + ylab('Profit in $10,100s')
p2 <- p2 + xlab('Population of City in 10,000s')
print(p2)
#ggsave(p2, file="~/Desktop/ratings.pdf", scale=2)

## standard way
#plot(df$X, df$y,pch=3,col='red', xlab="population", ylab="profit")
#lines(df$X, df$pred, col='blue')
#legend("bottomright",'',c("y","pred"))
#legend('Training data', 'Linear regression')

## Predict values for population sizes of 35,000 and 70,000
predict1 = c(1, 3.5) %*% theta;
cat('For population = 35,000, we predict a profit of ' , predict1*10000 , '\n');
predict2 = c(1, 7) %*% theta;
cat('For population = 70,000, we predict a profit of ' , predict2*10000 , '\n');
readline("Press <return to continue") 

#
##% ============= Part 4: Visualizing J(theta_0, theta_1) =============
cat('Visualizing J(theta_0, theta_1) ...\n')
#
## Grid over which we will calculate J
theta0_vals = seq(-10, 10, length=100);
theta1_vals = seq(-1, 4, length=100);
#
## initialize J_vals to a matrix of 0's
J_vals = matrix(0, length(theta0_vals), length(theta0_vals));

## Fill out J_vals
source("computeCost.R")
for (i in 1:length(theta0_vals)) {
	for (j in 1:length(theta1_vals)) {
		 t = c(theta0_vals[i], theta1_vals[j]);
		 J_vals[i, j] = computeCost(X, y, t);
	}
}


# Not as pretty as matlab's surf, but does the job
# TODO: colors!
persp(theta0_vals, theta1_vals, J_vals,
	theta=30, phi=30, expand=0.6,
	col='lightblue', shade=0.75, ltheta=120,
	ticktype='detailed');


## Contour plot
# TODO: needs some work with data frame creation and melt function. There's gotta be a better way...

df = data.frame(theta0_vals, theta1_vals);
df$J_vals = J_vals;
melted = melt(df$J_vals); # not very sure what this does yet
ax = expand.grid(theta0_vals, theta1_vals);
melted$x = ax[,1];
melted$y = ax[,2];
names(melted) <- c("a", "b", "z", "x", "y")
plt <- ggplot(melted, aes(x, y, z = log(z)));
##plt <- plt + geom_tile(aes(fill=Jval));# + scale_fill_gradientn(colours=matlab.like(10));
plt <- plt + stat_contour(aes(colour = ..level..));
print(plt);
