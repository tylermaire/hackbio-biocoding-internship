# **Drug Discovery: Chemical Space Analysis and Docking Score Prediction**

## **Overview**
This project explores how chemical properties determine the binding affinity of small molecules to the **adenosine deaminase (ADA) protein**. We analyze a **dataset of 10,000+ compounds** using **Principal Component Analysis (PCA)**, **K-means clustering**, and **machine learning regression models** to predict docking scores.

## **Objectives**
- **Visualize the chemical space** using **PCA and K-means clustering**.
- **Identify chemical clusters** with low docking scores.
- **Analyze molecular descriptors** affecting binding affinity.
- **Predict docking scores** using a **Random Forest regression model**.

## **Project Structure**


## **Installation & Dependencies**
Ensure you have R installed. Required R packages:
```r
install.packages(c("ggplot2", "dplyr", "tidyr", "factoextra", 
                   "cluster", "corrplot", "caret", "randomForest", "ggpubr"))

git clone https://github.com/your-username/drug-discovery-project.git
cd drug-discovery-project
source("drug_discovery.R")

This project is licensed under the MIT License.
