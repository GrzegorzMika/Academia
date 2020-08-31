x <- function(t){
  exp(-3*t) * (cos(t) + 3*sin(t))
}
y <- function(t){
  2*exp(-3*t) * (cos(t) - 2*sin(t))
}

Right <- function(t, x, y){
  c(-2*x+y, -2*x-4*y)
}

x_0 <- 1
y_0 <- 2

grid <- data.frame(grid = seq(0, 10, by = 0.001))
SH <- function(grid, h, Right, start, n){
  
  TrueFun <- data.frame(first = rep(start[1], n), second = rep(start[2], n))
  for(i in 2:n) {
    r <- Right(0 + i*h, TrueFun[i-1, 'first'], TrueFun[i-1, 'second'])
    temp <- TrueFun[i - 1,] + h/2*(r + Right(0 + i*h, TrueFun[i - 1,'first'] + h*r[1], TrueFun[i - 1,'second'] + h*r[2]))
    TrueFun[i, 'first'] <- temp[1]
    TrueFun[i, 'second'] <- temp[2]
  }
  Real <- data.frame(first = x(grid$grid), second = y(grid$grid))
  Error <- integer(n)
  for(i in 1:n){
    Error[i] <- (TrueFun[i, 1] - x(grid$grid[i]))^2 +  (TrueFun[i, 2] - y(grid$grid[i]))^2
  }
  print(sqrt(mean(Error)))
  return(TrueFun)
}
par(mfrow = c(3,3))

for(i in 1:9){

n <- 40 + (i-4)*10
h <- 10/n

plot(x(grid$grid), y(grid$grid), type = 'l', lwd = 2, main = paste('Krok = ', h), ylim = c(-1, 5), xlab = 'x', ylab = 'y')

# 
# plot(x(grid$grid), y(grid$grid), type = 'l', lwd = 2, main = paste('Krok = ', h), ylim = c(-1, 5), xlab = 'x', ylab = 'y')
sol <- SH(grid, h, Right, c(1,2), n)
lines(sol[, 1], sol[,2], col = 'red', lwd = 2)
}

