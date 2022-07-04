---
title: "Práctica 5: Método de la Transformada Inversa para V.A. Continuas"
author: "Andrés Urbano Guillermo Gerardo (alumnolcd44)"
date: "16 de Septiembre del 2021"
output: pdf_document
---



Generación de variables aleatorias a partir del método de la transformada inversa.

Ubicaremos nuestra función de distribución acumulada y obtendremos su función inversa, a partir de ahí podremos generar variables aleatorios que estarán ubicadas en eje x de la función de distribución.

Para hacer la generación de variables aleatorias nosotros propondremos valores pseudoaleatorios entre [0,1] que representar probabilidades de nuestra función de distribución acumulada y usando la función inversa obtendremos sus variables aleatorias.\

\ \
Procedimiento para encontrar la $F^{-1}(u)$ de la variable aleatoria Weibull: 

\begin{equation*}
\begin{split}
    F(x, \lambda , k) & = 1 - e^{-(\frac{x}{\lambda})^k}\\
    u & = 1 - e^{-(\frac{x}{\lambda})^k} \\
    u - 1 &= - e^{-(\frac{x}{\lambda})^k}\\
    1 - u &= e^{-(\frac{x}{\lambda})^k} \\
    ln(1 - u) &= -(\frac{x}{\lambda})^k \\
    -ln(1 - u) &= (\frac{x}{\lambda})^k \\
    [-ln(1 - u)]^{\frac{1}{k}} &= \frac{x}{\lambda}\\
    (\lambda) [-ln(1 - u)]^{\frac{1}{k}} &= x\\
     x &= (\lambda) [-ln(1 - u)]^{\frac{1}{k}}\\ \\
    x &= F^{-1}(u, \lambda, k) \\
     F^{-1}(u, \lambda, k) &= [-ln(1 - u)]^{\frac{1}{5}}
\end{split}    
\end{equation*}

```r
library("SciViews")
#' Función de densidad weibul
#'
#' @param x - valor de la variable aleatoria
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return - probabilidad del valor v.a
densidad_weibul <- function(x, lamda, k) {
  return((k/lamda) * (x/lamda)^(k-1) * exp(-(x/lamda)^k))
}

#' Función inversa de la distribución weibul.
#'
#' @param u - probabilidad acumulada.
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return variable aleatoria correspondiente.
inversa_distribucion_weibul <- function(u, lamda, k) {
  return(lamda * (-ln(1-u))^(1/k))
}
```

Una vez creadas nuestra función de distribucion y densidad, creamos nuestra funcion que genarará $n$ variables aleatorias:

```r
#' Generador de variables aleatorias weibul.
#'
#' @param n - numero de variables.
#' @param lamda - parámetro de forma.
#' @param k - parámetro de escala.
#'
#' @return vector de variables aleatorias.
generacion_va_weibul <- function(n, lamda, k) {
  va = c()
  for (i in 1:n) {
    u = runif(1)
    va[i] = inversa_distribucion_weibul(u, lamda, k)
  }
  return(va)
}
```

Generaremos un número aleatoria uniforme entre $[0, 1]$ que representa la probabilidad acumulada de nuestra función de distribución, depues usaremos la función inversa para generar su correspondiente variables aleatoria.

```r
# Histograma para v.a weibul 1
va_weibul = generacion_va_weibul(100, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 100', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.8, col = 'blue')
```



```r
# Histograma 2 para v.a weibul 
va_weibul = generacion_va_weibul(1000, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 1000', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.3, col = 'blue')
```


```r
# Histograma 3 para v.a weibul
va_weibul = generacion_va_weibul(100000, 1, 5)
hist(va_weibul, probability = TRUE, main = 'Weibul n = 100000', xlab = '', col = 'salmon2')
par(new=TRUE)
plot(va_weibul, densidad_weibul(va_weibul, 1 ,5), pch = 20, cex = 0.3, col = 'blue')
```


