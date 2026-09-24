# ============================================================
# Script: 04_Clustering.R
# Purpose: Clustering on MOFA2 factors
# ============================================================

# --- Load Libraries ---
library(MOFA2)

# --- Load MOFA Object ---
MOFAobject <- readRDS("03_Results/MOFA2_object.rds")

# --- Get Factors ---
factors_matrix <- get_factors(MOFAobject)[[1]]

# --- K-means Clustering ---
set.seed(123)
kmeans_result <- kmeans(factors_matrix, centers = 3, nstart = 25)

# --- Create Clusters Data Frame ---
factors_clusters <- data.frame(
  Sample = rownames(factors_matrix),
  Cluster = kmeans_result$cluster
)

# --- Save Clusters ---
write.csv(factors_clusters, "03_Results/MOFA2_clusters.csv", row.names = FALSE)

# --- Plot Factors Colored by Cluster ---
library(ggplot2)

factors_df <- data.frame(
  Factor1 = factors_matrix[,1],
  Factor2 = factors_matrix[,2],
  Cluster = as.factor(factors_clusters$Cluster)
)

p <- ggplot(factors_df, aes(x = Factor1, y = Factor2, color = Cluster)) +
  geom_point(size = 1.5, alpha = 0.7) +
  theme_classic() +
  labs(title = "MOFA2 Factors Colored by Cluster",
       x = "Factor 1", y = "Factor 2")

ggsave("04_Figures/MOFA2_clusters.png", plot = p, width = 10, height = 6, dpi = 150)

cat("Clustering completed!\n")