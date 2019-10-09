metody<-function(b=1){
  T1<-Sys.time()
  library(corpcor)
  kernel<-function(x){1/(sqrt(2*pi*0.05^2))*exp(-x^2/(2*0.05^2))}
  n<-20
  f<-rep(0,n)
  grid<-1:n/n
  if(b==1){
    for (i in 1:n){
      if(grid[i]<0.4 || grid[i]>0.6){f[i]<-0}
      else {f[i]<-1}
    }
  }
  else 
    if(b==2){
      for (i in 1:n){
        if(grid[i]<0.25 || grid[i]>0.75){f[i]<-0}
        else {f[i]<-1}
      }
    }
  else
    if(b==3){
      for (i in 1:n){
        f[i]<-sin(pi*grid[i])
      }
    }
  else
    if(b==4){
      for (i in 1:n){
        if(grid[i]<0.333){f[i]<-(-grid[i])}
        else {f[i]<-2*grid[i]-1}
      }
    }
  else
    for (i in 1:n){
      f[i]<-grid[i]^7
    }
  par(mfrow=c(2,2))
  A<-toeplitz(kernel(grid))/n #macierz zdyskretyzowanej konwolucji
  noiselevel<-max(A%*%f) #maksimum wejœcia
  error.g<-A%*%f+rnorm(n,0,0.05*noiselevel) #zaburzony odczyt konwolucji
  
  plot(grid,f,type = "l",xlab="",ylab="",las=1,col="blue",main = "funkcja zaburzona",ylim = c(-0.3,1.5))
  lines(grid,error.g,col="red")
  legend(0,1.5,legend = c("f","Af+e"),lty=c(1,1),col=c("blue","red"),cex=0.85, text.width=1,bty = "n")
  
  D<-fast.svd(A)
  #URE
  ure<-function(N,data,sigma,epsilon){
    -sum(data[1:N]^2)+2*epsilon^2*sum(sigma[1:N]^2)
  }
  U<-rep(0,n)
  for (i in 1:n){
    U[i]<-ure(i,error.g,1/D$d,0.05*noiselevel)
  }
  b<-min(U[2:n])
  j=2
  while(U[j]!=b){j=j+1}
  xu<-rep(0,n)
  xu<-(D$v[,1:j]%*%diag(1/(D$d[1:j]))%*%t(D$u[,1:j]))%*%error.g
  
  plot(grid,f,typ="l",xlab="",ylab = "",las=1,ylim = c(-0.3,1.5),main = "URE")
  lines(grid,xu,col="green")
  legend(0,1.5,legend = c("b³¹d",round(norm(f-xu,type = "F"),6)),cex=0.85, text.width=1,bty = "n")
 
  #TSVD
  
  xk<-matrix(rep(0,n*n),nrow = n)
  discr<-rep(0,n) #zasada rozbie¿nosci
  for (k in 2:n){
    xk[,k]<-(D$v[,1:k]%*%diag(1/(D$d[1:k]))%*%t(D$u[,1:k]))%*%error.g
    discr[k]<-norm(error.g-A%*%xk[,k],type = "F")
  }
  delta<-norm(error.g-A%*%f,type = "F")#obliczmy delte do zasady
  i=2#znajdujemy miejsce obciêcia
  while(discr[i]>delta){i=i+1}
  
 
  plot(grid,f,typ="l",xlab="",ylab = "",las=1,ylim = c(-0.3,1.5),main = "TSVD")
  lines(grid,xk[,i],col="green")
  legend(0,1.5,legend = c("b³¹d",round(norm(f-t(xk[,i]),type = "F"),6)),cex=0.85, text.width=1,bty = "n")
  #Tichonov
  xm<-matrix(rep(0,10*n*n),nrow = n)
  for (m in 2:(10*n)){
    xm[,m]<-(D$v[,1:n]%*%diag((D$d[1:n])/((D$d[1:n])^2+(m/(100*n))))%*%t(D$u[,1:n]))%*%error.g
  }
  k=2
  while(norm(A%*%xm[,k]-error.g,type = "F")<delta){k=k+1}
  
  plot(grid,f,typ="l",xlab="",ylab = "",las=1,ylim = c(-0.3,1.5),main = "Tichonov")
  lines(grid,xm[,k-1],col="green")
  legend(0,1.5,legend = c("b³¹d",round(norm(f-t(xm[,k-1]),type = "F"),6)),cex=0.85, text.width=1,bty = "n")
  T2<-Sys.time()
  T2-T1
}

metody(1)
metody(2)
metody(3)
metody(4)
metody(5)
