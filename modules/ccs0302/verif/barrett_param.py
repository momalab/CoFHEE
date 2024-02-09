import sympy
import random
import math

NITER   = 2
DWIDTH  = 512
modulus = 2**DWIDTH - 1
print ("modulus :", modulus)
#modulus = 1152921504606830593
#modulus = 340282366920938463463374607431768211455
#modulus = 340282366920938463463374607431768211455

barretk   = math.ceil(2*math.log(modulus, 2));
md_param  = math.floor((2**barretk)//modulus)


for i in range(NITER):
   #error = float((2**barretk/md_param)) - modulus
   error = '{0:.20f}'.format((2**barretk/md_param))
   print ("------------------------ Iteration :", i , "------------------------")
   print ("barretk :", barretk)
   print ("barretmd :", md_param)
   print ("Log2 of barretmd :", math.log(md_param, 2))
   print ("Error :",   error)
   barretk = barretk + 1
   md_param = math.floor((2**barretk)/modulus)


print ("------------------------------------------------")
print ("Above Calculation done for Modulus:",   modulus)
print ("Log2 for Modulus:",   math.log(modulus, 2))
print ("------------------------------------------------")
