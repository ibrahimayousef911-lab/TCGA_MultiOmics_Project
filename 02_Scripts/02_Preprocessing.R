# ============================================================
# Script: 02_Preprocessing.R
# Purpose: Feature selection and matching
# ============================================================

# --- Load Data ---
rna <- fread("01_Data/rna_matched.csv")
methyl <- fread("01_Data/methyl_matched.csv")

# --- Convert to data.frame ---
rna_df <- as.data.frame(rna)
rownames(rna_df) <- rna_df[,1]
rna_df <- rna_df[,-1]

methyl_df <- as.data.frame(methyl)
rownames(methyl_df) <- methyl_df[,1]
methyl_df <- methyl_df[,-1]

# --- Transpose (Features x Samples) ---
rna_t <- t(rna_df)
methyl_t <- t(methyl_df)

# --- Check Dimensions ---
cat("RNA (Features x Samples):", dim(rna_t), "\n")
cat("Methylation (Features x Samples):", dim(methyl_t), "\n")

cat("Preprocessing completed!\n")