# ============================================================
# Script: 05_Clinical_Association.R
# Purpose: Associate MOFA2 clusters with PAM50 subtypes
# ============================================================

# --- Load Libraries ---
library(MOFA2)
library(data.table)

# --- Load Data ---
MOFAobject <- readRDS("03_Results/MOFA2_object.rds")
factors_clusters <- read.csv("03_Results/MOFA2_clusters.csv")
clinical <- read.csv("01_Data/BRCA_Clinical.txt", sep="\t", row.names = 1, check.names = FALSE)

# --- Fix rownames of factors_clusters ---
rownames(factors_clusters) <- factors_clusters$Sample
factors_clusters$Sample <- NULL

# --- Find Common Samples ---
factors_matrix <- get_factors(MOFAobject)[[1]]
common_samples <- intersect(rownames(factors_matrix), rownames(clinical))
clinical_subset <- clinical[common_samples, ]

# --- Add Cluster to Clinical ---
clinical_subset$Cluster <- factors_clusters$Cluster[match(rownames(clinical_subset), rownames(factors_clusters))]

# --- Contingency Table ---
contingency <- table(clinical_subset$Cluster, clinical_subset$PAM50_mRNA_nature2012)

# --- Save ---
write.csv(as.data.frame.matrix(contingency), "03_Results/MOFA2_clusters_PAM50.csv")

# --- Print ---
print(contingency)

cat("Clinical association completed!\n")