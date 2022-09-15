#' Import and merge files on plan benefits per year

#' @param folder_name  name of the zip-folder on plan benefit info 
#'                     (e.g. "PBP-Benefits-2001")

planb.merge <- function(folder_name){
  
  # Import data -------------------------------------------------------------
  
  data_in.path <- paste0("data/data-in/ma-data/plan-benefits/", folder_name, ".zip")
  out_data.path <- "data/data-out"
  unzip_out_data.path <- paste0(out_data.path, "/ma-data/plan-benefits/unzip_raw/",
                                folder_name)
  
  ## Unzip the data
  unzip(data_in.path, exdir=unzip_out_data.path)
  
  ## List of all txt files
  txt_list <- list.files(path=unzip_out_data.path, pattern="*.txt")
  txt_list <- txt_list[!grepl("Readme",txt_list)] #Drop ReadMe
  
  ## Load dictionary of the dataset for information on variable types
  ## file of the data/ name of the variable/ variable type
  var_dict <- na.omit(read_excel(paste0(unzip_out_data.path,
                                        paste0("/",list.files(path=unzip_out_data.path,
                                                              pattern="dictionary"))),
                                 range = cell_cols("A:C")))
  
  if ( folder_name %in% paste0("PBP-Benefits-", 2001:2005)){
    var_dict$NAME <- toupper(var_dict$NAME)  # Change to upper case to match
  } else if ( folder_name == "PBP-Benefits-2006" ) {  # (practice until 2005)
    var_dict[var_dict$FILE == "pbp_b9_outpt_hosp",]$FILE <- "pbp_b9_outpat_hosp"
  }
  
  
  #Extra variable recorded in dictionary of 2003/2004
  if(folder_name == "PBP-Benefits-2003"){
    var_dict = var_dict[var_dict$NAME != "PBP_D_PARTB_REDUCT_AMT_CALC",]
  }
  if(folder_name == "PBP-Benefits-2004"){
    var_dict = var_dict[var_dict$NAME != "PBP_D_AMT_OPT_PREMIUM",]
  }
  
  ## Loop through all files to do the type conversion
  
  #Abnormal case when extension is included in filename in dict
  abnormal_case_dict = c("PlanArea.txt", "PlanRegionArea.txt")
  
  for (i in txt_list){
    df <- read.table(paste0(unzip_out_data.path, 
                            paste0("/", i)),
                     header = TRUE, fill = TRUE, 
                     colClasses=c("character"),
                     check.names = FALSE,
                     sep = '\t', quote = "")
    
    df <-  df[,nzchar(colnames(df))] #redundant cols(see "pbp_b1_inpat_hosp_df") 
    
    if (!(i %in% abnormal_case_dict)){
      name <- gsub(".txt","",i) #Get rid of the extension (.txt)
    } else if (i == "PlanArea.txt") { 
      name <- "planArea.txt"
    } else if(i == "PlanRegionArea.txt"){
      name <- "planRegionArea.txt"        #Dict recorded abnormal case
    }
    
    #Typo recorded in dictionary of 2006
    var_dict_temp <- var_dict[var_dict$FILE == name, ]
    var_dict_temp <- split(var_dict_temp, var_dict_temp$TYPE)
    
    df <- convert(df, num(var_dict_temp$NUM$NAME))
    #Others are characters (default when import)
    
    if (!(i %in% abnormal_case_dict)){
      df_name <- paste0(name, "_df")
    }else {
      df_name <- paste0(gsub(".txt","",i),"_df")
    }
    
    assign(df_name, df)}
  
  ## Merging all the dataframes
  df_list <- gsub(".txt","_df",txt_list) #Name of all dataframe
  #Find the common variables in all files for merging:
  common_cols <- df_list %>%
    map(~ eval(parse(text = .x)) %>%
          names()) %>%
    reduce(~ intersect(.x, .y))
  
  final.planb <- Reduce(function(x, y) left_join(x, y, by=common_cols,
                                                 suffix = c("_original", "_new")), 
                        lapply(df_list,function(j) eval(parse(text=j))))
  
  final.planb$folder_source = folder_name
  
  return(final.planb)

}