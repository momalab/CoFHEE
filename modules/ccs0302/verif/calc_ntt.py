import math
import random

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
      rev_poly = orderReverse(poly, N_bit)
      for i in range(0, N_bit):
          points1, points2 = [], []
          for j in range(0, int(N / 2)):
              shift_bits = N_bit - 1 - i
              P = (j >> shift_bits) << shift_bits
              w_P = w ** P % M
              odd = poly[2 * j + 1] * w_P
              even = poly[2 * j]
              points1.append((even + odd) % M)
              points2.append((even - odd) % M)
              # TODO: use barrett modular reduction
              points = points1 + points2
          if i != N_bit:
              poly = points
      return points

def primRoots(modulo, cmul):
  roots = []
  for g in range(1, modulo) :
    for powers in range (1, modulo) :
      pow_mod = pow(g, powers) % modulo
      if (pow_mod == 1) :
        if (powers == modulo-1) :
          if (pow(g, cmul) < modulo) :
            roots.append(pow(g, cmul))
        else :
          break
  return roots



#--------------------Global variables---------------------------
POLYDEG   = 2
poly_size = 2
modulus   = 257
nth_rou   = 1
print("--------------------------------------------------------------------------")
#--------------------------------------------------------------

#poly_coef    = [205, 98]
poly_coef    = [117, 187]
ntt_output   = ntt(poly_coef, modulus, poly_size, nth_rou)
print(ntt_output)
