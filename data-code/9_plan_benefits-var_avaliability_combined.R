#' Combine availability of variables for all years and to show a whole picture
#' 
#' 

# Preliminaries -----------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, tidyverse, data.table, readr)

## function
source("data-code/fn_plan_benefits_var_avaliability.R")

## Variables to change when new data comes in
start_year = 2008
end_year = 2019
end_q = 2

## Append all the data together 

## Folder list
pre2017_folder_list <- paste0("PBP-Benefits-", start_year:2017) #Until 2017, yearly file
pos2017_folder_list <- do.call(paste0, 
                               arrange_all(
                                 expand.grid(paste0("PBP-Benefits-",2018:end_year),
                                             paste0("-Q", seq(1:4)))
                               )
)  #Since 2018, quarterly file
folder_list <- c(pre2017_folder_list, pos2017_folder_list)

if (end_q != 4){
  folder_list <- head(folder_list, -(4-end_q))  #Adjust for latest available data
}


## combine all the data 
for (i in folder_list){
  print(paste(i,"is being processed ..."))
  if(i == folder_list[1]){
    ava_df = planb.var(i, step_up = FALSE)
  } else {
    col_yr = planb.var(i, step_up = FALSE)
    ava_df = ava_df %>% full_join(col_yr, by = "var_list")
  }
}

ava_df = ava_df %>%
  mutate(percentage = round(rowSums(.[-1], na.rm = TRUE)/(ncol(.)-1),3))

## Exporting the result
write_tsv(ava_df,
          file="data/data-out/ma-data/plan-benefits/planb.var_ava.tsv")



