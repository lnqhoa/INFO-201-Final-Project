# install.packages("rio")
# install.packages("xlsx")
# install.packages("data.table")

library(rio)
library(xlsx)
library(dplyr)
library(data.table)

# Setting up Working Directory:
# Hoa - 
setwd("C:/Users/HoaLe's/Desktop/INFO-201-Final-Project")

# Read in original dataset:
og_df <- import("./data/FoodAccess_DataUSDA.xlsx")

# Subsetting dataset:
sub_df <- og_df %>%
  # Only keep observations from Washington [state]
  filter(State == "WA") %>%
  # Select desired columns
  select(
    CensusTract, County, GroupQuartersFlag, HUNVFlag,
    LA1and10, LA1and20, lahunv1, lahunv10, lahunv20,
    lakids1, lakids10, lakids20, lalowi1, lalowi10, lalowi20,
    lapop1, lapop10, lapop20, laseniors1, laseniors10, laseniors20,
    LATracts1, LATracts10, LATracts20, LILATracts_Vehicle, 
    LowIncomeTracts, OHU2010, POP2010, Rural, State, Urban
    )

# Rename variables according to category (check Data Dictionary!):
sub_df <- sub_df %>%
  rename( 
    'id_census' = CensusTract, 'id_county' = County, 'id_group' = GroupQuartersFlag,
    'id_vehacc' = HUNVFlag, 'acc_ur_1to10' = LA1and10, 'acc_ur_1to20' = LA1and20,
    'id_rural' = Rural, 'id_state' = State, 'id_urban' = Urban,
    'nbh_acc1' = lahunv1, 'nbh_acc10' = lahunv10, 'nbh_acc20' = lahunv20,
    'idv_child1' = lakids1, 'idv_child10' = lakids10, 'idv_child20' = lakids20,
    'idv_income1' = lalowi1, 'idv_income10' = lalowi10, 'idv_income20' = lalowi20,
    'acc_store1' = lapop1, 'acc_store10' = lapop10, 'acc_store20' = lapop20,
    'idv_senior1' = laseniors1, 'idv_senior10' = laseniors10, 'idv_senior20' = laseniors20,
    'acc_tract1' = LATracts1, 'acc_tract10' = LATracts10, 'acc_tract20' = LATracts20,
    'idv_inc_acc' = LILATracts_Vehicle, 'nbh_income' = LowIncomeTracts,
    'id_totalhousing' = OHU2010, 'id_totalpop' = POP2010)

# Reorganize positions of Columns according to category (check Data Dictionary!):
sub_df <- sub_df[,c(
  1, 2, 30, 29, 31, 28, 27, 3, 4, 5, 6, 22, 23, 24, 16, 17,
  18, 13, 14, 15, 25, 10, 11, 12, 19, 20, 21, 26, 7, 8, 9
)]

# Export data subset: 
export(sub_df, "./data/foodaccess_sub.xlsx")
