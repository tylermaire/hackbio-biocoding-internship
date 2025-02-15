# Stage1 - HackBio Internship 2025 (Coding for Bio)

## Overview
Welcome to Stage1 of our HackBio Internship project! In this stage, Team Threonine-2 has advanced our coding and bioinformatics skills by developing an integrated R script that tackles multiple tasks—from DNA sequence translation to simulating biological growth dynamics and string analysis.

Our project includes four main assignments:

- **Assignment 1:** DNA Translation using Biostrings  
- **Assignment 2:** Simulation of Logistic Growth with a Death Phase  
- **Assignment 3:** Determining the Time to Reach 80% of Carrying Capacity  
- **Assignment 4:** Computing Hamming Distance Between Strings

## Project Details

### Assignment 1: DNA Translation
- **Objective:** Translate a DNA sequence into its corresponding protein sequence.
- **Tools:** R, `Biostrings` package.
- **Description:**  
  A function named `dna1` converts a provided DNA sequence into a `DNAString` object and translates it using the standard genetic code. This helps demonstrate how computational tools can assist in bioinformatics analyses.

### Assignment 2: Logistic Growth with Death Phase Simulation
- **Objective:** Model population dynamics that feature logistic growth up to a certain point followed by an exponential decay.
- **Tools:** R.
- **Description:**  
  - **`growth_with_death`:** A piecewise function that computes population size. For time points before a specified death phase (`t_death`), it applies logistic growth. For times after `t_death`, it simulates exponential decay.
  - **`simulate_growth_curve_with_death`:** Generates a single growth curve over a range of time points.
  - **`generate_growth_curves_with_death`:** Produces multiple curves (with randomized parameters) to capture biological variability.  
  - **Visualization:** The resulting curves are plotted using `ggplot2` to illustrate the dynamics over time.

### Assignment 3: Time to Reach 80% of Carrying Capacity
- **Objective:** Identify when a simulated population reaches 80% of its carrying capacity (K).
- **Tools:** R.
- **Description:**  
  The function `find_time_to_80_percent_K` scans through the simulated growth curve to pinpoint the first time point where the population value meets or exceeds 80% of K.

### Assignment 4: String Comparison Using Hamming Distance
- **Objective:** Compute the Hamming distance between two strings after ensuring they have equal length.
- **Tools:** R, `stringdist` package.
- **Description:**  
  - **`pad_strings`:** A helper function that pads the shorter string with spaces (or another specified character) so that both strings are of equal length.
  - **`hamming_distance`:** Uses the padded strings to calculate the Hamming distance, providing insight into the similarity between textual data (e.g., usernames or identifiers).

## Getting Started

### Prerequisites
Make sure you have R installed along with the following packages:
- **BiocManager** (to install Bioconductor packages)
- **Biostrings**
- **ggplot2**
- **stringdist**

### Installation
Run the following commands in your R console to install the required packages:
```r
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("Biostrings")
install.packages("ggplot2")
install.packages("stringdist")
