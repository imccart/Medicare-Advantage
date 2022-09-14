library(readxl)
library(dplyr)
library(hablar)

# Import data -------------------------------------------------------------
file_name <- "PBP-Benefits-2001"

data_in.path <- paste0("data/data-in/ma-data/plan-benefits/", file_name, ".zip")
out_data.path <- "data/data-out"
unzip_out_data.path <- paste0(out_data.path, "/ma-data/plan-benefits/unzip_raw/",
                              file_name)

## Unzip the data
unzip(data_in.path, exdir=unzip_out_data.path)
  
## List of all txt files
txt_list <- list.files(path=unzip_out_data.path, pattern="*.txt")
txt_list <- txt_list[!grepl("Readme",txt_list)] #Drop ReadMe

## Load dictionary of the dataset for information on variable types
## file of the data/ name of the variable/ variable type
var_dict <- na.omit(read_excel(paste0(unzip_out_data.path, 
                                      "/pbp2001_dictionary.xls"),
                    range = cell_cols("A:C")))
var_dict$NAME <- toupper(var_dict$NAME)  # Change to upper case to match

## Loop through all files to do the type conversion
for (i in txt_list){
  print(i)
  df <- read.table(paste0(unzip_out_data.path, 
                               paste0("/", i)), 
                               header = TRUE, fill = TRUE, 
                               colClasses=c("character"),
                               check.names = FALSE,
                               sep = '\t', quote = "")
  
  df <-  df[,nzchar(colnames(df))] #redundant cols(eg "pbp_b1_inpat_hosp_df") 

  name <- gsub("\\..*","",i)
  var_dict_temp <- var_dict[var_dict$FILE == name, ]
  var_dict_temp <- split(var_dict_temp, var_dict_temp$TYPE)
 
  df <- convert(df, num(var_dict_temp$NUM$NAME)) 
  #Others are characters (default when import)
  
  df_name <- paste0(name, "_df")
  assign(df_name, df)
}

