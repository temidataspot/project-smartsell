# STRATEGIC RETAIL OPTIMIZATION FOR MULTI-REGIONAL CHAIN [Project #SmartSell]
# Install pkgs, load & assign df
install.packages(c("tidyverse", "dplyr", "utils", "ggplot2"))
install.packages("lubridate")
library(tidyverse)
library(ggplot2)
library(utils)
library(dplyr)
library(lubridate)

features <- read_csv("Features data set.csv")
sales <- read_csv("sales data-set.csv")
stores <- read_csv("stores data-set.csv")
View(features)
View(sales)
View(stores)

# PHASE 1: DATA CLEANING & PREP
# check data type & missing values
str(sales)
str(features)
str(stores)

colSums(is.na(sales))
colSums(is.na(features))
colSums(is.na(stores))


# convert char to date
sales$Date <- as.Date(sales$Date, format = "%d-%m-%y")
features$Date <- as.Date(features$Date, format = "%d-%m-%y")

# Convert to character first in case it's been wrongly parsed
sales$Date <- as.character(sales$Date)
sales$Date <- as.Date(sales$Date, format = "%d-%m-%y")

features$Date <- as.character(features$Date)
features$Date <- as.Date(features$Date, format = "%d-%m-%y")

# PHASE 2A: EDA I
# Create derived time features in the sales & features
sales <- sales %>%
  mutate(
    Week = isoweek(Date),       # Week number of the year
    Month = month(Date),
    Month_Name = month(Date, label = TRUE, abbr = FALSE),
    Year = year(Date),
    Day = wday(Date, label = TRUE),
    Holiday_Label = ifelse(IsHoliday, "Holiday", "Non-Holiday")
  )

features <- features %>%
  mutate(
    Week = isoweek(Date),
    Month = month(Date),
    Month_Name = month(Date, label = TRUE, abbr = FALSE),
    Year = year(Date),
    Day = wday(Date, label = TRUE),
    Holiday_label = ifelse(IsHoliday, "Holiday", "Non-Holiday")
  )

# Merge sales and features by Store and Date and merge result with store metadata
sales_features <- merge(sales, features, by = c("Store", "Date"), all.x = TRUE)

full_data <- merge(sales_features, stores, by = "Store", all.x = TRUE)

# handle missing cols, confirm values set to 0
full_data <- full_data %>%
  mutate(across(starts_with("MarkDown"), ~ ifelse(is.na(.), 0, .)))
colSums(is.na(full_data))
View(full_data)

# Convert Store Type & IsHoliday to factor
full_data$Type <- as.factor(full_data$Type)
full_data$IsHoliday.x <- as.factor(full_data$IsHoliday.x)
full_data$IsHoliday.y <- as.factor(full_data$IsHoliday.y)

# plot visuals
install.packages(c("scales", "patchwork"))
library(scales)
library(patchwork)

# Extract month name for clarity
full_data <- full_data %>%
  mutate(Month = month(Date, label = TRUE, abbr = FALSE))  # e.g., "January"

# ---- 1. Weekly Sales Over Time (Curly Line Chart) ----
weekly_sales_trend <- full_data %>%
  group_by(Date) %>%
  summarise(Total_Sales = sum(Weekly_Sales, na.rm = TRUE))

plot1 <- ggplot(weekly_sales_trend, aes(x = Date, y = Total_Sales)) +
  geom_line(color = "steelblue", linewidth = 1) +
  labs(title = "Weekly Sales Over Time", x = "Date", y = "Total Sales") +
  scale_y_continuous(labels = dollar)

# ---- 2. Sales Distribution by Store Type (Boxplot) ----
plot2 <- ggplot(full_data, aes(x = Type, y = Weekly_Sales, fill = Type)) +
  geom_boxplot() +
  scale_y_continuous(labels = dollar) +
  labs(title = "Sales Distribution by Store Type", x = "Store Type", y = "Weekly Sales") +
  theme(legend.position = "none")

# ---- 3. Monthly Average Sales (Horizontal Bar Chart) ----
plot3 <- full_data %>%
  group_by(Month_Name.x) %>%
  summarise(Average_Sales = mean(Weekly_Sales, na.rm = TRUE)) %>%
  ggplot(aes(x = Average_Sales, y = Month_Name.x)) +
  geom_col(fill = "paleturquoise4") +
  geom_text(aes(label = dollar(round(Average_Sales))), 
            hjust = -0.1, fontface = "bold") +
  scale_x_continuous(labels = dollar, expand = expansion(mult = c(0, 0.2))) +
  labs(title = "Average Monthly Sales", y = "Month", x = NULL) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

# ---- 4. Holiday vs Non-Holiday Sales (Column Chart) ----
plot4 <- full_data %>%
  group_by(IsHoliday.x) %>%
  summarise(Avg_Sales = mean(Weekly_Sales, na.rm = TRUE)) %>%
  ggplot(aes(x = IsHoliday.x, y = Avg_Sales, fill = IsHoliday.x)) +
  geom_col() +
  geom_text(aes(label = dollar(round(Avg_Sales))), 
            vjust = -0.5, fontface = "bold") +
  scale_y_continuous(labels = dollar, expand = expansion(mult = c(0, 0.2))) +
  labs(title = "Holiday vs Non-Holiday Sales", x = "Is Holiday", y = NULL) +
  scale_fill_manual(values = c("gray70", "midnightblue")) +
  theme(legend.position = "none")


# ---- 5. Sales Trend Over Time by Store Type (Curly Line Chart) ----
sales_by_type <- full_data %>%
  group_by(Date, Type) %>%
  summarise(Total_Sales = sum(Weekly_Sales), .groups = 'drop')

plot5 <- ggplot(sales_by_type, aes(x = Date, y = Total_Sales, color = Type)) +
  geom_line() +
  labs(title = "Sales Trend by Store Type", x = "Date", y = "Total Sales") +
  scale_y_continuous(labels = dollar) +
  theme(legend.title = element_blank())

# ---- Combine Plots with a General Title ----
combined_plot <- (plot1 + plot2) /
  (plot3 + plot4) /
  plot5 +
  plot_annotation(title = "📊 Exploratory Data Analysis Overview: Sales Trends & Patterns",
                  theme = theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5)))

# Show the combined visual
print(combined_plot)

install.packages("writexl")
library(writexl)

# Save full_data as an Excel file
write_xlsx(full_data, path = "full_data.xlsx")
