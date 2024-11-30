from helper_functions import transit_coeficient, find_row, falling_velocity_of_grain, \
    calculate_dimensionless_grain_size, read_data, error_function_MSE, error_function_jensenshannon
import numpy as np
from scipy.optimize import differential_evolution
from datetime import datetime
import copy
#####################################################
# read data

[t_v_rho, T_h_arr, d_help_input, flows] = read_data('data/Dobczyce/t_v_rho.csv', 'data/Dobczyce/T_h_arr.csv',
                                              'data/Dobczyce/d.csv', 'data/Dobczyce/flows.csv')

#####################################################
# parameters declaration
# sediment grain density (for quartz 2650), [kg/m^3]
rho_s = 2650
#  water temperature [°C]
T_wody = 21
# water denisty kg/m^3
rho = find_row(t_v_rho, 0, 2, T_wody)
# kinematic viscosity [m^2/s]
v = find_row(t_v_rho, 0, 1, T_wody)/1000000
#  average depth of the entry cross section [m]
h_in_help = [1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 2.6, 2.6, 3]
# avarage flow depth odirectly upstream of the dam (outflow) [m]
h_out_help = [28, 28, 28, 28, 28, 28, 30.6, 30.6, 31.5]
h_out = h_out_help[0]
# T_h_arr - czas wymiany wody zbiornika (CWW_help)

# reservoir input
h_in = h_in_help[0]

global distribution_sample_size
distribution_sample_size = 10000
# optimizer parameters
maxiter = 50
popsize = 50
tol = 0.0001
bounds = [(0.00001, 20), (0.00001, 50)]

#####################################################

def draw_distribution(s, mu, N):
    global distribution_sample_size
    my_distribution = np.zeros(len(v_set))
    for j in range(int(N)):
        my_T_h = np.random.lognormal(mean=np.log(mu), sigma=s)
        for i in range(len(v_set)):
            tc = transit_coeficient(v_set[i], h_in, h_out, my_T_h)
            if tc > 0.5:
                my_distribution[i] += 1
    my_distribution /= N
    return my_distribution

# objective function
def jensenshannon_fun(params, *data):
    y_pred = draw_distribution(params[0], np.exp(params[1]), distribution_sample_size)
    y_pred = np.array(y_pred)
    Y = data
    Y = np.array(Y)
    obj = error_function_jensenshannon(y_pred, Y)
    return obj




global iter_count
global optimization_file_name

################################################
# Prepare folders

now = datetime.now()
print("now =", now)

dt_string = now.strftime("%d-%m-%Y %H-%M-%S")
import os
if not os.path.exists('results/Dobczyce/' + dt_string):
    os.makedirs('results/Dobczyce/' + dt_string)



# save setup
setup_file_name = 'results/Dobczyce/' + dt_string + '/jensenshannon_setup.csv'
with open(setup_file_name, 'w') as fd:
    fd.write("distribution_sample_size=" + str(distribution_sample_size) +  "\n")
    fd.write("maxiter=" + str(maxiter) +  "\n")
    fd.write("popsize=" + str(popsize) +  "\n")
    fd.write("tol=" + str(tol) +  "\n")
    fd.write("bounds=" + str(bounds) +  "\n")

# file with results, add header
results_file_name = 'results/Dobczyce/' + dt_string + '/jensenshannon_results.csv'
with open(results_file_name, 'a') as fd:
    fd.write("flow_id,s,exp(mu),error\n")

# file with solutions
solution_file_name = 'results/Dobczyce/' + dt_string + '/jensenshannon_solution.csv'
with open(solution_file_name, 'a') as fd:
    fd.write("Y,y_pred\n")

for flow_id in range(len(flows)):
    Y = flows[flow_id]
    #  average depth of the entry cross section [m]
    h_in = h_in_help[flow_id]
    my_T_h_init = T_h_arr[flow_id]
    # avarage flow depth odirectly upstream of the dam (outflow) [m]
    h_out = h_out_help[flow_id]
    # remove None from flows data
    d_help = copy.deepcopy(d_help_input)
    Y, d_help = zip(*[(yy, dd) for (yy, dd) in zip(Y, d_help) if yy is not None])

    # dimensionless grain size for calculating the falling velocity (v')
    d_gr = [calculate_dimensionless_grain_size(x, rho_s, rho, v) for x in d_help]
    # falling velocity of grain (Macdonald et al., 2006) [m/s]
    v_set = [falling_velocity_of_grain(x1, x2, v) for (x1, x2) in zip(d_help, d_gr)]

    # file with optimization results
    optimization_file_name = 'results/Dobczyce/' + dt_string + '/jensenshannon_optimization_' + str(flow_id) + '.csv'

    #Y = flows[flow_id]
    #my_T_h_init = T_h_arr[flow_id]
    iter_count = 0
    def myCallback_jensenshannon(xk, convergence):
        global iter_count
        global distribution_sample_size
        iter_count = iter_count + 1
        y_pred = draw_distribution(xk[0], np.exp(xk[1]), distribution_sample_size)
        print("iter=" +str(iter_count) + "xk=[" + str(xk[0]) + "," + str(np.exp(xk[1])) + "] , error=" + str(error_function_jensenshannon(y_pred, Y)))
        with open(optimization_file_name, 'a') as fd:
            if iter_count == 1:
                fd.write("iter,s,exp(mu),error\n")
            fd.write(str(iter_count) + "," + str(xk[0]) + "," + str(np.exp(xk[1])) + "," + str(error_function_jensenshannon(y_pred, Y)) + "\n")

    # starting point of optimization
    x0 = [np.log(my_T_h_init), np.log(my_T_h_init)]
    # optimize jensenshannon
    result = differential_evolution(func=jensenshannon_fun, bounds=bounds, args=(Y), callback=myCallback_jensenshannon,
                                    maxiter=maxiter, popsize=popsize,tol=tol, x0=x0)

    # print results
    with open(results_file_name, 'a') as fd:
        print("s=" + str(result.x[0]) + ", epx(mu)=" + str(np.exp(result.x[1])))
        y_pred = draw_distribution(result.x[0], np.exp(result.x[1]), distribution_sample_size)
        print(y_pred)
        print(Y)
        print(error_function_jensenshannon(y_pred, Y))

        fd.write(str(flow_id) + ',' + str(result.x[0]) + ',' + str(np.exp(result.x[1])) + ',' + str(error_function_jensenshannon(y_pred, Y)) + '\n')

    with open(solution_file_name, 'a') as fd:
        fd.write(str(Y) + "," + str(y_pred) + '\n')