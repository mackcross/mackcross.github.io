rm(list=ls())
library(readr)

# Existing datasets
meals_df <- read_csv("cleaned_grouped_data.csv")
edu_df <- read_csv("cleaned_rural.csv")

# Subsetting meals_df so its only 2022 
meals_df <- meals_df[meals_df$year == 2022, ]
# Making name all lowercase
meals_df$name <- tolower(meals_df$name)
meals_df$name <- gsub(" ", "_", meals_df$name)

# Subsetting edu so only density reamins 
edu_df <- edu_df[, c("CountySpendingPerStudent", "name", "County", "mean_sci")]

# Merging dataframes
merged_df <- merge(meals_df, edu_df, by = "name")


write.csv(merged_df, file = "bivariate_variables.csv", row.names = FALSE)


















