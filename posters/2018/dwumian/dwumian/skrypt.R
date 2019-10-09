library(corpcor)

T1<-Sys.time()
kernel<-function(x){1/(sqrt(2*pi*0.05^2))*exp(-x^2/(2*0.05^2))} # j¹dro konwolucji
n<-50 #gêstoœc siatki
grid<-1:n/n #siatka
f<-rep(0,n) #prawdziwa funckja
for (i in 1:n){
  if(grid[i]<0.333){f[i]<-(-grid[i])}
  else {f[i]<-2*grid[i]-1}
}

A<-toeplitz(kernel(grid))/n #macierz zdyskretyzowanej konwolucji
noiselevel<-max(A%*%f) #maksimum wejœcia
error.g<-A%*%f+rnorm(n,0,0.05*noiselevel) #zaburzony odczyt konwolucji
plot(grid,f,type = "l",xlab="",ylab="",las=1,col="blue")
lines(grid,error.g,col="red")
legend(0,0.8,legend = c("f","Af+e"),lty=c(1,1),col=c("blue","red"),cex=0.85, text.width=1,bty = "n")


D<-fast.svd(A)

#TSVD
#liczymy kolejne rozwi¹zania
xk<-matrix(rep(0,n*n),nrow = n)
discr<-rep(0,n) #zasada rozbie¿nosci
for (k in 2:n){
  xk[,k]<-(D$v[,1:k]%*%diag(1/(D$d[1:k]))%*%t(D$u[,1:k]))%*%error.g
  discr[k]<-norm(error.g-A%*%xk[,k],type = "F")
}
delta<-norm(error.g-A%*%f,type = "F")#obliczmy delte do zasady
i=1#znajdujemy miejsce obciêcia
while(discr[i]>delta){i=i+1}
i


#b³ad absolutny
norm(f-t(xk[,i]),type = "F")


#Tichonov
xm<-matrix(rep(0,10*n*n),nrow = n)
for (m in 2:(10*n)){
  xm[,m]<-(D$v[,1:n]%*%diag((D$d[1:n])/((D$d[1:n])^2+(m/(100*n))))%*%t(D$u[,1:n]))%*%error.g
}
j=2
while(norm(A%*%xm[,j]-error.g,type = "F")<delta){j=j+1}
j-1
norm(f-t(xm[,j-1]),type = "F")





plot(grid,f,typ="l",xlab="",ylab = "",las=1,ylim = c(-0.1,1.2))
lines(grid,xk[,i],col="green")
lines(grid,xm[,j-1],col="red")
legend(0,0.8,legend = c("f","TSVD","Tichonov"),lty=c(1,1),col=c("black","green","red"),cex=0.85, text.width=1,bty = "n")

T2<-Sys.time()
T2-T1


