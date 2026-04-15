# ================================
# CLEAN MENSTRUATION DATA PIPELINE
# ================================

# Load packages
library(dplyr)
library(janitor)
library(stringr)
library(rio)

# ----------------
# 1. Load data
# ----------------
df <- raw_file

# ----------------
# 2. Clean column names
# ----------------
df <- df %>% clean_names()

# ----------------
# 3. Remove duplicates
# ----------------
df <- df %>% distinct()

# ----------------
# 4. Clean Weight column (remove characters)
# ----------------
df$weight_kg <- as.numeric(gsub("[^0-9.]", "", df$weight_kg))

# ----------------
# 5. Convert Height to meters
# Format supported: 5'6 or 5.6 (feet)
# ----------------
to_meter <- function(h){
  if(is.na(h)) return(NA)
  
  h <- as.character(h)
  
  if(grepl("'", h)){
    parts <- unlist(strsplit(h, "'"))
    feet <- as.numeric(parts[1])
    inches <- as.numeric(parts[2])
    total_inches <- feet * 12 + inches
  } else {
    total_inches <- as.numeric(h) * 12
  }
  
  return(round(total_inches * 0.0254, 2))
}

df$height_m <- sapply(df$height, to_meter)

# ----------------
# 6. Convert numeric columns safely
# ----------------
df <- df %>%
  mutate(
    age = as.numeric(age),
    weight_kg = as.numeric(weight_kg),
    height_m = as.numeric(height_m)
  )

# ----------------
# 7. Convert character columns to factor
# ----------------
df <- df %>%
  mutate(across(where(is.character), as.factor))

# ----------------
# 8. Export cleaned dataset
# ----------------
export(df, "menstruation_clean.csv")
export(df, "menstruation_clean.xlsx")

# ----------------
# 9. Optional: convert meter → feet/inches for reporting
# ----------------
to_feet_inch <- function(m){
  if(is.na(m)) return(NA)
  
  total_inches <- m / 0.0254
  feet <- floor(total_inches / 12)
  inches <- round(total_inches %% 12)
  
  paste0(feet, "'", inches, "\"")
}

df$height_ft_in <- sapply(df$height_m, to_feet_inch)

# ----------------
# 10. Structure check
# ----------------
str(df)
summary(df)