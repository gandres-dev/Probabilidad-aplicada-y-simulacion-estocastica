---
title: 'Práctica 6: Método de Aceptación Rechazo'
author: "Andrés Urbano Guillermo Gerardo (alumnolcd44)"
date: "23 de Septiembre del 2021"
output:
  pdf_document: default
  html_document: default
---

## Metodo de aceptacion rechazo
El metodo de aceptación rechazo consiste en generar un punto aleatorio distribuido uniformente en la distribución de la cual queremos generar variables aleatorias. Nuestra método esta acotado con el rango de la distribución beta.

```r
#' Metodo aceptación-rechazo
#'
#' @param a limite inferior
#' @param b limite superior
#' @param c numero que acota nuestra función en altura.
#' @param alfa parámetros de forma.
#' @param beta parámetros de forma.
#'
#' @return un vector con la va e iteraciones emitidas.
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
```

El algoritmo consiste en generar las coordenadas de un punto aleatoria y verificar si ese punto se encuentra adentro de la distribución, para eso hacemos una condicional y si cumple nuestra condicion de que este dentro, devolverá la variable aleatoria que corresponde con el valor de la coordenada $x$ de nuestro punto generado anteriormente.

```r
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
```

Implementamos tambien la funcion de densidad para simular nuestro método, simplemente es escribir la función en terminos de los parámetro de la distribucion.

Para nuestra simulación:

```r
#' Simulación para generar variables aleatorias de distribucion beta.
#'
#' @param n - un entero que indique el numero de variables a simular.
#' @param c - un real que acotara nuestra función en altura.
#' @param alfa - parámetros de forma.
#' @param beta - parámetros de forma.
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
```

El método simular une todas nuestras funciones para generar $n$ variables aleatorias de nuestra función de distribución beta, consiste en un `for` de $1$ hasta $n$ donde guardaremos cada variable generada por nuestro método de aceptación rechazo al igual que el número de intentos o iteraciones que hubo al encontrar dicha variable.

Para graficar el histograma y la función de distribución para distintas $n$ utilizaremos este código que iremos cambiando la $n$ correspondiente, para nuestros primeros histogramas para nuestra distribución beta con parámetos $beta(2,2)$ utilizamos una $c=1/2$, encontramos este valor con el criterio de la segunda derivada, ya que necesitamos el valor máximo de nuestra función para poder acotar correctamente la altura, para que nuestro punto aleatorio no se aleje demasiado de nuestra distribución.

```r

#n=10
aux <- simular(10, 1/2, 2, 2)
va <- unlist(aux[1])
hist(va ,probability=TRUE, breaks=10, main="Histograma con 10 simulaciones",col = "salmon2")
par(new=TRUE)
lines(graf_x, graf1_y, col="blue")
par(new=FALSE)
```




Podemos ver claramente que conforme más simulaciones hacemos los valores de nuestra variable aletoria van tomando la forma de nuestra función de distribución, con esto podemos concluir claramente que nuestra simulación de aceptación rechazo es correcta, debido a que la función de probabilidad nos indica la probabilidad de cierta variable aleatoria ocurra, por lo tanto al generar variables aleatorias de la distribución debe coincidir de igual forma con la frecuencia de aparición de cada experimento. Una cosa a recalcar es que si hacemos muchas simulaciones deberíamos estar cada vez más cerca de nuestra linea azul.   

La complejidad de nuestro algoritmo del método aceptación-rechazo seria $O(n)$ debido a que solo utilizamos un loop, el cual se detendrá cuando la condición de la altura del punto este dentro del área de nuestra distribución,y en el mejor de los casos seria $O(1)$, esto es si en el primer intento cae dentro y como consecuencia termina nuestra función.

```r
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
plot(intentos, promedios1,
     type="l", col="red", main="Promedio de intentos al simular n valores",
     xlab="valores simulados", ylab= "promedio de intentos")
par=(new=FALSE)
lines(intentos, promedios2, col="blue")
legend("topleft",
       legend=c("Promedio de intentos para alfa=2,beta=2", 
                "Promedio de intentos para alfa=2,beta=5"),col=c("red", "blue"),
       lty = 1:2, cex=0.8)
```


Para el promedio de iteraciones o intentos para simular n variables, hicimos un ciclo $for$ de $1$ hasta $1000$, obteniendo por cada simulación el promedio, que seria sumando el numero de intentos que se hizo entre el numero de simulaciones, que corresponde al tamaño de nuestra variable `intentos` y lo graficamos. Vemos que para los primeros valores el promedio aumenta y disminuye, pero a partir de la simulación con $n=400$ llegaba con un promedio entre 1.4 y 1.6 de intentos y asi sucesivamente con los demás valores.

Cuando la variable aleatoria $beta$ toma como parámetros $\lambda = 1$ y $\beta = 1$ podemos decir que se reduce a una distribución uniforme debido a que si sustituimos los valores, quedaría:
$$
beta(x, 1, 1) = 1
$$
La cual nos indica que para cualquier valor que tome la función de distribución su probabilidad sera siempre 1, por lo tanto para cada variable aleatoria tiene la misma probabilidad, gráficamente seria un linea recta que iría de 0 a 1.


