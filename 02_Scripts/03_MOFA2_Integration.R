# ============================================================
# Script: 03_MOFA2_Integration.R
# Purpose: Run MOFA2 Integration on RNA + Methylation
# ============================================================

# --- Load Libraries ---
library(MOFA2)
library(data.table)

# --- Load Preprocessed Data ---
rna <- fread("01_Data/rna_matched.csv")
methyl <- fread("01_Data/methyl_matched.csv")

# --- Convert and Transpose ---
rna_df <- as.data.frame(rna)
rownames(rna_df) <- rna_df[,1]
rna_df <- rna_df[,-1]
rna_t <- t(rna_df)

methyl_df <- as.data.frame(methyl)
rownames(methyl_df) <- methyl_df[,1]
methyl_df <- methyl_df[,-1]
methyl_t <- t(methyl_df)

# --- Create MOFA Object ---
MOFAobject <- create_mofa(list(
  "RNA" = as.matrix(rna_t),
  "Methylation" = as.matrix(methyl_t)
))

# --- Get Default Options ---
data_opts <- get_default_data_options(MOFAobject)
model_opts <- get_default_model_options(MOFAobject)
train_opts <- get_default_training_options(MOFAobject)

# --- Modify Options ---
data_opts$scale_views <- TRUE
model_opts$likelihoods <- c("gaussian", "gaussian")
model_opts$spikeslab_weights <- TRUE
train_opts$convergence_mode <- "fast"
train_opts$seed <- 123

# --- Prepare MOFA ---
MOFAobject <- prepare_mofa(
  MOFAobject,
  data_options = data_opts,
  model_options = model_opts,
  training_options = train_opts
)

# --- Train MOFA ---
MOFAobject <- run_mofa(
  MOFAobject,
  outfile = "03_Results/MOFA2_model.hdf5",
  use_basilisk = FALSE
)

# --- Save MOFA Object ---
saveRDS(MOFAobject, "03_Results/MOFA2_object.rds")

# --- Calculate Variance Explained ---
var_explained <- calculate_variance_explained(MOFAobject)
write.csv(var_explained$r2_total$group1, "03_Results/MOFA2_variance_explained.csv")
write.csv(var_explained$r2_per_factor$group1, "03_Results/MOFA2_variance_per_factor.csv")

cat("MOFA2 integration completed!\n")