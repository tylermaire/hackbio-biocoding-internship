##Assignment 3
# Function to determine the time at which population reaches 80% of carrying capacity
find_time_to_80_percent_K <- function(time, values, K) {
  # Define threshold as 80% of carrying capacity
  threshold <- 0.8 * K
  
  # Find the first time point where the value meets or exceeds the threshold
  time_reach <- min(time[values >= threshold], na.rm = TRUE)
  
  return(time_reach)
}
# Simulated growth curve
time_points <- seq(0, 24, length.out = 50)
y_values <- simulate_growth_curve_with_death(time_points, K = 1.0, base_rate = 1.0, lag_shift = 0.0, rate_multiplier = 1.0, t_death = 15.0, r_death = 0.1)
time_to_80_percent <- find_time_to_80_percent_K(time_points, y_values, K = 1.0)
print(paste("Time to reach 80% of K:", time_to_80_percent))
