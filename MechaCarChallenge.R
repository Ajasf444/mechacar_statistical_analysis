library(tidyverse)
library(glue)

# Deliverable 1
mecha_car <- read.csv('Resources/MechaCar_mpg.csv')
model <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
              ground_clearance + AWD, data = mecha_car)
model
summary(model)

# Deliverable 2
# Import csv
coil <- read.csv('Resources/Suspension_Coil.csv')

# Create summary statistics dataframe
total_summary <- coil %>% 
  summarize(
    Mean = mean(PSI),
    Median = median(PSI),
    Variance = var(PSI),
    SD = sd(PSI)
    )

# Create summary statistics by lot dataframe
lot_summary <- coil %>% group_by(Manufacturing_Lot) %>%
  summarize(
    Mean = mean(PSI),
    Median = median(PSI),
    Variance = var(PSI),
    SD = sd(PSI)
    )

# Deliverable 3
t_test_lots <- function(data, lots, mu) {
  for (lot in lots) {
    lot_data <- data %>% filter(Manufacturing_Lot == lot)
    lot_test_result <- t.test(lot_data$PSI, mu = mu)
    print(glue('{lot} t-test p-value: {lot_test_result$p.value}.'))
  }
}

t_test_lots(coil, lot_summary$Manufacturing_Lot, 1500)
