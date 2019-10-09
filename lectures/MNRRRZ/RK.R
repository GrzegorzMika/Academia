#Schemat Rungego–Kutty czteropoziomowy
require(tictoc)
require(dplyr)

f <- function(t, x){ 1/sqrt(2 * pi) * exp(-t^2/2)}
LowerLimit <- 0
UpperLimit <- 5
NumberOfSteps <- 1000
x0 <- 0.5
True <- function(t){ pnorm(t)}

#####################################################################

RK4 <- function(f, LowerLimit, UpperLimit, NumberOfSteps, x0, True){
h <- (UpperLimit - LowerLimit)/NumberOfSteps
Grid <- seq(LowerLimit, UpperLimit, h)
Solution <- integer(NumberOfSteps + 1)
Real <- integer(NumberOfSteps + 1)
Solution[1] <- x0

for(i in 2:(NumberOfSteps + 1)){
  
  K1 <- f(Grid[i - 1], Solution[i - 1])
  K2 <- f(Grid[i - 1] + h/2, Solution[i - 1] + h * K1 / 2)
  K3 <- f(Grid[i - 1] + h/2, Solution[i - 1] + h * K2 / 2)
  K4 <- f(Grid[i - 1] + h, Solution[i - 1] + h * K3)
  
  Solution[i] <- Solution[i - 1] + h * (K1 + 2 * K2 + 2 * K3 + K4) / 6
}
i <- seq(0, NumberOfSteps)
Real <- True(Grid)
Solution <- data.frame(Index = i, Fun = Solution, Grid = Grid, Real = Real)
plot(Solution$Grid, Solution$Fun, type = 'l', main = paste('Solution for', NumberOfSteps, 'steps'),
     xlab = 'Grid', ylab = 'Solution', las = 1)
lines(Solution$Grid, Real, col = 'red')

return(Solution)
}


Sol <- RK4(f, LowerLimit, UpperLimit, NumberOfSteps, x0, True)
Sol1 <- RK4(f, LowerLimit, UpperLimit, 2 * NumberOfSteps, x0, True) %>% filter(Index %% 2 == 0)
Sol2 <- RK4(f, LowerLimit, UpperLimit, 4 * NumberOfSteps, x0, True) %>% filter(Index %% 4 == 0)

mean(log(max(abs(Sol$Real - Sol$Fun)) / max(abs(Sol1$Real - Sol1$Fun)), 2),
log(max(abs(Sol1$Real - Sol1$Fun)) / max(abs(Sol2$Real - Sol2$Fun)), 2),
log(max(abs(Sol$Real - Sol$Fun)) / max(abs(Sol2$Real - Sol2$Fun)), 4))

plot(Sol$Real - Sol$Fun, type = 'l')                           
