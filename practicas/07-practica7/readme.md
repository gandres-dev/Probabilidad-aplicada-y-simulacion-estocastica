---
title: 'Práctica 7: Convergencia de Binomiales'
author: "Andrés Urbano Guillermo Gerardo (alumnolcd44)"
date: "30 de Septiembre del 2021"
output:
  pdf_document: default
  html_document: default
---

# Aproximacion Binomial-Poisson
Generaremos variables aleatorias con numeros de enseyos variables para ir graficando cada uno
de ella con la distribución de binomial, al mismo tiempo, definiremos un $\lambda$ con valores de $5$ y $10$. Una vez definido nuestro lambda, podemos conocer la propabilidad de exito para nuestro variables binomiales:




\begin{align*}
\lambda &= n p\\
p &= \frac{\lambda}{n}
\end{align*}


```r
#' Compara las funciones de probabilidad binomial y poisson
#'
#' @param x # Variables aleatorias
#' @param n # Numero de ensayos
#' @param lambda  # Promedio de ocurrencias
#'
#' @return None 
comparar_funciones <- function(x, n, lambda) {
  
  # lambda = np (promedio de ocurrencias)
  # p = lambda / n
  p = lambda / n # Probabilidad de éxito
  
  # Variable aleatorias binomiales
  # Modela: Numero de éxitos en n ensayos.
  y <- dbinom(x, n, p)
  plot(x, y, type = 's', col = 'red')
  
  par(new = 'True')
  
  # Variables aleatorias poisson
  # Modela: Numero de ocurrencias de eventos muy pocos problables, pero
  # tienen muchos individuos que pueden activarlo
  y <- dpois(x, lambda)
  plot(x, y, type = 's', col = 'blue')  
  
  legend("topright", legend = c("binomial", "poisson"),
         lwd = 3, col = c("red", "blue"))
}
```

En nuestro codigo usaremos las funciones incorporadas para la funcion de masa `dbinom` y `dpois`, solo necesitaresmo para un vector `x` que representen un conjunto de valores de variables aleatorias, una `n` para el número de ensayos y por último un $\lambda$ para la distribución de Poisson. Con esto parametros podremos conocer la probabilidad éxito para la distribución binomial.

```r
# Para lambda = 5
lambda = 5
n = 10
x = 1:n  
comparar_funciones(x, n, lambda)

n = 30
x = 1:n  
comparar_funciones(x, n, lambda)

n = 100
x = 1:n  
comparar_funciones(x, n, lambda)

#------------------------------------------------------ 
# Para lamda = 10
lambda = 10
n = 20
x = 1:n  
comparar_funciones(x, n, lambda)

n = 40
x = 1:n  
comparar_funciones(x, n, lambda)

n = 100
x = 1:n  
comparar_funciones(x, n, lambda)

#------------------------------------------------------
```


Observamos que con un $n=10$ las dos distribuciones tiene un desfase, pero conforme vamos aumentando la $n$ ese desfase va disminuyendo de tal modo que cuando tenemos $n=100$ parece ser casi la misma grafica.

### Calculando el error

```r
# Encontrando el error
lambda = 5
n = 50
X = 1:n
p = lambda / n # Probabilidad de éxito
errors = abs(dbinom(X, n, p) - dpois(X, lambda)) 
plot(X, errors, col='red', pch=20, main="Errores lambda=5, n=50")
# Error maximo
print(max(errors))
```


Vemos que al principio el margen de error varia, pero conforme se aumenta el valor de la variable aleatoria converge a un valor con un error significativo. Al analizar las gráficas el error máximo que podemos encontrarnos sera de $0.009457231$ y despues converga a un error minimo, podemos también ver al tener una $n=20$ el error sera mínimo, siendo cada vez mejor. Al igual con $\lambda=5$ tambien sucedera con $\lambda=10$ el valor del error convergerá aproximadamente con una $n=30$.


Ahora aproximaremos con la funcion normal, tomando tres $p$ distintintas:
```r
comparar_binom_normal <- function(x, n, p, titulo) {
  Xn = dbinom(x, n, p)
  plot(x, Xn, type = 's', col = 'red', main=titulo)
  par(new = 'True')
  
  X = dnorm(x, n*p, sqrt(n*p*(1-p)))
  
  plot(x, X, type = 'l', col = 'blue')  
}
n = 60
p = 0.1
x = 1:n
comparar_binom_normal(x, n, p, "Con n=60 y p=0.1")
legend("topright", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  
```


Observamos que con tres probabilidades distintas la graficas van cambiando acercándose al eje $y$ y alejandose de el, vemos que cuando la probabilidad de exito es de $0.1$ la forma de la gráfica esta más cerca del eje $y$ y la comparación de la distribucion normal esta adentro de la grafica de la distribución binomial, cuando vamos aumentando la probabilidad la gráfica se va desplazando hacia la derecha. 

```r
n = 280
p = 0.5
x = 1:n
comparar_binom_normal(x, n, p, "Con n=280 y p=0.85")
legend("topright", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  
```


Haciendo varias prueba pudimos encontrar que con una $n=280$ y $p=0.85$ la distribución de la normal y binomial obtuvieron una muy buena aproximación. Concluyendo que es verdad que la binomial converge a la normal cuando $n$ se hace muy grande.


