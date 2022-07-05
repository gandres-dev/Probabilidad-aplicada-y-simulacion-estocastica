# -*- coding: utf-8 -*-
import numpy as np 
import matplotlib.pyplot as plt

def Ehrenfest (A1, A2, n):
  """
  A1 - bolas del lado izquierdo
  A2 - bolas del lado derecho
  n - numero de simulaciones
  """
  N= A1+A2
  j=A1
  estado= [j]
  for i in range(n):
    p=np.random.binomial(1, j/N)    
    if p:
      j -= 1
    else:
      j += 1
    estado.append(j)
  plt.figure(figsize=(15,6))
  plt.plot(estado, marker='o',c='b')

Ehrenfest(50,40,100)

def Ehr_paro(A1, A2, t0):
  """
  A1 - bolas del lado izquierdo de la urna
  A2 - bolas del lado derecho de la urna
  t0 - numero de bolas a parar
  """
  N= A1+A2
  j=A1
  estados= [j]
  
  while j != t0:
    p=np.random.binomial(1, j/N)
    if p==1:
      j -= 1
    else:
      j += 1
    estados.append(j)      
  plt.figure(figsize=(15,6))
  plt.plot(estados,c='b')
  plt.show()

Ehr_paro(30,20,25)

def ETiempos(A1, A2, t0, K):
  N= A1+A2
  ts=[]
  for  i in range (K):
    k=A1
    cont=0
    while k != t0:
      p=np.random.binomial(1, k/N)
      if p==1:
        k -= 1
      else:
        k += 1
      cont+=1
  
  ts.append(cont)      
  t = sum(ts)/ len(ts)
  print(f'Para {K} simulaciones el tiempo promedio desde {A1} a {t0} fue de {t} milisegundos ')

ETiempos(0,10,5,100)
ETiempos(0,100,50,100)
ETiempos(0,500,250,100)
ETiempos(10,10,5,100)
#ETiempos(10,10,0,100)
#ETiempos(0,500,500,100)
