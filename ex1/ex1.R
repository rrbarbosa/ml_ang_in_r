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
#print(computeCost(X, y, theta))
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
#require(ggplot2)
#require(reshape2)
#df <- melt(df, id.var="X")
#p2 <- ggplot(df, aes(x=X, y=value)) 
#p2 <- p2 + geom_point(data=df[df$variable=='y',], aes(colour=variable), shape='x', size=5)
#p2 <- p2 + geom_line(data=df[df$variable=='y']df[df$variable=='pred',], aes(colour=variable) )
#p2 <- p2 + ylab('Profit in $10,100s')
#p2 <- p2 + xlab('Population of City in 10,000s')
#print(p2)
#ggsave(p2, file="/Users/barbosarr/Desktop/ratings.pdf", scale=2)

## standard way
plot(df$X, df$y,pch=3,col='red', xlab="population", ylab="profit")
lines(df$X, df$pred, col='blue')
legend("bottomright",'',c("y","pred"))

#legend('Training data', 'Linear regression')
#hold off % don't overlay any more plots on this figure
#
## Predict values for population sizes of 35,000 and 70,000
#predict1 = [1, 3.5] *theta;
#fprintf('For population = 35,000, we predict a profit of %f\n',...
#    predict1*10000);
#predict2 = [1, 7] * theta;
#fprintf('For population = 70,000, we predict a profit of %f\n',...
#    predict2*10000);
#
#fprintf('Program paused. Press enter to continue.\n');
#pause;
#
##% ============= Part 4: Visualizing J(theta_0, theta_1) =============
#fprintf('Visualizing J(theta_0, theta_1) ...\n')
#
## Grid over which we will calculate J
#theta0_vals = linspace(-10, 10, 100);
#theta1_vals = linspace(-1, 4, 100);
#
## initialize J_vals to a matrix of 0's
#J_vals = zeros(length(theta0_vals), length(theta1_vals));
#
## Fill out J_vals
#for i = 1:length(theta0_vals)
#    for j = 1:length(theta1_vals)
#	  t = [theta0_vals(i); theta1_vals(j)];    
#	  J_vals(i,j) = computeCost(X, y, t);
#    end
#end
#
#
## Because of the way meshgrids work in the surf command, we need to 
## transpose J_vals before calling surf, or else the axes will be flipped
#J_vals = J_vals';
## Surface plot
#figure;
#surf(theta0_vals, theta1_vals, J_vals)
#xlabel('\theta_0'); ylabel('\theta_1');
#
## Contour plot
#figure;
## Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
#contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
#xlabel('\theta_0'); ylabel('\theta_1');
#hold on;
#plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
