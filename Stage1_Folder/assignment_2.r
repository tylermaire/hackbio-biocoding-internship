# --------------------------------------------
# Logistic Growth Simulation in R
# --------------------------------------------

# 1) Logistic function
logistic_growth <- function(t, K, r, t_shift) {
  # Classic logistic:
  #   y(t) = K / (1 + exp(-r * (t - t_shift)))
  K / (1 + exp(-r * (t - t_shift)))
}

# 2) Simulate one logistic growth curve with extra parameters
simulate_growth_curve <- function(time,
                                  K             = 1.0,
                                  base_rate     = 1.0,
                                  lag_shift     = 0.0,
                                  rate_multiplier = 1.0) {
  # Effective growth rate = base_rate * rate_multiplier
  r_eff <- base_rate * rate_multiplier
  
  # Apply logistic growth over the time vector
  y_values <- sapply(time, function(t_point) {
    logistic_growth(t_point, K, r_eff, lag_shift)
  })
  
  return(y_values)
}

# 3) Generate multiple curves and combine them into one DataFrame
generate_growth_curves <- function(num_curves   = 100,
                                   time_points  = 50) {
  # Create a time vector (0 to 24 hours, for example)
  t <- seq(0, 24, length.out = time_points)
  
  # Initialize a list to store each curve's data
  curves_list <- vector("list", length = num_curves)
  
  for (i in seq_len(num_curves)) {
    # Randomize parameters for each curve
    K               <- runif(1, 0.8, 1.2)     # carrying capacity
    base_rate       <- runif(1, 0.2, 1.0)     # base logistic growth rate
    lag_shift       <- runif(1, 2, 6)         # random lag phase shift
    rate_multiplier <- runif(1, 1, 5)         # random factor for exponential steepness
    
    # Generate one logistic growth curve
    y_values <- simulate_growth_curve(
      time            = t,
      K               = K,
      base_rate       = base_rate,
      lag_shift       = lag_shift,
      rate_multiplier = rate_multiplier
    )
    
    # Create a temporary DataFrame for this curve
    df_temp <- data.frame(
      curve_id = i,
      time     = t,
      value    = y_values
    )
    
    # Add it to the list
    curves_list[[i]] <- df_temp
  }
  
  # Combine all curves into a single DataFrame
  df_all <- do.call(rbind, curves_list)
  return(df_all)
}

# --------------------------------------------
# Example Usage
# --------------------------------------------

# Generate a DataFrame with 100 curves
df_growth <- generate_growth_curves(num_curves = 100, time_points = 50)

# Check the first few rows
head(df_growth)

# (Optional) Plot the data

# -- Base R plot for one curve (curve_id == 1)
curve1 <- subset(df_growth, curve_id == 1)
plot(curve1$time, curve1$value, type = "l",
     main = "Example Logistic Growth Curve (Curve 1)",
     xlab = "Time", ylab = "Population Size",
     col = "blue", lwd = 2)

# -- ggplot2 for all curves (if ggplot2 is installed)
# install.packages("ggplot2") # Uncomment if needed
library(ggplot2)

ggplot(df_growth, aes(x = time, y = value, group = factor(curve_id))) +
  geom_line(alpha = 0.7) +
  labs(title = "100 Simulated Logistic Growth Curves",
       x = "Time",
       y = "Population Size") +
  theme_minimal()
