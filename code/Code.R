

# Loading required libraries
library(readr)      # For reading CSV files
library(dplyr)      # For data manipulation
library(ggplot2)    # For creating visualizations
library(scales)     # For formatting axis labels
library(viridis)    # For color palettes
library(gridExtra)  # For arranging multiple plots
library(grid)       # For creating text elements

# assigning to the output folder location
output_folder <- "~/Desktop/NHS_Visualizations"
dir.create(output_folder, showWarnings = FALSE)


# DATA LOADING


# loading 3 years of data csv files
data_2022 <- read_csv("~/Desktop/nhs data/pca_icb_snomed_2022_2023.csv", show_col_types = FALSE)
data_2023 <- read_csv("~/Desktop/nhs data/pca_icb_snomed_2023_2024.csv", show_col_types = FALSE)
data_2024 <- read_csv("~/Desktop/nhs data/pca_icb_snomed_2024_2025.csv", show_col_types = FALSE)

# attaching all 3 datasets
combined_data <- bind_rows(data_2022, data_2023, data_2024)

# DATA PREPARATION

# making summary by bnf chapter and year
summary_chapter_year <- combined_data %>%
  group_by(BNF_CHAPTER, YEAR_DESC) %>%
  summarise(
    Total_Cost = sum(NIC, na.rm = TRUE),
    Total_Items = sum(ITEMS, na.rm = TRUE),
    .groups = "drop"
  )

# making the summary by bnf chapter 
summary_chapter <- combined_data %>%
  group_by(BNF_CHAPTER) %>%
  summarise(
    Total_Cost = sum(NIC, na.rm = TRUE),
    Total_Items = sum(ITEMS, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Total_Cost))

# VISUALISATION 1 Cost Trends Over Time

# finding top 5 most expensive therapeutic areas
top5_chapters <- summary_chapter %>% 
  head(5) %>% 
  pull(BNF_CHAPTER)

# Filter data for top 5 chapters
viz1_data <- summary_chapter_year %>%
  filter(BNF_CHAPTER %in% top5_chapters)

# making line chart which illustrate trends
viz1 <- ggplot(viz1_data, aes(x = YEAR_DESC, y = Total_Cost/1e9, 
                              group = BNF_CHAPTER, color = BNF_CHAPTER)) +
  geom_line(size = 1.5) +
  geom_point(size = 3) +
  labs(
    title = "NHS Prescription Cost Trends by Therapeutic Area (2022-2025)",
    subtitle = "Top 5 therapeutic areas showing cost evolution",
    x = "Financial Year",
    y = "Total Cost (Billions GBP)",
    color = "Therapeutic Area"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    legend.position = "bottom",
    legend.text = element_text(size = 9)
  ) +
  scale_y_continuous(labels = comma) +
  scale_color_viridis_d(option = "viridis")

# Saving visualisation
ggsave(file.path(output_folder, "visualisation1.png"), 
       viz1, width = 11, height = 7, dpi = 300)

# VISUALIZATION 2 Top 10 Therapeutic Areas

# Get top 10 chapters by total cost
viz2_data <- summary_chapter %>% head(10)

# Create horizontal bar chart
viz2 <- ggplot(viz2_data, aes(x = reorder(BNF_CHAPTER, Total_Cost), 
                              y = Total_Cost/1e9)) +
  geom_bar(stat = "identity", fill = "#2C3E50", width = 0.7) +
  coord_flip() +
  labs(
    title = "Top 10 Therapeutic Areas by Total NHS Prescription Cost (2022-2025)",
    subtitle = "Combined costs across all three financial years",
    x = "",
    y = "Total Cost (Billions GBP)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    panel.grid.major.y = element_blank()
  ) +
  scale_y_continuous(labels = comma, expand = c(0, 0), limits = c(0, NA))

# Saving visualization
ggsave(file.path(output_folder, "visualisation2.png"), 
       viz2, width = 10, height = 6, dpi = 300)


# VISUALIZATION 3 Regional Comparison

# Aggregate costs by region
viz3_data <- combined_data %>%
  group_by(REGION_NAME) %>%
  summarise(
    Total_Cost = sum(NIC, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Total_Cost))

# making regional bar chart
viz3 <- ggplot(viz3_data, aes(x = reorder(REGION_NAME, Total_Cost), 
                              y = Total_Cost/1e9)) +
  geom_bar(stat = "identity", fill = "#3498DB", width = 0.7) +
  coord_flip() +
  labs(
    title = "NHS Prescription Costs by Region (2022-2025)",
    subtitle = "Regional variation in prescription spending across England",
    x = "",
    y = "Total Cost (Billions GBP)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    panel.grid.major.y = element_blank()
  ) +
  scale_y_continuous(labels = comma)

# Saving visualization
ggsave(file.path(output_folder, "visualisation3.png"), 
       viz3, width = 10, height = 6, dpi = 300)

# VISUALIZATION 4  Top 15 Individual Drugs

