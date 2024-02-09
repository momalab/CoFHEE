import sympy
import random
import math


def bitReverse(num, len):
        """
        integer bit reverse
        input: num, bit length
        output: rev_num
        example: input 6(110) output 3(011)
        complexity: O(len)
        """
        rev_num = 0
        for i in range(0, len):
            if (num >> i) & 1:
                rev_num |= 1 << (len - 1 - i)
        return rev_num

def orderReverse(poly, N_bit):
      """docstring for order"""
      for i, coeff in enumerate(poly):
          rev_i = bitReverse(i, N_bit)
          if rev_i > i:
              coeff ^= poly[rev_i]
              poly[rev_i] ^= coeff
              coeff ^= poly[rev_i]
              poly[i] = coeff
      return poly


def ntt(poly, M, N, w):
      """number theoretic transform algorithm"""
      N_bit = N.bit_length() - 1
      print ("poly:", poly)
      rev_poly = orderReverse(poly, N_bit)
      print ("rev_poly:", poly)
      for i in range(0, N_bit):
          points1, points2 = [], []
          for j in range(0, int(N / 2)):
              shift_bits = N_bit - 1 - i
              P = (j >> shift_bits) << shift_bits
              w_P = w ** P % M
              even = poly[2 * j]
              odd = poly[2 * j + 1] * w_P
              print("Stage :", i, "npoint :", j, "even :", poly[2 * j], "odd :", poly[2 * j + 1], "twidde :", w_P, "Result :", (even + odd) % M,  (even - odd) % M )
              points1.append((even + odd) % M)
              points2.append((even - odd) % M)
              # TODO: use barrett modular reduction
              points = points1 + points2
          if i != N_bit:
              poly = points
      return points



def gcd(a,b):
    while b != 0:
        a, b = b, a % b
    return a

#def primRoots(modulo):
#    roots = []
#    required_set = set(num for num in range (1, modulo) if gcd(num, modulo) == 1)
#
#    for g in range(1, modulo):
#        actual_set = set(pow(g, powers) % modulo for powers in range (1, modulo))
#        if required_set == actual_set:
#            roots.append(g)
#    return roots

def primRoots(modulo, cmul, nroots):
  roots = []
  hit   = 0
  for g in range(1, modulo) :
    if (hit == nroots) :
      break
    else :
      for powers in range (1, modulo) :
        pow_mod = pow(g, powers) % modulo
        if (pow_mod == 1) :
          if (powers == modulo-1) :
            if (pow(g, cmul) < modulo) :
              roots.append(pow(g, cmul))
              hit = hit + 1
          else :
            break
  return roots




#--------------------Global variables---------------------------
DWIDTH  = 128
#POLYDEG = 8192
POLYDEG = 128
#Find a prime number P = const_mul * (2**log2POLYDEG) + 1
log2polydeg = int(math.log(POLYDEG, 2))

#barretk   = 256; #for 4096

modulus   = 2**DWIDTH - 1
#md_param  = math.floor((2**barretk)/modulus)

barretk   = math.ceil(math.log(modulus, 2))
md_param  = math.floor((2**(2*barretk))/modulus)

print("Barret k :",  barretk)
print("Barret md :", md_param)

print("-----Modulus, Nth Root of Unity and Selected Nth root of unity-----------")
print("Modulus :", modulus)
nth_rou = 2**DWIDTH - 3
print("Selected Nth Root of Unity", nth_rou)
print("--------------------------------------------------------------------------")
#--------------------------------------------------------------

#--------------------Root of Unity---------------------------
#Find a prime number P = c * (2**k) + 1
lst = list(range(8192))
seq = random.sample(lst, POLYDEG)
for i in range(POLYDEG):
  seq[i]  = random.getrandbits(DWIDTH) - 1
#--------------------------------------------------------------


file_ntt = open("./testcases/ntt_regress_cf_dp.v", "w")
file_ntt.write ("uartm_write_128     (.addr(GPCFG_N_ADDR[0]),        .data(" + str(DWIDTH)   + "'d"  + str(modulus)  + ")); \n")
file_ntt.write ("uartm_write_256     (.addr(GPCFG_NSQ_ADDR[0]),      .data(" + str(2*DWIDTH) + "'d"  + str(md_param) + ")); \n")
file_ntt.write ("uartm_write         (.addr(GPCFG_NSQ_ADDR[5]),      .data(" + str(32*1)     + "'d"  + str(barretk)  + ")); \n")

for i in range(POLYDEG):
  file_ntt.write ("coef[" + str(i) + "] = " + str(DWIDTH) + "'d" + str(seq[i]) + ";\n")

for i in range(POLYDEG):
  file_ntt.write ("twdl[" + str(i) + "] = " + str(DWIDTH) + "'d" + str((nth_rou**i)%modulus) + ";\n")

file_ntt.write ("for (i = 0; i < POLYDEG; i++) begin\n")
file_ntt.write ("  uartm_write_128     (.addr(FHEMEM0_BASE + 16*i),  .data(coef[i]));\n")
file_ntt.write ("end\n")

file_ntt.write ("for (i = 0; i < POLYDEG; i++) begin\n")
file_ntt.write ("  uartm_write_128     (.addr(FHEMEM3_BASE + 16*i),  .data(twdl[i]));\n")
file_ntt.write ("end\n")

# ntt
expctd_res = ntt(seq, modulus, POLYDEG, nth_rou)
#print ("NTT : ", transform)
for i in range(POLYDEG):
  j = bitReverse(i, log2polydeg)
  file_ntt.write ("fhe_exp_res[" + str(i) + "] = " + str(DWIDTH) + "'d" + str(expctd_res[j]) + ";\n")


file_ntt.write ("uartm_write    (.addr(GPCFG_FHECTL2),       .data({FHEMEM1_BASE[31:24], FHEMEM3_BASE[31:24], FHEMEM0_BASE[31:24], FHEMEM0_BASE[31:24]}));\n")
file_ntt.write ("uartm_write    (.addr(GPCFG_FHECTL_ADDR),   .data({8'h00, 8'h00, POLYDEG[15:0]}));\n")
file_ntt.write ("uartm_write    (.addr(GPCFG_FHECTL_ADDR),   .data({8'h00, 8'h40, POLYDEG[15:0]}));\n")
file_ntt.write ("uartm_write    (.addr(GPCFG_FHECTLP_ADDR),  .data(32'b1));\n")
file_ntt.write ("uartm_write    (.addr(GPCFG_COMMNDFIFO_ADDR),  .data({8'h81, FHEMEM1_BASE[31:24], FHEMEM0_DP_BASE[31:24], FHEMEM0_BASE[31:24]}));\n")
file_ntt.write ("$display(\" << INFO: Triggered NTT \");\n");
file_ntt.close()


print("-----Checking the correctness of nth root of unity-----------")
ntt_output   = ntt(seq, modulus, POLYDEG, nth_rou)

try :
  if (ntt_output == expctd_res) :
     #print("NTT CHECK PASSED : ", ntt_output)
     print("CHECK PASSED : ")
except :
  print("CHECK FAILED : ", ntt_output)
print("--------------------------------------------------------------------------")
#sympy.rootof(x**POLYDEG - 1, i) for i in range(POLYDEG)
#itransform = sympy.intt(transform, modulus)
#print ("INTT : ", itransform)
