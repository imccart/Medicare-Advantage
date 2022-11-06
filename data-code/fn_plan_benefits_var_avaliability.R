#' Show the availability of variables within one year
#' @param folder_name  name of the zip-folder on plan benefit info 
#'                     (e.g. "PBP-Benefits-2001")
#' @param step_up perform the function on step up info (step_up = TRUE) or
#'                non step up info (step_up = FALSE)
#'                

planb.var <- function(folder_name, step_up = FALSE){
  
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
  
  ## Separate for step-up and non step up (and also dropping vbid files)
  if (step_up == FALSE){
    txt_list <- txt_list[!grepl("step",txt_list) & !grepl("vbid",txt_list)]
  } else {
    txt_list <- txt_list[grepl("step",txt_list)]
  }
  
  var_list = c()
  
  for (i in txt_list){
    df <- read.table(paste0(unzip_out_data.path, 
                            paste0("/", i)),
                     header = TRUE, fill = TRUE, 
                     colClasses=c("character"),
                     check.names = FALSE,
                     sep = '\t', quote = "")
    
    df <-  df[,nzchar(colnames(df))] #redundant cols (empty column names)(see "pbp_b1_inpat_hosp_df")
    
    if ("version" %in% colnames(df)){
      df = df %>%
        select(-c("version"))
    } #Drop the version number variable
    
    df <- df%>% 
      discard(~all(is.na(.) | . =="")) #Drop columns which are all NA
    
    var_list = var_list %>% 
      append(colnames(df)) %>%
      unique()
    
    rm(df)
    
  }
  
  var_list_col = data.frame(var_list)
  var_list_col[folder_name] = 1
  
  return(var_list_col)

}
