# ============================================================
# Project: TCGA Multi-Omics Integration
# Script: 00_Project_Setup.R
# Purpose: Load libraries and setup environment
# Author: Ibrahim Ashraf
# ============================================================

# --- Load Libraries ---
library(MOFA2)
library(data.table)
library(ggplot2)
library(dplyr)
library(survival)
library(survminer)
library(reticulate)

# --- Set Python Path ---
Sys.setenv(RETICULATE_PYTHON = "D:/python.exe")
use_python("D:/python.exe", required = TRUE)

# --- Set Seed ---
set.seed(123)

# --- Print Session Info ---
cat("Libraries loaded successfully!\n")
cat("R version:", R.version.string, "\n")
cat("MOFA2 version:", as.character(packageVersion("MOFA2")), "\n")