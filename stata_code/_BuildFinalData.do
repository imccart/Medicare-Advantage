** First set all data paths
global LOGS "C:\..." ## Folder to save log files
global DATA_FINAL "C:\..." ## Folder to save intermediate and final datasets created within the code
global STATA_CODE "C:\..." ## Location of code files
global DATA_MA "C:\..."  ## Raw MA data files
global DATA_FFS "C:\..." ## Raw Medicare FFS data files

** Initiate log file to save all runs of the do files
set more off

** -Build plan-level dataset
do "${STATA_CODE}1_Plan_Data.do"
do "${STATA_CODE}2_Plan_Characteristics.do"
do "${STATA_CODE}3_Service_Areas.do"
do "${STATA_CODE}4_Penetration_Files.do"
do "${STATA_CODE}5_Star_Ratings.do"
do "${STATA_CODE}6_Risk_Rebates.do"
do "${STATA_CODE}8_MA_Benchmark.do"
do "${STATA_CODE}9_FFS_Costs.do"