library(ggplot2)

plotData <- function(data){
#PLOTDATA Plots the data points x and y into a new figure 
#   PLOTDATA(x,y) plots the data points and gives the figure axes labels of
#   population and profit.

# ====================== YOUR CODE HERE ======================
# Instructions: Plot the training data into a figure using the 
#               "figure" and "plot" commands. Set the axes labels using
#               the "xlabel" and "ylabel" commands. Assume the 
#               population and revenue data have been passed in
#               as the x and y arguments of this function.
#
# Hint: You can use the 'rx' option with plot to have the markers
#       appear as red crosses. Furthermore, you can make the
#       markers larger by using plot(..., 'rx', 'MarkerSize', 10);

p <- ggplot(data, aes(x=data[,1], y=data[,2])) + geom_point(shape='x', size=5, colour='red') 

p <- p + ylab('Profit in $10,100s')
p <- p + xlab('Population of City in 10,000s')

print(p)
# ============================================================

}
