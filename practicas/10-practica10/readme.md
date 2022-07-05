---
title: 'Práctica 10: Multinomiales e Independencia'
author: "Andrés Urbano Guillermo Gerardo (Alumnolcd44)"
date: "19 de Octubre del 2021"
output:
  pdf_document: default
  html_document: default
---
# Multinomiales e Independencia

Comprobaremos el comportamiento de dos variables aleatorias con distribución normal, para eso definiremos primero $1000$ variables aleatorias normales y obtendremos su gráfica:
```R
n <- 1000
X <-rnorm(n, 0, 1)
Y <-rnorm(n, 0, 1)
plot(X, Y)
```

Vemos que se forma una nube de puntos en la gráfica, esto nos indica que las variables son independientes ya que no se forma una función en particular, es decir si hubiéramos visto una recta esto nos indicaría que las variables son dependientes. 
Ahora graficaremos otras variables aleatorias definidas con las anteriores:
```R
Z <- X-Y
W <- X+Y
plot(Z, W)
```


Vemos ahora que nuestra distribución de puntos se expandió a lo ancho y lo observamos a partir del eje Z que va de $-4$ a $4$ formándose una silueta de una elipse, podemos ver que nuestras variables siguen conservando la independencia dado que sigue siento una nube de puntos.


Simularemos ahora vectores multinomiales que consiste en generar experimentos donde salgan $k$ resultados diferentes y luego repetir este experimento $n$ veces, iremos contando cada uno de los resultados al hacer los $n$ experimentos. Para la implementación creamos una función que generará vectores multinomiales:
```R
#' Generar una variables aleatorias multinomiales de tres resultados posibles
#' por las probabilidades dada por p1,p2,p3
#'
#' @param n - numero de ensayos
#' @param p1 - probabilidad de éxito para x1
#' @param p2 - probabilidad de éxito para x2
#' @param p3 - probabilidad de éxito para x3
#'
#' @return un vector multinomial
multinomial <- function(n, p1, p2, p3) {
  Xn = c(0, 0, 0);
  for (i in 1:n) {
    u = runif(1);
    if (u <= p1) {
      Xn[1] <- Xn[1]+1;
    } else if (u <= p1+p2) {
      Xn[2] <- Xn[2]+1;
    } else {
      Xn[3] <- Xn[3]+1;
    }
  }
  return(Xn)
}
X = multinomial(10, 0.3, 0.4, 0.1)
print(X)
```

En cada uno de estos $n$ experimento debemos de ir guardando cuantas veces sale
uno de los $x1, x2$ y $x3$ posibles, considerando su probabilidad $p1,p2$ y $p3$.
Para la simular variables discretas utilizamos el método de los intervalos que utiliza la idea de la distribución acumulativa, sabemos que la suma de todas las probabilidades deben de ser $1$, entonces definimos una recta de longitud $1$ y la segmentamos según las probabilidades dadas, en este caso p1 sera el primer intervalo, el segundo será la suma de $p1+p2$ y el tercero sera el restante. Generaremos un número pseudoaleatorio entre $0$ y $1$ y veremos en que parte de la recta caí y dado su ubicaciones iremos aumentacion el valor de Xn en $1$ para cada iteración, es decir, veremos cuantas veces salio cada uno de los resultados y la suma de todos $Xn$ nos tiene que dar $n$.

Graficaremos ahora para diferentes $n$:
```R
x = c()
y = c()
z = c()

for (i in 1:150) {
  Xn = multinomial(i,0.3, 0.4, 0.1)
  x[i] = Xn[1]
  y[i] = Xn[2]
  z[i] = Xn[3]
}
scatterplot3d(x, y, z, pch=16, color='salmon')
```



Dado que tendremos tres valores, graficaremos en 3D donde cada punto representa un vector mutinomial generado por nuestra función, vemos que tiene una forma de plano inclinado con pendiente positiva. Ahora usaremos una proyección usando solamente $2$ variables aleatorias X1 y X2:

```R
x = c()
y = c()
z = c()

for (i in 1:1000) {
  Xn = multinomial(i,0.3, 0.4, 0.1)
  x[i] = Xn[1]
  y[i] = Xn[2]
  z[i] = Xn[3]
}
plot(x, y)
```


Observamos que con $n=1000$ se aprecia la agrupación de puntos con una tendencia lineal, es decir, si hacemos una regresión lineal, tendremos una recta con pendiente positiva. Podemos concluir que las variables son independientes ya que vemos una recta que significaría que las variables dependen de un valor, y es verdad ya que sabemos que la suma de $X_1 + X_2, \ldots, + X_n = n$, donde se ve la dependencia con $n$. 


