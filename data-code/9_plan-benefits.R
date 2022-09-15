#' Combine information from all years and export to separate tsv files

# Preliminaries -----------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, dplyr, hablar, purrr, data.table, readr)

## function
source("data-code/fn_plan_benefits.R")

## Variables to change when new data comes in
end_year = 2019
end_q = 2

## Append all the data together 

#Folder list
pre2017_folder_list <- paste0("PBP-Benefits-", 2001:2017) #Until 2017, yearly file
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

#combine all the data 
for (i in folder_list){
  print(paste(i,"is being processed ..."))
  assign(i, planb.merge(i))
}

folder_list_df = mget(folder_list)

planb.combined = rbindlist(folder_list_df, fill = TRUE) #rbindlist deal with dtype conflicts

write_tsv(planb.combined,
                    file="data/data-out/ma-data/plan-benefits/planb.combined.tsv")

for (i in folder_list){
  print(paste(i,"is exporting ..."))
  temp_out = planb.combined[planb.combined$folder_source == i]
  write_tsv(temp_out,
            file=paste0("data/data-out/ma-data/plan-benefits/",paste0(i,".tsv")))
}
