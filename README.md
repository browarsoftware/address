### Source codes for paper:

# The aim of the grain: modeling the probability of suspended sediment particles deposition in dammed reservoirs according to their diameter and overall hydrologic conditions

## Abstract

Sediment dynamics plays a crucial role in the ecological and hydrological operation of dammed reservoirs and the rivers that flow downstream of these barriers. Dam reservoirs disrupt the natural transport of sediment by acting as a trap for grains of some diameters. Lately, it has been shown that by using geometric modeling (without knowing detailed bed morphology), it is possible to predict whether a sediment grain of a given diameter would be deposited or transferred through the reservoir. In this paper, we propose an indicator variable that may be interpreted directly as the probability of transfer for a sediment grain of distinct properties (diameter, density) in specific hydrologic conditions (discharge, water level) within a reservoir of a given characteristic parameters (depth at tributary mouth, maximum depth, volume). To our knowledge, the method proposed in this paper is the first approach for directly assessing the probability of suspended sediment particle deposition in dammed reservoirs, and it uses only data that are easy to obtain for any reservoir. As such, it can be easily deployed in sustainable water management practices. We have successfully evaluated our approach on two water reservoirs with different bathymetry and morphology, utilizing observational sediment data and obtaining promising results. We believe that the methodology described in this paper is an important step toward cost reduction in large water dammed reservoir management. Both our research's source code and data are available to download so our results can be reproduced, and the method can be easily applied to other reservoirs. 

## Keywords

environmental modeling, dammed reservoir, suspended sediment, grain travel time, water exchange time, stochastic estimation, differential evolution.

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
