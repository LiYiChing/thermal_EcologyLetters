# Interspecific competition reduces energy expenditure by decreasing intragroup conflict in a social burying beetle

This repository contains the R code and analysis scripts supporting the manuscript.

The code provided here allows for the full reproduction of all core statistical models and figures presented in the main text and the supplementary material.

---

## 📋 Repository Structure

| File Name | Content |
| :--- | :--- |
| `body_temp.csv` | **Time-Series Data**: Detailed records of individual relative body temperature over time. |
| `individual.csv` | **Individual-Level Data**: Summary data including body temperature, social rank, sex, treatment group (Control/Blowfly), and aggregated behavioral variables. |
| `behavior.csv` | **Behavioral Time-Series Data**: Detailed time-series records of cooperative investment and conflict behavior across 10 time intervals. |
| `*.R` | **Analysis Scripts**: Contains all code for model fitting and figure generation. |

## 📦 Running Environment and Required Packages (R Packages)

All analyses were performed in the R environment. Please ensure you have the following essential packages installed and loaded:

```R
# Core Data Manipulation and Visualization
library(dplyr)
library(ggplot2)
library(magrittr)
library(tidyr)      # For data reshaping (gather/pivot_longer)

# Linear Models and GLMM
library(car)        # For Type III ANOVA
library(emmeans)    # For Post-hoc comparisons
library(glmmTMB)    # For Location-Scale GLMM (Figure S7)
library(ggsignif)   # For adding significance bars

# Advanced Models and Smoothing
library(mgcv)       # For Generalized Additive Models (GAM) (Figs 2A, 2B, S1, S2, S5, S6)
library(piecewiseSEM) # For Structural Equation Modeling (SEM.R)
```
## 📊 Analysis Scripts Index (Core Models & Figures)

This section links each R script file to the corresponding figure and statistical model (M1-M10, SEM, GLMM) in the manuscript.

### 1. Thermal Physiology and Social Factors (Figures 2, 3, S1, S2, S3, S4)

| Script Name | Manuscript Figure | Core Model | Key Analysis |
| :--- | :--- | :--- | :--- |
| `Fig2A_2B_GAM.R` | **Figure 2A, 2B** | **GAMs** | Smooth trends of relative body temperature over time, colored by treatment and social rank. |
| `M3_M4_Fig2C_gender.R` | **Figure 2C** | **M3, M4 (LM)** | relative body temperature vs. Social Rank and Sex. |
| `M8_Fig2D_time.R` | **Figure 2D** | **M8 (LM)** | Time to reach maximum relative body temperature vs. Treatment Group. |
| `M1_M2_Fig3_rank.R` | **Figure 3** | **M1, M2 (LM)** | Maximum relative body temperature vs. Treatment $\times$ Social Rank interaction. |
| `FigS1_S2_GAM.R` | **Figure S1, S2** | **GAM** | Scatter plots and GAM smooth lines for relative body temperature over time for each individual Rank/Sex subgroup. |
| `M5_FigS3_S4_temp.R` | **Figure S3, S4** | **M5 (LM)** | Maximum and Baseline relative body temperature vs. Social Rank/Sex. |

### 2. Cooperation and Conflict Behavior Analysis (Figures 4, S5, S6)

| Script Name | Manuscript Figure | Core Model | Key Analysis |
| :--- | :--- | :--- | :--- |
| `M6_M7_Fig4_cooperation.R` | **Figure 4A-4D** | **M6, M7 (LM)** | Partial regression plots of relative body temperature vs. Investment and Conflict Index. |
| `M9_M10_Fig4E_4F_behavior.R`| **Figure 4E, 4F** | **M9, M10 (LM)** | Total Cooperative Investment and Conflict Index vs. Treatment Group. |
| `FigS5_S6_GAM_behavior.R` | **Figure S5, S6** | **GAMs** | Smooth trends of Cooperative Investment and Conflict behavior across 10 time intervals. |

### 3. Advanced Statistical Models (Figure S7, SEM)

| Script Name | Manuscript Figure | Core Model | Description |
| :--- | :--- | :--- | :--- |
| `location_scale_model.R`| **Figure S7** | **GLMM (Location-Scale)** | Analyzes the effects of Treatment and Rank on the **Mean** (location) and **Variance** (scale) of relative body temperature. |
| `SEM.R` | **Path Diagram (Fig S8)** | **pSEM** | Piecewise Structural Equation Model testing the causal pathways among Treatment, Behavior (Conflict/Investment), and relative body temperature. |

