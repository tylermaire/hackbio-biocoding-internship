# HackBio Multi-Omics Analysis Project

This repository contains a comprehensive analysis pipeline developed during the HackBio project. The project integrates multiple omics domains—metabolomics, protein biochemistry & oncology, transcriptomics, and public health—to derive insights from diverse datasets. All the analysis is contained in a single R script: **maincode.r**.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Project Components](#project-components)
- [Installation & Setup](#installation--setup)
- [Usage Instructions](#usage-instructions)
- [Repository Structure](#repository-structure)
- [Team & Contributions](#team--contributions)
- [Acknowledgements](#acknowledgements)
- [License](#license)

---

## Project Overview

This project addresses several HackBio tasks by applying various data science and bioinformatics techniques in R. The analysis covers:

- **Metabolomics Analysis (Task 2.3):**  
  Processing pesticide treatment data, calculating ΔM (change between 24h pesticide treatment and DMSO control), detecting outlier metabolites, and visualizing time-course data.

- **Biochemistry & Oncology (Task 2.4):**  
  Merging SIFT and FoldX datasets to identify deleterious protein mutations based on functional (SIFT) and structural (FoldX) scores, along with amino acid frequency analysis.

- **Transcriptomics (Task 2.6):**  
  Analyzing RNA-seq data to generate volcano plots and identify differentially expressed genes in diseased cell lines treated with compound X.

- **Public Health Analysis (Task 2.7):**  
  Cleaning and analyzing NHANES data to explore health trends (BMI, weight, age, etc.) through descriptive statistics, visualizations, and t-tests.

---

## Project Components

The entire analysis is organized in one R script, **maincode.r**, which is structured into the following sections:

1. **Metabolomics Analysis:**  
   - Data loading and orientation adjustments.
   - Calculation of ΔM values for wild type and mutant samples.
   - Identification of outlier metabolites and generation of scatter and time-course plots.

2. **Biochemistry & Oncology:**  
   - Import and merge of SIFT and FoldX datasets.
   - Filtering of deleterious mutations based on SIFT (< 0.05) and FoldX (> 2 kCal/mol) criteria.
   - Visualization of amino acid substitution frequencies via bar and pie charts.

3. **Transcriptomics:**  
   - Loading and exploration of RNA-seq gene expression data.
   - Creation of a volcano plot to visualize differential expression.
   - Annotation of genes based on upregulation or downregulation criteria.

4. **Public Health Analysis:**  
   - Data cleaning and NA processing for the NHANES dataset.
   - Histograms for BMI, weight (in kilograms and pounds), and age.
   - Statistical analyses including descriptive statistics and t-tests to examine relationships between variables.

---

## Installation & Setup

### Prerequisites

- **R or RStudio:** Ensure you have R installed on your system.
- **Required R Packages:**
  - `ggplot2`
  - `dplyr`
  - `ggpubr`
  - (Install any additional packages if prompted by the script.)

### Installation Steps

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/hackbio-multiomics-analysis.git
   cd hackbio-multiomics-analysis

2. **Install R Packages**

  install.packages("ggplot2")
install.packages("dplyr")
install.packages("ggpubr")

3. **Usage Instructions**
To run the complete analysis:

Open maincode.r in your R environment.
Execute the script. The code will process the data, generate visualizations, and perform statistical analyses for all four sections.
Review the output plots and console messages for insights from each analytical section.


**Team and Contribuitions**
Team & Contributions
This project was developed by Team Theronine:

mahpara97
Terryida
imontepez
tylermaire
Graciousisoah

**Acknowlegdgments**
We thank the HackBio community and organizers for the opportunity to tackle these diverse datasets and challenges, and for providing high-quality datasets that facilitated our analysis.

**License**
This project is licensed under the MIT License.
