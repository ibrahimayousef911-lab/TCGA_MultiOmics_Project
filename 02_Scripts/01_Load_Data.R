# ============================================================
# Script: 01_Load_Data.R
# Purpose: Load RNA-seq, Methylation, and Clinical data
# ============================================================

# --- Load RNA-seq ---
rna <- fread("01_Data/rna_matched.csv")
cat("RNA shape:", dim(rna), "\n")

# --- Load Methylation ---
methyl <- fread("01_Data/methyl_matched.csv")
cat("Methylation shape:", dim(methyl), "\n")

# --- Load Clinical ---
clinical <- read.csv("01_Data/BRCA_Clinical.txt", sep="\t", row.names = 1, check.names = FALSE)
cat("Clinical shape:", dim(clinical), "\n")

# --- Check Common Samples ---
common <- intersect(rownames(rna), rownames(clinical))
cat("Common samples (RNA & Clinical):", length(common), "\n")

cat("Data loaded successfully!\n")