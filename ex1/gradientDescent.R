gradientDescent <- function(X, y, theta, alpha, num_iters){
#GRADIENTDESCENT Performs gradient descent to learn theta
#   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
#   taking num_iters gradient steps with learning rate alpha

# Initialize some useful values
m = length(y) # number of training examples
J_history = rep(1, num_iters)

for (iter in 1:num_iters){

    # ====================== YOUR CODE HERE ======================
    # Instructions: Perform a single gradient step on the parameter vector
    #               theta. 
    #
    # Hint: While debugging, it can be useful to print out the values
    #       of the cost function (computeCost) and gradient here.
    #
	#cat("iteration: ",iter,'\n')

	h_theta <- X %*% theta;

	sum_term <- t(h_theta - y) %*% X; # sum each column of X multiplied (or weighted) by vector (h_theta - y)

	#term2 <- (alpha * (1/(m)) * t(sum_term))
	theta <- theta - (alpha * (1/(m)) * t(sum_term))
	
	#print(theta)

    # ============================================================

    # Save the cost J in every iteration    
	cost <- computeCost(X, y, theta)
	#cat(cost,"\n")
    J_history[iter] <- cost

	}
return(list(Theta=theta, Hist=J_history))
}
