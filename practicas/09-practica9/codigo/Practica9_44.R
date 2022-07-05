#' Teorema del limite central
#'
#' @param X - vector de variables aleatorias
#' @param mu - media
#' @param varianza - varianza
#'
#' @return - variable aleatoria N(0,1)
teorema_limite_central <- function(X, mu, varianza) {
  k <- length(X)
  z <- (sum(X) - k*mu) / (k*varianza)^(1/2)
  return(z)
}

#' Simula variable aleatorias N(0,1) a partir de binomiales(n,p)
#'
#' @param N - numero de variables aleatorias Z
#' @param n - numero de ensayos para la 
#' @param p - Probabilidad de exito
#' @param k - total de binomiales
#'
#' @return - una grafica y un histograma
simular_Z <- function(N, n, p, k, msg="") {
  q <- 1-p
  mu <- n*p
  varianza <- n*p*q 
  Z_uniform <- c()
  for (i in 1:N){
    binomiales <- rbinom(k, n, p)
    Z_uniform[i] <- teorema_limite_central(binomiales, mu, varianza)
  }
  hist(Z_uniform, main=paste('Teorema del limite central\n',msg), col='salmon', 
       prob = TRUE, xlab='', ylab ='',ylim=c(0.0, 0.5), xlim=c(-4, 4))
  
  par(new = TRUE )
  sop <- seq( -5 ,5 , by=0.1 )
  plot(sop, dnorm(sop), type='l', col='blue', lwd=2, ylim=c(0.0, 0.5), 
       xlim=c(-4, 4))  
}

#---------------------Para n = 10, p = 0.5, k = 10------------------------------
N <- 1000 
n <- 10
p <- 0.5
k <- 10
simular_Z(N, n, p, k, 'Para n = 10, p = 0.5, k = 10')

#---------------------Para n = 10, p = 0.5, k = 20------------------------------
N <- 1000 
n <- 10
p <- 0.5
k <- 20
simular_Z(N, n, p, k, 'Para n = 10, p = 0.5, k = 20')

#---------------------Para n = 10, p = 0.5, k = 100-----------------------------
N <- 1000 
n <- 10
p <- 0.5
k <- 100
simular_Z(N, n, p, k, 'Para n = 10, p = 0.5, k = 100')

#---------------------Para n = 10, p = 0.5, k = 1000----------------------------
N <- 1000 
n <- 10
p <- 0.5
k <- 1000
simular_Z(N, n, p, k, 'Para n = 10, p = 0.5, k = 1000')

#-------------------------------------------------------------------------------
#---------------------Para n = 10, p = 0.99, k = 10-----------------------------
N <- 1000 
n <- 10
p <- 0.99
k <- 10
simular_Z(N, n, p, k, 'Para n = 10, p = 0.99, k = 10')

#---------------------Para n = 10, p = 0.99, k = 20-----------------------------
N <- 1000 
n <- 10
p <- 0.99
k <- 20
simular_Z(N, n, p, k, 'Para n = 10, p = 0.99, k = 20')

#---------------------Para n = 10, p = 0.99, k = 100----------------------------
N <- 1000 
n <- 10
p <- 0.99
k <- 100
simular_Z(N, n, p, k, 'Para n = 10, p = 0.99, k = 100')

#---------------------Para n = 10, p = 0.99, k = 1000---------------------------
N <- 1000 
n <- 10
p <- 0.99
k <- 1000
simular_Z(N, n, p, k, 'Para n = 10, p = 0.99, k = 1000')

