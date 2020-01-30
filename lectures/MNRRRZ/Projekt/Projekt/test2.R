x <- function(t){
 exp(-4*t) * (cos(2*t) + sin(2*t))
}
y <- function(t){
  exp(-4*t)*(2*cos(2*t) - 2*sin(2*t))
}

Right <- function(t, x, y){
  c(-4*x+y, -4*x-4*y)
}

x_0 <- 1
y_0 <- 2

grid <- data.frame(grid = seq(0,10, by = 0.001))
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
  sol <- SH(grid, h, Right, c(x_0, y_0), n)
  lines(sol[, 1], sol[,2], col = 'red', lwd = 2)
}

x0 <- 1
y0 <- 2
dx <- '-4*x+y'
dy <- '-4*x-4*y'
x <- 'exp(-4*t) * (cos(2*t) + sin(2*t))'
y <- 'exp(-4*t)*(2*cos(2*t) - 2*sin(2*t))'

functions <- Constructor(x, y, dx, dy)
Solution(functions, grid, x0, y0, method = 'ModifiedEuler')
