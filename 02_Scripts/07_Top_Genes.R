# ============================================================
# Script: 07_Top_Genes.R
# Purpose: Extract top genes for Factor 1 and 2
# ============================================================

# --- Load Libraries ---
library(MOFA2)
library(data.table)

# --- Load MOFA Object ---
MOFAobject <- readRDS("03_Results/MOFA2_object.rds")

# --- Get RNA Weights ---
weights_rna <- get_weights(MOFAobject, views = "RNA")$RNA

# --- Get Top Genes ---
top_genes_factor1 <- names(sort(abs(weights_rna[,1]), decreasing = TRUE)[1:100])
top_genes_factor2 <- names(sort(abs(weights_rna[,2]), decreasing = TRUE)[1:100])

# --- Save ---
write.csv(top_genes_factor1, "03_Results/MOFA2_top_genes_Factor1.csv", row.names = FALSE)
write.csv(top_genes_factor2, "03_Results/MOFA2_top_genes_Factor2.csv", row.names = FALSE)

# --- Print ---
cat("Top genes for Factor 1:\n")
print(head(top_genes_factor1, 10))
cat("\nTop genes for Factor 2:\n")
print(head(top_genes_factor2, 10))

cat("Top genes extraction completed!\n")