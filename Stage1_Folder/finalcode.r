#########################################
# 1. Set Up a Personal Library
#########################################
# Determine a user-specific library path.
user_lib <- Sys.getenv("R_LIBS_USER")
if (!nzchar(user_lib)) {
  user_lib <- file.path(Sys.getenv("HOME"), "R", "win-library", paste0(R.version$major, ".", R.version$minor))
}
if (!dir.exists(user_lib)) {
  dir.create(user_lib, recursive = TRUE)
}
# Prepend the user library to .libPaths so installations go there.
.libPaths(c(user_lib, .libPaths()))
message("Using library paths: ", paste(.libPaths(), collapse = ", "))

#########################################
# 2. Install and Load Required Packages
#########################################
# Install BiocManager if necessary.
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager", lib = user_lib)
}

# List of required Bioconductor packages.
required_pkgs <- c("GenomeInfoDbData", "GenomeInfoDb", "IRanges", "XVector", "Biostrings")

# Install any missing packages.
for(pkg in required_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, lib = user_lib, ask = FALSE)
  }
}

# Load Biostrings (this will also load its dependencies)
library(Biostrings)

#########################################
# 3. Define the DNA-to-Protein Function
#########################################
dna1 <- function(DNAstring) {
  # Create a DNAString object from the input string.
  dna_seq <- DNAString(DNAstring)
  
  # Translate the DNA sequence into a protein sequence.
  protein <- translate(dna_seq, if.fuzzy.codon = "error")
  
  # Return the resulting protein sequence.
  return(protein)
}

#########################################
# 4. Run the Function and Display Output
#########################################
protein_sequence <- dna1("ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG")
print(protein_sequence)




## Assignment 2
# -------------------------------------------------
# Logistic Growth + Death Phase Simulation in R
# -------------------------------------------------
# 1) Define a piecewise growth function:
#    - Logistic up to t_death
#    - Exponential decay after t_death
growth_with_death <- function(t,
                              K,
                              base_rate,
                              lag_shift,
                              rate_multiplier,
                              t_death,
                              r_death) {
  # Effective growth rate for the logistic portion
  r_eff <- base_rate * rate_multiplier
  
  # Logistic portion (covers lag, log, and stationary)
  y_logistic <- K / (1 + exp(-r_eff * (t - lag_shift)))
  
  # Population size exactly at t_death
  y_at_death <- K / (1 + exp(-r_eff * (t_death - lag_shift)))
  
  # Piecewise definition:
  # if t <= t_death, use logistic; if t > t_death, use exponential decay
  y <- ifelse(
    t <= t_death,
    yes = y_logistic,
    no  = y_at_death * exp(-r_death * (t - t_death))
  )
  
  return(y)
}
# 2) Simulate a single growth curve (vector of time) with the piecewise model
simulate_growth_curve_with_death <- function(time,
                                             K               = 1.0,
                                             base_rate       = 1.0,
                                             lag_shift       = 0.0,
                                             rate_multiplier = 1.0,
                                             t_death         = 15.0,
                                             r_death         = 0.1) {
  # Apply the piecewise growth function at each time point
  y_values <- sapply(time, function(t_point) {
    growth_with_death(t_point,
                      K,
                      base_rate,
                      lag_shift,
                      rate_multiplier,
                      t_death,
                      r_death)
  })
  
  return(y_values)
}
# 3) Generate multiple curves (with random parameters) into one data frame
generate_growth_curves_with_death <- function(num_curves   = 100,
                                              time_points  = 50) {
  # Keep the simulation range at 0..24
  t <- seq(0, 24, length.out = time_points)
  
  curves_list <- vector("list", length = num_curves)
  
  for (i in seq_len(num_curves)) {
    # --- Randomize parameters for the logistic portion ---
    K               <- runif(1, 0.8, 1.2)   # carrying capacity
    base_rate       <- runif(1, 0.2, 1.0)   # base growth rate
    lag_shift       <- runif(1, 0, 3)       # shift for lag phase
    rate_multiplier <- runif(1, 1, 5)       # modifies exponential steepness
    
    # --- Randomize parameters for the death phase ---
    t_death <- runif(1, 12, 24)            # time to start dying
    r_death <- runif(1, 0.05, 0.2)         # rate of decay
    
    # Generate the growth+death curve
    y_values <- simulate_growth_curve_with_death(
      time            = t,
      K               = K,
      base_rate       = base_rate,
      lag_shift       = lag_shift,
      rate_multiplier = rate_multiplier,
      t_death         = t_death,
      r_death         = r_death
    )
    
    # Store the curve data in a temporary data frame
    df_temp <- data.frame(
      curve_id = i,
      time     = t,
      value    = y_values
    )
    
    curves_list[[i]] <- df_temp
  }
  
  # Combine all curves into one data frame
  df_all <- do.call(rbind, curves_list)
  return(df_all)
}
# -------------------------------------------------
# Main Code Execution
# -------------------------------------------------
# Generate a data frame with 100 different growth curves (lag, log, stationary, death)
df_growth <- generate_growth_curves_with_death(num_curves = 100, time_points = 50)
# Inspect the first few rows
head(df_growth)
# -------------------------------------------------
# Plotting the Data (ggplot2)
# -------------------------------------------------
# If ggplot2 is not installed, uncomment:
# install.packages("ggplot2")
library(ggplot2)
ggplot(df_growth, aes(x = time, y = value, group = factor(curve_id))) +
  geom_line(alpha = 0.7) +
  labs(title = "100 Simulated Logistic Growth Curves",
       x = "Time",
       y = "Population Size") +
  # Approach B: "Zoom out" by extending x-axis to 30
  scale_x_continuous(limits = c(0, 25)) +
  theme_minimal()

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


# Assigment 4 
# Install and load the stringdist package
install.packages("stringdist")
library(stringdist)

# Function to pad strings to equal length
pad_strings <- function(x, y, pad_char = " ") {
  len_x <- nchar(x)
  len_y <- nchar(y)
  
  if (len_x < len_y) {
    x <- paste0(x, strrep(pad_char, len_y - len_x))
  } else if (len_y < len_x) {
    y <- paste0(y, strrep(pad_char, len_x - len_y))
  }
  return(list(x = x, y = y))
}

# Function to calculate Hamming distance between two strings after padding
hamming_distance <- function(x, y) {
  padded <- pad_strings(x, y)
  d <- stringdist(padded$x, padded$y, method = "hamming")
  return(d)
}

# Compute the Hamming distance between two strings
distance <- hamming_distance(
  "Terry_ngala, Tyler, Perex, Gracious, Mahpara",
  "ngala_terry, Ty_Maire, imontepez, Gracious_1, Mahpara_twitter"
)

# Print the computed Hamming distance
print(distance)




#github of all members of group 
#https://github.com/mahpara97, https://github.com/Terryida
#https://github.com/imontepez , https://github.com/tylermaire , https://github.com/Graciousisoah