# finding most expensive individual drug presentations
viz4_data <- combined_data %>%
  group_by(BNF_PRESENTATION_NAME, BNF_CHAPTER) %>%
  summarise(
    Total_Cost = sum(NIC, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(Total_Cost)) %>%
  head(15)

# making color bar chart by therapeutic area
viz4 <- ggplot(viz4_data, aes(x = reorder(BNF_PRESENTATION_NAME, Total_Cost), 
                              y = Total_Cost/1e6, fill = BNF_CHAPTER)) +
  geom_bar(stat = "identity", width = 0.7) +
  coord_flip() +
  labs(
    title = "Top 15 Most Expensive Prescription Drugs (2022-2025)",
    subtitle = "Individual drug presentations by total cost",
    x = "",
    y = "Total Cost (Millions GBP)",
    fill = "Therapeutic Area"
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    panel.grid.major.y = element_blank(),
    legend.position = "bottom",
    legend.text = element_text(size = 8)
  ) +
  scale_y_continuous(labels = comma) +
  scale_fill_viridis_d(option = "viridis")

# Saving visualization
ggsave(file.path(output_folder, "visualisation4.png"), 
       viz4, width = 11, height = 7, dpi = 300)

# VISUALISATION 5 Volume vs Cost Analysis

# Use chapter summary data
viz5_data <- summary_chapter

# Create scatter plot showing relationship
viz5 <- ggplot(viz5_data, aes(x = Total_Items/1e6, y = Total_Cost/1e9)) +
  geom_point(size = 4, alpha = 0.7, color = "#E74C3C") +
  geom_text(aes(label = ifelse(Total_Cost/1e9 > 4, 
                               substr(BNF_CHAPTER, 1, 20), "")), 
            vjust = -0.8, hjust = 0.5, size = 3) +
  labs(
    title = "Prescription Volume vs Total Cost by Therapeutic Area",
    subtitle = "Relationship between prescription volume and spending (2022-2025)",
    x = "Total Prescription Items (Millions)",
    y = "Total Cost (Billions GBP)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40")
  ) +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma)

# Save visualisation
ggsave(file.path(output_folder, "visualisation5.png"), 
       viz5, width = 10, height = 6, dpi = 300)

# VISUALIZATION 6 Year over Year Growth Rates

# Calculate year-over-year percentage change for top 10 chapters
viz6_data <- summary_chapter_year %>%
  filter(BNF_CHAPTER %in% (summary_chapter %>% head(10) %>% pull(BNF_CHAPTER))) %>%
  arrange(BNF_CHAPTER, YEAR_DESC) %>%
  group_by(BNF_CHAPTER) %>%
  mutate(
    YoY_Growth = (Total_Cost - lag(Total_Cost)) / lag(Total_Cost) * 100
  ) %>%
  filter(!is.na(YoY_Growth))

# Creating grouped bar chart illustrating growth rates
viz6 <- ggplot(viz6_data, aes(x = reorder(BNF_CHAPTER, -YoY_Growth), 
                              y = YoY_Growth, fill = YEAR_DESC)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  coord_flip() +
  labs(
    title = "Year-over-Year Growth Rates in Prescription Costs",
    subtitle = "Top 10 therapeutic areas showing annual percentage change",
    x = "",
    y = "Growth Rate (%)",
    fill = "Year"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    panel.grid.major.y = element_blank(),
    legend.position = "bottom"
  ) +
  scale_fill_manual(values = c("#2C3E50", "#3498DB")) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red")

# Saving visualization
ggsave(file.path(output_folder, "visualisation6.png"), 
       viz6, width = 11, height = 7, dpi = 300)

# VISUALIZATION 7 Summary Statistics

# Calculating key statistics
total_cost <- sum(combined_data$NIC, na.rm = TRUE) / 1e9
total_items <- sum(combined_data$ITEMS, na.rm = TRUE) / 1e6
avg_cost_per_item <- mean(combined_data$NIC_PER_ITEM, na.rm = TRUE)
top_chapter <- summary_chapter$BNF_CHAPTER[1]
top_chapter_cost <- summary_chapter$Total_Cost[1] / 1e9

# Creating text elements for infographic
title_grob <- textGrob("NHS Prescription Statistics 2022-2025", 
                       gp = gpar(fontsize = 22, fontface = "bold"))

stat1 <- textGrob(paste0("GBP ", round(total_cost, 1), "B\n\nTotal Prescription Cost"), 
                  gp = gpar(fontsize = 18, col = "#2C3E50", fontface = "bold"))

stat2 <- textGrob(paste0(round(total_items, 0), "M\n\nTotal Prescription Items"), 
                  gp = gpar(fontsize = 18, col = "#3498DB", fontface = "bold"))

stat3 <- textGrob(paste0("GBP ", round(avg_cost_per_item, 2), "\n\nAverage Cost per Item"), 
                  gp = gpar(fontsize = 18, col = "#E74C3C", fontface = "bold"))

stat4 <- textGrob(paste0(substr(top_chapter, 1, 25), "\n\nMost Expensive Area\n(GBP ", 
                         round(top_chapter_cost, 1), "B)"), 
                  gp = gpar(fontsize = 14, col = "#9B59B6", fontface = "bold"))

# Arranging statistics in grid layout
viz7 <- grid.arrange(
  title_grob,
  arrangeGrob(stat1, stat2, stat3, stat4, ncol = 2, nrow = 2),
  nrow = 2,
  heights = c(1, 5)
)

# Saving visualization
ggsave(file.path(output_folder, "visualisation7.png"), 
       viz7, width = 10, height = 7, dpi = 300)

