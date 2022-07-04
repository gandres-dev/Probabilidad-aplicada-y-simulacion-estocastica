#' Compara las funciones de probabilidad binomial y poisson
#'
#' @param x # Variables aleatorias
#' @param n # Numero de ensayos
#' @param lambda  # Promedio de ocurrencias
#' @param title  # Titulo para el histograma
#'
#' @return None 
comparar_funciones <- function(x, n, lambda, titulo) {
  
  # lambda = np (promedio de ocurrencias)
  # p = lambda / n
  p = lambda / n # Probabilidad de éxito
  
  # Variable aleatorias binomiales
  # Modela: Numero de éxitos en n ensayos.
  y <- dbinom(x, n, p)
  plot(x, y, type = 's', col = 'red', main=titulo)
  
  par(new = 'True')
  
  # Variables aleatorias poisson
  # Modela: Numero de ocurrencias de eventos muy pocos problables, pero
  # tienen muchos individuos que pueden activarlo
  y <- dpois(x, lambda)
  plot(x, y, type = 's', col = 'blue')  
  
  legend("topright", legend = c("binomial", "poisson"),
         lwd = 3, col = c("red", "blue"))
}

#------------------------------------------------------ 
# Para lambda = 5
lambda = 5
n = 10
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 10")

n = 30
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 30")

n = 100
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 100")

#------------------------------------------------------ 
# Para lamda = 10
lambda = 10
n = 20
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 20")

n = 40
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 40")

n = 100
x = 1:n  
comparar_funciones(x, n, lambda, "Con n = 100")

#------------------------------------------------------
# Calculando el error
lambda = 5
n = 50
X = 1:n
p = lambda / n # Probabilidad de éxito
errors = abs(dbinom(X, n, p) - dpois(X, lambda)) 
plot(X, errors, col='red', pch=20, main="Errores lambda=5, n=50")
# Error maximo
print(max(errors))

# lamda = 5 Si sabemo que con n = 18 el error converge a un numero muy pequeño
# podemos decir que esa n adecuada 

# Calculando el error
lambda = 10
n = 50
X = 1:n
p = lambda / n # Probabilidad de éxito
errors = abs(dbinom(X, n, p) - dpois(X, lambda)) 
plot(X, errors, col='red', pch=20, main="Errores lambda=10, n=50")
# Error maximo
print(max(errors))


#------------------------------------------------------
# Probar para  p = 0.1, 0.6 y 0.85
# a)

comparar_binom_normal <- function(x, n, p, titulo) {
  Xn = dbinom(x, n, p)
  plot(x, Xn, type = 's', col = 'red', main=titulo)
  par(new = 'True')
  
  X = dnorm(x, n*p, sqrt(n*p*(1-p)))
  
  plot(x, X, type = 'l', col = 'blue')  
  # legend("topleft", legend = c("binomial", "normal"),
  #       lwd = 3, col = c("red", "blue"))  
}

n = 60
p = 0.1
x = 1:n
comparar_binom_normal(x, n, p, "Con n=60 y p=0.1")
legend("topright", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  

# Es donde hay mas similitud
n = 60
p = 0.6
x = 1:n
comparar_binom_normal(x, n, p, "Con n=60 y p=0.6")
legend("topleft", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  

n = 60
p = 0.85
x = 1:n
comparar_binom_normal(x, n, p, "Con n=60 y p=0.85")
legend("topleft", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  

#------------------------------------------------------
# b)  0.1, 0.6 y 0.85
comparar_con_escalado <- function(x,n,p,titulo) {
  
  Yn = (dbinom(x, n, p) - n * p ) / sqrt(n*p*(1-p))
  plot(x, Yn, type = 's', col = 'red', main=titulo)
  par(new = 'True')
  
  Y = dnorm(x, 0,1)
  plot(x, Y, type = 's', col = 'blue')  
  
}

n = 60
p = 0.1
x = -n:n
Xn = dbinom(x, n, p)
comparar_con_escalado(x,n,p,"Con n=60 y p=0.1 con rescalado")

n = 100
p = 0.6
x = 1:n
comparar_con_escalado(x,n,p,"Con n=60 y p=0.6 con rescalado")

n = 60
p = 0.85
x = 1:n
comparar_con_escalado(x,n,p,"Con n=60 y p=0.85 con rescalado")


# p chiquita - no necesita n muy grande
# p grande - necesita una n mas grande
#------------------------------------------------------
# ¿Para qué valores de n la dirı́as que ya tienes una buena aproximación?
n = 280
p = 0.5
x = 1:n
comparar_binom_normal(x, n, p, "Con n=280 y p=0.85")
legend("topright", legend = c("binomial", "normal"),
       lwd = 3, col = c("red", "blue"))  


#------------------------------------------------------
# Propón un criterio numérico alternativo al máx para medir la velocidad de la convergencia
