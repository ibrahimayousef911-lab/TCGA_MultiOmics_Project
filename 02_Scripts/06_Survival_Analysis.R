# ============================================================
# Script: 06_Survival_Analysis.R
# Purpose: Kaplan-Meier Survival Analysis by MOFA2 Cluster
# ============================================================

# --- Load Libraries ---
library(MOFA2)
library(survival)
library(survminer)
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

# --- Create Time and Status ---
clinical_subset$Time <- ifelse(
  clinical_subset$vital_status == "DECEASED",
  clinical_subset$days_to_death,
  clinical_subset$Days_to_Date_of_Last_Contact_nature2012
)

clinical_subset$Status <- ifelse(
  clinical_subset$vital_status == "DECEASED", 1, 0
)

clinical_subset$Cluster <- factors_clusters$Cluster[match(rownames(clinical_subset), rownames(factors_clusters))]

# --- Remove NA ---
clinical_surv <- clinical_subset[!is.na(clinical_subset$Time) & !is.na(clinical_subset$Cluster), ]

# --- Save ---
write.csv(clinical_surv, "03_Results/clinical_surv.csv")

# --- Survival Analysis ---
surv_object <- Surv(time = clinical_surv$Time, event = clinical_surv$Status)
km_fit <- survfit(surv_object ~ Cluster, data = clinical_surv)

# --- Plot and Save ---
png("04_Figures/MOFA2_survival_plot.png", width = 1200, height = 1000, res = 150)
print(ggsurvplot(
  km_fit,
  data = clinical_surv,
  pval = TRUE,
  risk.table = TRUE,
  title = "Kaplan-Meier Survival Curves by MOFA2 Cluster"
))
dev.off()

cat("Survival analysis completed!\n")