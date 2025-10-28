# --------------------------------------------------------------------
# 1. Load Required Libraries
# --------------------------------------------------------------------
library(ggplot2)    # For data visualization
library(magrittr)   # For piping functionality (e.g., %>%)
library(tidyr)      # For data reshaping (gather function)
# --------------------------------------------------------------------
# 2. Data Loading and Preparation
# --------------------------------------------------------------------

data_b <- read.csv("behavior.csv")
data_i <- read.csv("individual.csv")

# Select necessary columns from individual data and merge with behavior data
data_i <- data_i[, c("nm", "treat", "gender", "mi_hier")]
data <- merge(data_i, data_b, all.x = TRUE, by = "nm")

# Select key columns: Individual info (1-4) + behavior columns (45:64)
# columns 45:54 are conflict_1 to conflict_10 and 55:64 are investment_1 to investment_10
data <- data[, c(1:4, 45:64)] 
data[is.na(data)] <- 0 # Convert NAs (no record) to 0 (no behavior observed)

# Create a combined factor for grouping (e.g., "male 1", "female 3")
data <- data %>% mutate(member = paste(gender, mi_hier))

# Separate data by treatment group
data_m <- subset(data, data$treat == "maggot") # Blowfly group
data_c <- subset(data, data$treat == "control") # Control group

# --------------------------------------------------------------------
# 3. Visualization (Figure S5 & S6)
# --------------------------------------------------------------------

# Define shared plot elements for simplicity
shared_theme_behav <- list(
  theme_classic(),
  theme(text = element_text(size = 15)),
  scale_color_manual(
    name = "",
    values = c("#dc143c", "#fa8072", "#90EE90", "#008b8b", "#00ced1", "#afeeee"),
    labels = c("♀ α", "♀ β", "♀ γ", "♂ α", "♂ β", "♂ γ")
  ),
  # Custom x-axis breaks and labels (time intervals)
  scale_x_continuous(
    breaks = c(1, 3, 5, 7, 9, 10),
    labels = c("19:00", "21:30", "00:00", "02:30", "04:00", "05:00") 
  )
)

# --- Figure S5: Total Cooperative Investment over Time ---

# S5A, control (Reshaping data_c for investment plot)
D_S5A <- data_c %>% 
  # Use gather to convert wide to long format
  # The 'time' variable stores the column name (e.g., "investment_1")
  gather(time, investment, starts_with("investment_")) 
# Extract the time step number (1 to 10) and convert to numeric
D_S5A$time <- D_S5A$time %>% strsplit(split = '_') %>% sapply(., "[", 2) %>% as.numeric()

plot_S5A <- ggplot(data = D_S5A, aes(x = time, y = investment, group = member, color = member)) +
  # Plot GAM smooth curve by group
  geom_smooth(method = "gam", se = FALSE) +
  labs(x = "Time", y = "Total investment (s)") + 
  coord_cartesian(ylim = c(0, 600), expand = TRUE) +
  shared_theme_behav
print(plot_S5A)


# S5B, blowfly (Reshaping data_m for investment plot)
D_S5B <- data_m %>% 
  gather(time, investment, starts_with("investment_")) 
D_S5B$time <- D_S5B$time %>% strsplit(split = '_') %>% sapply(., "[", 2) %>% as.numeric()

plot_S5B <- ggplot(data = D_S5B, aes(x = time, y = investment, group = member, color = member)) +
  geom_smooth(method = "gam", se = FALSE) +
  labs(x = "Time", y = "Total investment (s)") +
  coord_cartesian(ylim = c(0, 600), expand = TRUE) +
  shared_theme_behav
print(plot_S5B)


# --- Figure S6: Social Conflict over Time ---

# S6A, control (Reshaping data_c for conflict plot)
D_S6A <- data_c %>% 
  gather(time, conflict, starts_with("conflict_"))
D_S6A$time <- D_S6A$time %>% strsplit(split = '_') %>% sapply(., "[", 2) %>% as.numeric()

plot_S6A <- ggplot(data = D_S6A, aes(x = time, y = conflict, group = member, color = member)) +
  geom_smooth(method = "gam", se = FALSE) +
  labs(x = "Time", y = "Total conflict time (s)") + 
  coord_cartesian(ylim = c(0, 12), expand = TRUE) +
  shared_theme_behav
print(plot_S6A)


# S6B, blowfly (Reshaping data_m for conflict plot)
D_S6B <- data_m %>% 
  gather(time, conflict, starts_with("conflict_"))
D_S6B$time <- D_S6B$time %>% strsplit(split = '_') %>% sapply(., "[", 2) %>% as.numeric()

plot_S6B <- ggplot(data = D_S6B, aes(x = time, y = conflict, group = member, color = member)) +
  geom_smooth(method = "gam", se = FALSE) +
  labs(x = "Time", y = "Total conflict time (s)") + 
  coord_cartesian(ylim = c(0, 12), expand = TRUE) +
  shared_theme_behav
print(plot_S6B)