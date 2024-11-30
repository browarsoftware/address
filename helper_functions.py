from numba import jit
import numpy as np
from scipy.spatial.distance import jensenshannon
import csv
#####################################################
## Helper functions


# find value in list of lists
def find_row(my_list, c_in, c_out, my_val):
  id = 0
  while id < len(my_list):
   if my_list[id][c_in] == my_val:
    return my_list[id][c_out]
   id += 1
  return -1

def try_float(v):
 try:
  return float(v)
 except Exception:
  return None

def read_data(t_v_rho_file, T_h_arr_file, d_file, flows_file):
 with open(t_v_rho_file, newline='') as f:
  reader = csv.reader(f)
  t_v_rho = list(reader)
  for a in range(len(t_v_rho)):
   t_v_rho[a] = [try_float(x) for x in t_v_rho[a]]

 with open(T_h_arr_file, newline='') as f:
  reader = csv.reader(f)
  my_T_h_arr = list(reader)
  my_T_h_arr = [try_float(x) for x in my_T_h_arr[0]]

 with open(d_file, newline='') as f:
  reader = csv.reader(f)
  d_help = list(reader)
  d_help = [try_float(x) for x in d_help[0]]

 with open(flows_file, newline='') as f:
  reader = csv.reader(f)
  flows = list(reader)
  for a in range(len(flows)):
   flows[a] = [try_float(x) for x in flows[a]]

 return [t_v_rho, my_T_h_arr, d_help, flows]


#####################################################
## Model
# dimensionless grain size for calculating the falling velocity (v')
@jit
def calculate_dimensionless_grain_size(my_d, my_rho_s, my_rho, my_v):
 dgs = (my_d/1000)*pow((((my_rho_s/my_rho-1)*9.81)/pow(my_v,2)),1./3.)
 return dgs

# falling velocity of grain (Macdonald et al., 2006)
@jit
def falling_velocity_of_grain(my_d, my_d_gr, my_v):
 if my_d_gr >= 0.0672:
  return (pow((107.33+1.049*pow(my_d_gr,3)),1./2.)-10.36)*my_v/(my_d/1000)
 else:
  return 0.0077*pow(my_d_gr,2)*my_v/(my_d/1000)

# transit coeficient
# (1-2^(-($K$18-$K$17/2)/($P17*(K$19*3600))))
@jit
def transit_coeficient(my_v_set, my_h_in, my_h_out, my_T_h):
 return (1 - pow(2, -(my_h_out - my_h_in / 2) / (my_v_set * my_T_h * 3600)))

def error_function_MSE(y_pred, Y):
  return np.sqrt(((y_pred - Y) ** 2).sum())


def error_function_jensenshannon(y_pred, Y):
  return jensenshannon(1.0 - np.array(Y), 1.0 - np.array(y_pred))