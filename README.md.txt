# TCGA Pan-Cancer Multi-Omics Integration with Deep Learning

![R](https://img.shields.io/badge/R-4.6.1-blue)
![Python](https://img.shields.io/badge/Python-3.13-yellow)
![License](https://img.shields.io/badge/license-MIT-green)

## Integrating Transcriptomics and Methylation in Breast Cancer (BRCA) Using MOFA2 and Deep Learning

Author: Ibrahim Ashraf  
Dataset: TCGA (The Cancer Genome Atlas) — BRCA  
R Version: 4.6.1  
Python Version: 3.13  
Project Type: Multi-Omics Integration + Deep Learning

---

## Overview

This project presents a comprehensive Multi-Omics Integration of Breast Invasive Carcinoma (BRCA) data from TCGA, combining RNA-seq and Methylation data using two complementary approaches:

1. MOFA2 (Multi-Omics Factor Analysis) — A probabilistic framework for latent factor discovery.
2. Deep Learning (Autoencoders) — A neural network approach for dimensionality reduction and integration.

The main goal is to move from individual genes and CpG sites toward coordinated molecular programs that can be linked to clinical outcomes (PAM50 subtypes and Survival).

---

## Dataset

The data was obtained from UCSC Xena (TCGA Hub).

| Data Type | Samples | Features |
|-----------|---------|----------|
| RNA-seq (HTSeq-FPKM) | 1,218 | 20,530 genes |
| Methylation (450K) | 888 | 485,577 CpG sites |
| Clinical Data | 1,247 | 191 variables |
| Mutation (MC3) | 2,907,335 mutations | — |

After matching: 873 samples with both RNA + Methylation.

---

## Methodology

### 1. Data Preprocessing
- RNA-seq: Filtered to Top 5,000 Highly Variable Genes (HVG).
- Methylation: Filtered to Top 10,000 Variable CpG Sites.
- Matching: Intersection of RNA and Methylation samples → 873 samples.

### 2. MOFA2 Integration
- 2 Views: RNA + Methylation.
- Options: Gaussian likelihood, Spike-and-Slab weights, fast convergence.
- Latent Factors: 15.
- Variance Explained:
  - RNA: 50.09%
  - Methylation: 53.55%

### 3. Deep Learning (Autoencoders)
- Architecture: Encoder (512 → 128 → 64) + Decoder (64 → 128 → 512).
- Separate Autoencoder for each view.
- Latent Space: 64-dim per view → 128-dim combined.
- Optimizer: Adam, lr = 0.0001.
- Loss: MSE, 50 epochs.

### 4. Clustering
- K-means (k=3) on MOFA2 factors → MOFA2 Clusters.
- K-means (k=3) on Deep Learning latent space → DL Clusters.

### 5. Clinical Association
- MOFA2 Clusters vs PAM50 Subtypes (Contingency Table).
- Results: Strong association with Basal-like and HER2-enriched.

### 6. Survival Analysis
- Kaplan-Meier Survival Curves by MOFA2 Cluster.
- p-value: 0.019 (significant).
- Observation: Cluster 3 has the highest survival, Cluster 2 has the lowest.

### 7. Top Genes
- Factor 1: AGR3, TFF1, SFRP1, GABRP, AGR2, SOX10.
- Factor 2: AGR3, TFF1, ANKRD30A, PGR, TFF3.

---

## Main Results

| Analysis | Result |
|----------|--------|
| RNA Variance Explained | 50.09% |
| Methylation Variance Explained | 53.55% |
| MOFA2 Factors | 15 |
| MOFA2 Clusters | 3 |
| Deep Learning Clusters | 3 |
| Survival p-value | 0.019 |
| Common Samples | 873 |

---

## Biological Interpretation

The integrated results highlight:

- PAM50 Association: MOFA2 Clusters correlate strongly with Basal-like and HER2-enriched subtypes.
- Survival: Clusters show significant differences in survival (p = 0.019).
- Top Genes: Include well-known breast cancer markers (TFF1, TFF3, PGR, SOX10).
- Cross-Method Agreement: MOFA2 and Deep Learning show strong agreement in cluster assignment.

---

## Repository Structure

| Folder | Contents |
|--------|----------|
| 01_Data/ | RNA-seq, Methylation, Clinical, Mutation (CSV files) |
| 02_Scripts/ | R scripts (00-07) + Python Notebook |
| 03_Results/ | MOFA2 results, clustering, survival, Deep Learning outputs |
| 04_Figures/ | QC plots, MOFA2 plots, Survival curves |
| 05_Notes/ | Project notes |
| README.md | Project documentation |
| .gitignore | Files excluded from GitHub |

---
## Analysis Scripts

The workflow is organized into modular scripts in 02_Scripts/:

| Script | Purpose |
|--------|---------|
| 00_Project_Setup.R | Libraries and Python setup |
| 01_Load_Data.R | Load RNA, Methylation, Clinical |
| 02_Preprocessing.R | Feature selection and matching |
| 03_MOFA2_Integration.R | MOFA2 training |
| 04_Clustering.R | K-means clustering |
| 05_Clinical_Association.R | PAM50 association |
| 06_Survival_Analysis.R | Kaplan-Meier analysis |
| 07_Top_Genes.R | Top gene extraction |
| TCGA_MultiOmics_DeepLearning.ipynb | Deep Learning pipeline |

---

## Software & Methods

### R Packages
- MOFA2, data.table, ggplot2, dplyr, survival, survminer, reticulate.

### Python Packages
- PyTorch, scikit-learn, pandas, numpy, matplotlib.

### Workflow
Data Download → Preprocessing → MOFA2 Integration → Deep Learning → Clustering → Clinical Association → Survival Analysis → Top Genes → Biological Interpretation

---

## Project Motivation

The main purpose of this project was to apply Multi-Omics Integration techniques to real TCGA data, and to compare two complementary approaches (MOFA2 vs Deep Learning) for discovering molecular subtypes of Breast Cancer.

The project connects:

- R programming
- Python programming
- Multi-Omics Integration
- Deep Learning
- Survival Analysis
- Biological Interpretation

---

## Conclusion

This project integrates RNA-seq and Methylation data from TCGA BRCA, using both MOFA2 and Deep Learning approaches.

The results show:

- Strong PAM50 Association with Basal-like and HER2-enriched subtypes.
- Significant Survival Differences between clusters (p = 0.019).
- Cross-Method Agreement between MOFA2 and Deep Learning.

The project demonstrates how multiple biological data layers can be integrated into a reproducible computational framework.

From Multi-Omics Integration to Clinical Interpretation.

---

## 🔗 Full Repository

[TCGA_MultiOmics_Project](https://github.com/ibrahimayousef911-lab/TCGA_MultiOmics_Project)

Feedback, suggestions, and constructive criticism are welcome.

---

## License

MIT License