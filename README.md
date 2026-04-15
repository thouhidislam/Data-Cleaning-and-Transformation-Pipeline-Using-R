# Data-Cleaning-and-Transformation-Pipeline-Using-R
# Menstruation Data Cleaning and Transformation Pipeline Using R

This project provides a reproducible R-based workflow for cleaning, transforming, and standardizing menstruation-related health dataset variables. The pipeline is designed to handle real-world clinical or survey data containing inconsistent formats in age, weight, and height measurements.

## 📊 Overview

The script performs automated data preprocessing, including removal of duplicates, cleaning of column names, and conversion of raw string-based measurements into standardized numeric formats. Height values are converted into meters for analysis, while an optional conversion back to feet/inches is provided for reporting purposes.

The workflow ensures data consistency and prepares the dataset for downstream statistical analysis, visualization, or machine learning applications.

## ⚙️ Features

- Automatic cleaning of column names using `janitor`
- Removal of duplicate records
- Conversion of weight to numeric format
- Conversion of height (feet/inches → meters)
- Optional conversion (meters → feet/inches)
- Standardization of numeric and categorical variables
- Export of cleaned dataset to CSV and Excel formats
- Dataset structure validation

## 📦 Packages Used

- dplyr  
- janitor  
- stringr  
- rio  

## 📁 Input

Raw dataset should be loaded as:

```r
Menstruation_correct
