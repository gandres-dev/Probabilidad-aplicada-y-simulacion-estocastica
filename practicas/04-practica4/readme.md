---
title: 'Práctica 4: Simulación de una variable aleatoria'
author: "Andrés Urbano Guillermo Gerardo (alumnolcd44)"
date: "9 de Septiembre del 2021"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
# Distribución geométrica

Antes de hablar de la distribución geométrica que es el tema principal de nuestra practica hablaremos sobre los ensayos de Bernoulli que es el fundamento teórico sobre las distribuciones discretas que veremos a continuacion.

## Ensayo de Bernoulli
Un ensayo de bernoulli es un experimento aleatorio en el que sólo se pueden obtener dos resultados éxito o fracaso. Los valores de la variable aleatoria que puede tomar estos ensayos son 0 y 1.

$p=éxito$\
$q=fracaso$

## Procesos de Bernoulli
Consiste en una repetición de varios ensayos de Bernoulli.

* Los ensayos son independientes.
* La probabilidad de éxito P permanece constante para cada ensayo.

Una vez conociendo estos conceptos, podemos decir que la distribución geométrica consiste en un proceso de Bernoulli. Para simular su variable aleatoria primero empezamos definiendo un ensayo de bernoulli:

```R
#' Representa un ensayo de bernoulli.
#'
#' @param p la probabilidad de éxito.
#'
#' @return un entero que representa éxito o fracaso.
bernoulli <- function(p){
  x = runif(1)
  if(x<p){
    return(1)
  }
  else{
    return(0)
  }
}
```

Con ayuda de la probabilidad ingresada como argumento en la función , definiremos el valor de éxito o fracaso dependiente si el valor de `x` es menor o mayor a la probabilidad. La variable `x` sera un número aleatorio que tiene una distribución uniforme ya establecido, para no alterar el experimento y siga siendo un experimento aleatorio.

Para nuestra simulación utilizaremos la función anterior:
```R
#' Simulación para la distribución geométrica
#' 
#' El número de fracasos antes del primer éxito.
#' 
#' @param p un decimal que representa la probabilidad de éxito.
#'
#' @return un entero que es el valor de la variable aleatoria.
geometrica <- function(p){
  fracaso = 0
  while(bernoulli(p)==0){
    fracaso = fracaso + 1
  }
  return(fracaso)
}
```

Nuestra función regresara el número de fracasos hasta que encuentre el primer éxito.

```R
cat('Numeros de fracasos antes del primer exito:',geometrica(0.3))
```

Realizaremos ahora una segunda forma de simular nuestra variable aleatoria utilizando el método de intervalos, para eso primero debemos conocer su distribución que es:

\begin{equation*}
    P(X=k)=(1-p)^k (p)
\end{equation*}
Siendo $k$ el número de fracasos.

```R
#' Simulación para la distribución geométrica, método de intervalos.
#'
#' @param p un decimal que representa la probabilidad de éxito.
#'
#' @return un entero que es el valor de la variable aleatoria.
geometrica2 <- function(p){
  x = runif(1)
  intervalo = 0
  extremo = p
  k=0
  while(x>extremo){
    intervalo = intervalo + 1
    k = k + 1
    extremo = extremo + ((1-p)^k)*p
  }
  return(intervalo)
}
```

Para este método pensaremos en una recta numérica del 0 al 1, que representa probabilidades de un evento. Partiremos nuevamente con un número aleatorio que compararemos con la probabilidad de éxito, si la probabilidad de éxito es mayor entonces terminará nuestro ciclo `while` y devolverá el número de fracasos que hubo, en caso contrario, si es mayor a la probabilidad de éxito, significa que hubo un fracaso entonces aumentamos nuestro variable `intervalo` e incrementamos nuestra probabilidad considerando un $k=1$ ya que hubo un fracaso, y con esa probabilidad la sumamos con la anterior ya que observamos que la probabilidad disminuye conforme hay muchos fracasos, es decir, que conforme vamos sumando esa probabilidad con la anterior, hacemos que cada vez tenga mayor éxito que la primera vez. Tiene sentido esto por la forma que esta dada la función de distribución, ya que la probabilidad de fracaso esta elevado por el número de fracaso haciendo que se haga más pequeño ese valor.
```R
cat('Numeros de fracasos antes del primer exito:',geometrica2(0.3))
```

---

**Nota.** El código que se enviará a la plataforma sera el encriptado para la actividad de moodle, en este documento tenemos los nombres originales para mejor entendimiento del reporte.




