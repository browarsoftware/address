### Source codes for paper:

# The aim of the grain: modeling the probability of suspended sediment particles deposition in dammed reservoirs according to their diameter and overall hydrologic conditions

ABSTRACT XXXX 

Keywords: XXXX

## Requirements

- Python 3.8
- scipy 1.8
- numpy 1.23
- numba 0.56 
- R version 3.6.2

## How to run

Execute following scripts to calculate lognormal distribution of grain travel time t [h] for  Włocławek Reservoir and Dobczyce Reservoir. 
Optimization is done using differential evolution and two objective functions: mean squared error and Jensen-Shannon distance. 

- [run_MSE_Wloclawek.py](run_MSE_Wloclawek.py)
- [run_jensenshannon_Wloclawek.py](run_jensenshannon_Wloclawek.py)
- [run_MSE_Wloclawek.py](run_MSE_Dobczyce.py)
- [run_jensenshannon_Dobczyce.py](run_jensenshannon_Dobczyce.py)

Visualize results using following script:

- [make_plots.R](make_plots.R)

<!-- ## Full text -->



<!-- ## Cite as -->
