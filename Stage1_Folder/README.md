# Assignment 2: Logistic Growth Simulation in R

## Overview
This assignment provides an R script that simulates logistic population growth curves. Each curve is generated using a logistic model that incorporates randomized parameters to control both the lag phase and the exponential (log) phase. This approach is useful for modeling diverse population dynamics, such as cell density, optical density (OD), or CFU over time.

The logistic model used is:

\[
y(t) = \frac{K}{1 + \exp\left(-r \, (t - t_{\text{shift}})\right)}
\]

where:
- **\(K\)** is the carrying capacity,
- **\(r\)** is the growth rate (modified by a rate multiplier),
- **\(t_{\text{shift}}\)** adjusts the lag phase.

## Features
- **Modular Functions:**  
  - `logistic_growth()`: Computes the logistic function.
  - `simulate_growth_curve()`: Generates a single logistic growth curve using randomized parameters.
  - `generate_growth_curves()`: Creates 100 growth curves and combines them into one data frame.

- **Randomized Parameters:**  
  Each curve gets unique, randomly selected values for:
  - Carrying capacity (\(K\))
  - Base growth rate (\(r\))
  - Lag shift (\(t_{\text{shift}}\))
  - Rate multiplier (affecting the exponential phase)

- **Easy-to-Read Code:**  
  The R code is structured for clarity, with comments and separated functions to simplify understanding and modification.

## Requirements
- **R** (version 3.6 or higher recommended)
- (Optional) **ggplot2** package for enhanced plotting:
  ```R
  install.packages("ggplot2")
