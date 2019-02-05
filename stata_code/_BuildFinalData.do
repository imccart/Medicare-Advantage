*************************************************************************
** First set all data paths
*************************************************************************
global LOGS "C:\..." ## Folder to save log files
global DATA_FINAL "C:\..." ## Folder to save intermediate and final datasets created within the code
global STATA_CODE "C:\..." ## Location of code files
global DATA_MA "C:\..."  ## Raw MA data files
global DATA_FFS "C:\..." ## Raw Medicare FFS data files



*************************************************************************
** Initiate log file to save all runs of the do files
*************************************************************************
set more off




*************************************************************************
** Set local "month lists" to identify different files relevant for each year
/* Month lists differ by year just in case you work with data that are only available
   in a fraction of a year, which often happens for new data as new monthly releases
   are made */
*************************************************************************
loc monthlist_2006 "10 11 12"
loc monthlist_2007 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2008 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2009 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2010 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2011 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2012 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2013 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2014 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2015 "01 02 03 04 05 06 07 08 09 10 11 12"



*************************************************************************
** -Build plan-level dataset
*************************************************************************
do "${STATA_CODE}1_Plan_Data.do"
do "${STATA_CODE}2_Plan_Characteristics.do"
do "${STATA_CODE}3_Service_Areas.do"
do "${STATA_CODE}4_Penetration_Files.do"
do "${STATA_CODE}5_Star_Ratings.do"
do "${STATA_CODE}6_Risk_Rebates.do"
do "${STATA_CODE}8_MA_Benchmark.do"
do "${STATA_CODE}9_FFS_Costs.do"