Vemos que nuestras variables aleatorias generados con el método de la transformación inversa al evaluarlas en las función de densidad y graficarlas, siguen la forma de nuestro histograma, esto quiere decir que nuestras variables aleatorias corresponden precisamente a su distribución.

----

Procedimiento para encontrar la $F^{-1}(u)$ de la variable aleatoria Pareto:

\begin{equation*}
\begin{split}
    F(x, a, b) &= 1 - (\frac{b}{b+x})^{a}\\
    u &= 1 - (\frac{b}{b+x})^{a}\\
    u - 1 &= - (\frac{b}{b+x})^{a}\\
    1 - u &= (\frac{b}{b+x})^{a} \\
    (1 - u)^{\frac{1}{a}} &= \frac{b}{b+x} \\
    b+x &= \frac{b}{(1 - u)^{\frac{1}{a}}}\\
    x &= \frac{b}{(1 - u)^{\frac{1}{a}}} - b\\ \\
    x &= F^{-1}(u, a, b)\\
    F^{-1}(u, a, b) &= \frac{3}{(1 - u)^{\frac{1}{10}}} - 3
\end{split}    
\end{equation*}


```r
#' Función de densidad pareto.
#'
#' @param x - valor de la variable aleatorio.
#' @param a - es el límite inferior de los datos.
#' @param b - es el parámetro de forma.
#'
#' @return - probabilidad que suceda el valor de la v.a
densidad_pareto <- function(x, a, b) {
  return((a * b^a)/(b+x)^(a+1))
}

#' Función inversa de la distribución pareto
#'
#' @param u - probabilidad acumulada.
#' @param a - es el límite inferior de los datos
#' @param b - es el parámetro de forma
#'
#' @return variable aleatorio correspondiente.
inversa_distribucion_pareto <- function(u, a, b) {
  return((b/(1-u)^(1/a))-b) 
}
```

Generaremos un número aleatoria uniforme entre $[0, 1]$ que representa la probabilidad acumulada de nuestra función de distribución, despues usaremos la función inversa para generar sus correspondientes variables aleatoria.


```r
#' Generador de variables aleatorias pareto
#'
#' @param n - numero de variables aleatorias
#' @param a - es el límite inferior de los datos
#' @param b - es el parámetro de forma
#'
#' @return vector de variables aleatorias.
generacion_va_pareto <- function(n, a, b) {
  va = c()
  for (i in 1:n) {
    u = runif(1)
    va[i] = inversa_distribucion_pareto(u, a, b )
  }
  return(va)
}

```

```r
# Histograma 1 para v.a pareto 
va_pareto = generacion_va_pareto(100, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 100', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.8, col = 'blue')
```



```r
# Histograma 2 para v.a pareto 
va_pareto = generacion_va_pareto(1000, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 1000', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.3, col = 'blue')
```


```r
# Histograma 3 para v.a pareto 
va_pareto = generacion_va_pareto(100000, 10, 3)
hist(va_pareto, probability = TRUE, main = 'Pareto n = 100000', xlab = '', col = 'pink')
par(new=TRUE)
plot(va_pareto, densidad_pareto(va_pareto, 10 ,3), pch = 20, cex = 0.3, col = 'blue')
```


Agregar un  breve comentario que explique en que situaciones se utilizan estas variables, y finalmente un comentario que explique por que la implementación de este algoritmo sería ineficiente para generar la variable aleatoria $Normal(\mu,\sigma^2)$. \
\newline \


Las situaciones en las cuales podremos utilizar este procedimiento será cuando nuestra función sea biyectiva, ya que si no es biyectiva no podria tener una función inversa. Este procedimiento es muy util para hacer simulaciones y ver el comportamiento. 

Creo que este algoritmo seria ineficiente para la distribución normal por como estaría conformada su función inversa, es decir, una vez conseguido la función de distribución, no es tan sencillo despejar x para conseguir su inversa, vemos que simplemente la integración de su función de distribución suele ser tan compleja que utilizamos tablas para conocer su probabilidad acumulada. Esa seria para mi la principal razón.

