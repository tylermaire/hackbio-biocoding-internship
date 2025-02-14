# Logistic Growth Simulation in R

# Logistic growth function
logistic_growth <- function(t, K, r, t_shift) {
  # Standard logistic function:
  #    y(t) = K / (1 + exp(-r * (t - t_shift)))
  K / (1 + exp(-r * (t - t_shift)))
}

# Simulate a single logistic growth curve
simulate_growth_curve <- function(time,
                                  K = 1.0,
                                  base_rate = 1.0,
                                  lag_shift = 0.0,
                                  rate_multiplier = 1.0) {
  # Effective growth rate = base_rate * rate_multiplier
  r_eff <- base_rate * rate_multiplier
  
  # Compute logistic growth for each time point
  y <- sapply(time, function(t) logistic_growth(t, K, r_eff, lag_shift))
  
  return(y)
}

# Generate multiple growth curves and combine into one data frame
generate_growth_curves <- function(num_curves = 100, time_points = 50) {
  # Create a sequence of time points (e.g., from 0 to 24 hours)
  t <- seq(0, 24, length.out = time_points)
  
  # Initialize a list to store each curve's data
  curves_list <- vector("list", length = num_curves)
  
  # Loop over the desired number of curves
  for (i in seq_len(num_curves)) {
    
    # Randomize parameters for each curve
    K <- runif(1, 0.8, 1.2)           # Carrying capacity
    base_rate <- runif(1, 0.2, 1.0)   # Base growth rate
    lag_shift <- runif(1, 2, 6)       # Time shift (controls lag phase)
    rate_multiplier <- runif(1, 1, 5) # Steepness of exponential phase
    
    # Generate the growth curve
    y_values <- simulate_growth_curve(
      time            = t,
      K               = K,
      base_rate       = base_rate,
      lag_shift       = lag_shift,
      rate_multiplier = rate_multiplier
    )
    
    # Store the curve data in a temporary data frame
    df_temp <- data.frame(
      curve_id = i,
      time     = t,
      value    = y_values
    )
    
    # Append to the list
    curves_list[[i]] <- df_temp
  }
  
  # Combine all data frames into one
  df_all <- do.call(rbind, curves_list)
  return(df_all)
}

# --------------------------------------------
# Example usage
# --------------------------------------------

# Generate a data frame with 100 different growth curves
df_growth <- generate_growth_curves(num_curves = 100, time_points = 50)

# Inspect the first few rows
head(df_growth)


