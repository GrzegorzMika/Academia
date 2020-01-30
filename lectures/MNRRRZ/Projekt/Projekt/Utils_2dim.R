Solver_2dim <- function(grid, h, x, y, Right, start, n, method) {
  TrueFun <- data.frame(first = rep(start[1], n), second = rep(start[2], n))

  if (method == "Heun") {
    for (i in 2:n) {
      r <- Right(0 + (i - 1) * h, TrueFun[i - 1, "first"], TrueFun[i - 1, "second"])
      temp <- TrueFun[i - 1, ] + h / 2 * (r + Right(0 + i * h, TrueFun[i - 1, "first"] + h * r[1], TrueFun[i - 1, "second"] + h * r[2]))
      TrueFun[i, "first"] <- temp[1]
      TrueFun[i, "second"] <- temp[2]
    }
  }
  if (method == "ModifiedEuler") {
    for (i in 2:n) {
      r <- Right(0 + (i - 1) * h, TrueFun[i - 1, "first"], TrueFun[i - 1, "second"])
      temp <- TrueFun[i - 1, ] + h * Right(
        0 + (i - 1) * h + h / 2,
        TrueFun[i - 1, "first"] + h / 2 * r[1], TrueFun[i - 1, "second"] + h / 2 * r[2]
      )
      TrueFun[i, "first"] <- temp[1]
      TrueFun[i, "second"] <- temp[2]
    }
  }
  if (method == "RK2") {
    for (i in 2:n) {
      k1 <- h * Right(0 + (i - 1) * h, TrueFun[i - 1, "first"], TrueFun[i - 1, "second"])
      temp <- TrueFun[i - 1, ] + h * Right(0 + (i - 1) * h + h / 2, TrueFun[i - 1, "first"] + k1[1] / 2,
                                           TrueFun[i - 1, "second"] + k1[2] / 2)

      TrueFun[i, "first"] <- temp[1]
      TrueFun[i, "second"] <- temp[2]
    }
  }
  Error <- integer(n)
  for (i in 1:n) {
    Error[i] <- (TrueFun[i, 1] - x(0 + i * h))^2 + (TrueFun[i, 2] - y(0 + i * h))^2
  }
  print(paste("Step =", round(h, 4)))
  print(paste("MSE =", round(sqrt(mean(Error)), 2)))
  return(TrueFun)
}

Constructor <- function(True_first, True_second, Eq_first, Eq_second) {
  eval(parse(text = paste("x <- function(t) { return(", True_first, ")}", sep = "")))
  eval(parse(text = paste("y <- function(t) { return(", True_second, ")}", sep = "")))
  eval(parse(text = paste("Right <- function(t, x, y) { return(", "c(", Eq_first, ",", Eq_second, ")", ")}", sep = "")))
  return(list(x = x, y = y, Right = Right))
}

Solution <- function(functions, grid, x0, y0, method) {
  par(mfrow = c(3, 3))
  for (i in 1:9) {
    n <- 40 + (i - 4) * 10
    h <- 10 / n

    sol <- Solver_2dim(grid, h, x = functions$x, y = functions$y, Right = functions$Right, c(x0, y0), n, method)
    plot(functions$x(grid$grid), functions$y(grid$grid), type = "l", lwd = 2,
         main = paste("Krok = ", h), ylim = c(-1, 5), xlab = "x", ylab = "y")
    lines(sol[, 1], sol[, 2], col = "red", lwd = 2)
  }
}
