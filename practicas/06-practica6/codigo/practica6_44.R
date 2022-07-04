
#' Función de densidad beta.
#'
#' Describe modelos los cuales la v.a representan proporciones o porcentajes.
#'
#' @param x - representa la variable aleatoria.
#' @param alfa - parámetros de forma.
#' @param beta - parámetros de forma.
#'
#' @return - la probabilidad de la v.a.
densidad_beta= function(x,alfa,beta){
  return((x^(alfa-1)*(1-x)^(beta-1))/beta(alfa,beta))
}



#' Metodo aceptación-rechazo
#'
#' @param a limite inferior
#' @param b limite superior
#' @param c numero que acota nuestra función en altura.
#' @param alfa parámetros de forma.
#' @param beta parámetros de forma.
#'
#' @return un vector con la v.a e iteraciones emitidas.
metodo_acep_rechazo= function(a,b,c, alfa, beta){
  iter <- 0
  while(1){
    iter <- iter +1
    varX <- runif(1,a,b)
    varY <- runif(1,0,c)
    if(varY <= densidad_beta(varX, alfa, beta)){
      return(c(varX,iter))
    }
  }
}

# beta(2,2) c = 1/2
# beta(2,5) c = 1/5


#'  Simulación para generar variables aleatorias de distribucion beta.
#'
#' @param n - un entero que indique el numero de variables a simular.
#' @param c - un real que acotara nuestra función en altura.
#' @param alfa parámetros de forma.
#' @param beta parámetros de forma.
#'
#' @return una lista con las variables aleatorias y numero de intentos.
simular <- function(n, c, alfa, beta){
  va <- c()
  iter <- c()
  c_1 <- densidad_beta(c, alfa, beta)
  for(i in 1:n){
    aux <- metodo_acep_rechazo(0,1, c_1, alfa, beta)
    va [i] <- aux[1]
    iter[i] <- aux[2]
  }
  return(list(va, iter))
}

#llenando las graficas para graficar con el histograma
graf_x=seq(0,1, by=0.0001)
graf1_y=c()
graf2_y=c()
graf_x=graf_x[-1]
j=0
for(i in seq(0,1,0.0001)){
  graf1_y[j]=densidad_beta(i,2,2)
  graf2_y[j]=densidad_beta(i,2,5)
  j=j+1
}

# Histogramas
#----------------------- Para beta(2,2)----------------------------------------
#n=10
aux <- simular(10, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=10, main="Histograma con 10 simulaciones",col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)

#n=100
aux <- simular(100, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=10, main="Histograma con 100 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)

#n=500
aux <- simular(500, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=50, main="Histograma con 500 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)

#n=1000
aux <- simular(1000, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=50, main="Histograma con 1000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)

#n=3000
aux <- simular(3000, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 3000 simulaciones", col = "salmon2")
par(new=TRUE)
par(new=FALSE)
lines(graf_x, graf1_y, col="blue")

#n=5000
aux <- simular(5000, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 5000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)

#n=10000
aux <- simular(10000, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 10000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)


#------------------Para beta(2,5)----------------------------------------------
#n=10
aux <- simular(10, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=10, main="Histograma con 10 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=100
aux <- simular(100, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=10, main="Histograma con 100 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=500
aux <- simular(500, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=50, main="Histograma con 500 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=1000
aux <- simular(1000, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=50, main="Histograma con 1000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=3000
aux <- simular(3000, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 3000 simulaciones", col = "salmon2")
par(new=TRUE)
par(new=FALSE)
lines(graf_x, graf2_y, col="blue")

#n=5000
aux <- simular(5000, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 5000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=10000
aux <- simular(10000, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 10000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)

#n=1000000
aux <- simular(1000000, 1/5,2, 5)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=100, main="Histograma con 10000 simulaciones", col = "salmon2")
par(new=TRUE)
lines(graf_x, graf2_y, col="blue")
par(new=FALSE)


#--------------------promedio de intentos---------------------------------------
intentos=seq(1, 1000)
intentos=intentos
promedios1=c()
promedios2=c()
for(i in 1:1000){
  aux1=simular(i,1/2,2,2)
  intentos1=unlist(aux1[2])
  aux2=simular(i,1/5,2,5)
  intentos2=unlist(aux2[2])
  promedios1[i]=sum(intentos1) /length(intentos1)
  promedios2[i]=sum(intentos2) /length(intentos2)
}
plot(intentos, promedios1, type="l", col="red", main="Promedio de intentos al simular n valores",xlab="valores simulados", ylab = "promedio de intentos")
par=(new=FALSE)
lines(intentos, promedios2, col="blue")
legend("topleft", legend=c("Promedio de intentos para α=2,β=2", "Promedio de intentos para α=2,β=5"),col=c("red", "blue"), lty = 1:2, cex=0.8)


