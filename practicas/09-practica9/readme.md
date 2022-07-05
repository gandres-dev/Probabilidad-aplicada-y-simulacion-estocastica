---
title: "Práctica 9: Convergencia"
author: "Andrés Urbano Guillermo Gerardo (alumnolcd44)"
date: "14 de Octubre del 2021"
output: pdf_document
---

### Teorema central de límite

Para implementar el teorema del limite central, crearemos una funcion que se encargara de encontrar la variables aleatoria $z$, estará formada de esta forma:

```R
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
```

Para encontrar la convercia hacia una distribución normal, lo que haremos será generar $1000$ variables aleatorias usando el teorema del limite centro, esto nos dará variableas aleatorias que corresponden a una distribución normal $N(0,1)$, para demostrarlo implementaremos esta función:

```R

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
  hist(Z_uniform, main=paste('Teorema del limite central\n',msg), col='salmon', prob = TRUE)
  par(new = TRUE )
  sop <- seq( -5 ,5 , by=0.1 )
  plot(sop, dnorm(sop), type='l', col='blue', lwd=2)  
}

```

En esta función generaremos $1000$ variables aleatorias uniformes y las graficaremos para demostrar nuestra hipótesis, graficaremos un histograma de nuestras variables $Z$ y la vez la silueta de la distribución normal estándar. Ahora ya no seran promedios parciales como vimos anteriormente para la ley de los grandes números, sino usaremos suma parciales renormalizadas en cada iteración. Un detalle importante es que generaremos variables binomales que convergeran a la distribución normal.


Vemos que cuando tenemos como parámetro $p=0.5$ nuestro histograma fácilmente se puede observar como converge a una distribución normal, a pesar haber variado los parámetros $k=10, k=20, k=100, k=100$ no varia mucho, sigue teniendo la silueta de una normal. Puede deberse que le hemos asignado una probabilidad fija de $0.5$.


Podemos ver un gran contraste cuando tenemos $P=0.99$ para $k$ diferente, al principio con una $k=10$ los valores están muy alejados hacia los costados, conforme vamos aumentando $k$ el histograma se va comportando más a la distribución normal, moviendo haciendo a la derecha y llenando poco a poco la silueta de la distribución normal.


Podemos concluir que dada cualquier función de distribución y usando el teorema del limite central, las variables de esa distribución convergerá a hacia una distribución normal estándar. Esto es increíble dado que reafirmamos nuevamente la aparición de la distribución normal y su importancia, ya que para cual variables aleatoria de una distribución, usando el TLC veremos convergerá a una normal.


