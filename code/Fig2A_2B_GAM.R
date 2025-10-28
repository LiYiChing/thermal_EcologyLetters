# --------------------------------------------------------------------
# 1. Load Required Libraries
# --------------------------------------------------------------------
library(mgcv)       # For Generalized Additive Models (GAM)
library(ggplot2)    # For data visualization
# --------------------------------------------------------------------
# 2. Data Loading and Preparation
# --------------------------------------------------------------------
data_t <- read.csv("body_temp.csv")
data_i <- read.csv("individual.csv")

# Select only necessary columns from individual data (nm, gender)
data_i <- data_i[, c("nm", "gender")]

# Merge time-series data with individual data
data_t <- merge(data_t, data_i, all.x = TRUE, by = "nm") 

# Create a combined factor for grouping
data_t$group <- paste(data_t$gender, data_t$mi_hier)

# Separate data by treatment group
data_m <- subset(data_t, data_t$treat == "maggot") # Blowfly group
data_c <- subset(data_t, data_t$treat == "control") # Control group

# --------------------------------------------------------------------
# 3. Statistical Analysis
# --------------------------------------------------------------------

# 1. Split the data frames into a list based on the 'group' variable
list_of_groups_maggot <- split(data_m, data_m$group)
list_of_groups_control <- split(data_c, data_c$group)

# 2. Define a function to fit the GAM model and return the ANOVA result
run_gam_and_anova <- function(data_subset) {
  # Fit GAM Model: Relative body temperature (Tb.Tc) as a smooth function of time
  # bs="cs" specifies a cubic regression spline
  model <- gam(Tb.Tc ~ s(Time_Relative_sf, bs = "cs"), data = data_subset)
  
  # Return the ANOVA result to test the significance of the smooth term
  return(anova(model))
}

# 3. Apply the function to each data frame in the list using lapply()
all_anova_results <- c(
  lapply(list_of_groups_maggot, run_gam_and_anova),
  lapply(list_of_groups_control, run_gam_and_anova)
)

# Print all results
print(all_anova_results) 

# --------------------------------------------------------------------
# 4. Visualization (Figure 2A & 2B)
# Plotting the GAM-smoothed time course of relative body temperature
# --------------------------------------------------------------------

# Define shared color and label scheme
color_scheme <- c("#dc143c", "#fa8072", "#90EE90", "#008b8b", "#00ced1", "#afeeee")
label_scheme <- c("♀ α", "♀ β", "♀ γ", "♂ α", "♂ β", "♂ γ")

# --- Figure 2A: Control Group ---
figure_2A <- ggplot(data = data_c, aes(x = Time_Relative_sf / 3600, y = Tb.Tc, color = group)) +
  # Plot GAM smooth curve
  geom_smooth(method = "gam", se = FALSE, formula = y ~ s(x, bs = "cs")) +
  
  # Manual color scale and labels (Social Rank + Gender)
  scale_color_manual(
    name = "",
    values = color_scheme,
    labels = label_scheme
  ) +
  
  theme_classic() +
  theme(text = element_text(size = 15)) +
  labs(x = "Time", y = "Relative body temperature (°C)") +
  
  # Custom x-axis breaks and labels (converting seconds to time clock)
  scale_x_continuous(
    breaks = c(0.0, 2.5, 5.0, 7.5, 10.0), 
    labels = c("19:00", "21:30", "00:00", "02:30", "05:00") 
  ) +
  coord_cartesian(ylim = c(-0.5, 3), expand = TRUE)

print(figure_2A)

# --- Figure 2B: Blowfly Group ---
figure_2B <- ggplot(data = data_m, aes(x = Time_Relative_sf / 3600, y = Tb.Tc, color = group)) +
  # Plot GAM smooth curve
  geom_smooth(method = "gam", se = FALSE, formula = y ~ s(x, bs = "cs")) +
  
  # Manual color scale and labels
  scale_color_manual(
    name = "",
    values = color_scheme,
    labels = label_scheme
  ) +
  
  theme_classic() +
  theme(text = element_text(size = 15)) +
  labs(x = "Time", y = "Relative body temperature (°C)") +
  
  # Custom x-axis breaks and labels
  scale_x_continuous(
    breaks = c(0.0, 2.5, 5.0, 7.5, 10.0), 
    labels = c("19:00", "21:30", "00:00", "02:30", "05:00") 
  ) +
  coord_cartesian(ylim = c(-0.5, 3), expand = TRUE)

print(figure_2B)