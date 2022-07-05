---
title: "Práctica 8: Ley de los grandes números"
author: "Andres Urbano Guillermo Gerardo (Alumnolcd44)"
date: "14 de Octubre del 2021"
output: pdf_document
---

### Ley de los grandes números

Para conocer la convergencia de los promedios parciales de nuestras distribuciones, utilizaremos la Ley fuerte de los grandes números, la cual estará programada de esta forma:

```R
VarFuerte=function(n){
  parciales1=c()
  parciales2=c()
  promedio1=0
  promedio2=0
  for(i in 1:n){
    promedio1=(promedio1*(i-1)+rpareto(1,a,b))/i
    parciales1[i]=promedio1
    promedio2=(promedio2*(i-1)+rbern(1,0.5))/i
    parciales2[i]=promedio2
    
  }
  return(c(parciales1,parciales2))
}
```

Esta nos dice que generaremos $n$ variables aleatorias que serán las mismas para cada iteración, es decir, seguirá siendo el mismo espacio muestral, para mejorar la complejidad, generaremos una variable aleatoria y obtendremos el promedio para parcial y para siguiente iteración generaremos nuevamente solo una variable aleatoria y sumaremos la que teniamos anteriormente al multiplicarla con el `promedio` regresamos a su valor original y asi sucesivamente iremos iremos acumulando nuestras variables aleatorias y sacararemos sus promedios parciales para cada iteración.


Para la obtención de la gráfica simplemente usaremos la función plot y dibujaremos una linea que indicara el valor real de media de la distribución, generando el código correspondiente:

```R
n=100
plot(seq(1,n, by=1),tail(VarFuerte(n),n), type="l", main="Versión fuerte convergencia Bernoulli(0.5) n=100",xlab="Número de variables aleatorias",ylab="Promedio")
abline(0.5,0,col="red")
text(n-n/10, 0.5+0.1, "Valor Esperado", family = "serif", col="red", cex=1)
```


Podemos observar las fluctuaciones para $N=100$ más marcadas al principio de nuestro gráfica, pero conforme se van aumentando el número de variables correspondientes, el valor de la media muestral se va estableciendo, hasta pasar por encima del valor esperado. Ahora para $N=1000$ esa fluctuación que iba subiendo en $100$ va intercalándose bajando y subiendo. hasta que vemos que se mantiene por arriba del valor esperado.



Para la distribución de pareto, vemos que la convergencia al inicio es muy alejada haciendo fluctuaciones más grandes, pero conforme vamos aumento el numero de variables aleatorias igual va convergiendo como la binomial, es posible que la pareto tarde más en converger debido a como estruida su distribucion, ya que dependiendo de sus parámetros tiene una silueta muy característica, viéndose como logaritmo o una hiperbola rotada cuarenta y cinco grados a la izquierda. Y al igual que la Bernoulli también converge por encima del valor esperado.

Vemos que al graficar el error absoluto del valor esperado de nuestras variables aleatorias va disminuyendose conforme tenemos más variables, al inicia el error absoluto es enorme las fluctuaciones van restableciendose poco a poco.


Ahora podemos observar que sucede todo lo contrario para nuestra distribución de Pareto, los errores tienen una fluctuación acercándose a un error mínimo como también un error mayor y asi sucesivamente. Vemos que suele estar por debajo de nuestro error menor de $0.003$, pero también va incrementadose y volviendo a regresar a nuestro margen de error.


Podemos concluir que gracias a la ley de los grandes números no será necesario conocer la media la función de densidad, dado que avece será difícil conocerla, pero generando varias variables aleatorias y sacando sus promedios parciales podremos llegar a una aproximación del valor esperado, acercándonos más a su valor real.

