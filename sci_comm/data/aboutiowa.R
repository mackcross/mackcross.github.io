rm(list=ls())
library(readr)

# Existing datasets
meals_df <- read_csv("cleaned_grouped_data.csv")
edu_df <- read_csv("cleaned_rural.csv")

# Rural variables 
RUCA <- read_csv("original_data/ruralurbancodes2013.csv")
farm <- read_csv("original_data/avg_corn_yields.csv")


# Subsetting meals_df so its only 2022 
meals_df <- meals_df[meals_df$year == 2022, ]
# Making name all lowercase
meals_df$name <- tolower(meals_df$name)
meals_df$name <- gsub(" ", "_", meals_df$name)


# Subsetting edu so only density reamins 
edu_df <- edu_df[, c("density", "name", "County")]

# Subsetting RUCA so only County_name" and "RUCC" remain
RUCA <- RUCA[, c("County_Name", "RUCC_2013")]
RUCA$County_Name <- tolower(RUCA$County_Name)
RUCA$County_Name <- gsub(" county", "", RUCA$County_Name, ignore.case = TRUE)
RUCA$County_Name <- gsub(" ", "_", RUCA$County_Name)
RUCA$County_Name <- gsub("'", "", RUCA$County_Name)


# Merging dataframes
merged_df <- merge(farm, edu_df, by = "name")
merged_df2 <- merge(merged_df, meals_df, by = "name")
merged_df3 <- merge(merged_df2, RUCA, by.x = "name", by.y = "County_Name")


write.csv(merged_df3, file = "aboutiowa.csv", row.names = FALSE)











