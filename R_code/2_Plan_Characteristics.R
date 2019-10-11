#########################################################################
## Read and clean data basic premium and deductible information
#########################################################################  

## Raw 2007 data
ma.path.2007=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2007 MA Landscape Source File 11-16-06.csv",sep="")
ma.data.2007=read.csv(ma.path.2007,skip=4,stringsAsFactors=FALSE,col.names=c("state","county","org_name","plan_name","plan_type","premium","drug_premium","partd_deductible",
                                                                          "drug_type","gap_coverage","variable_drug_copay","drug_type_detail","demo_type","contractid",
                                                                          "planid","segmentid"))

macd.path.2007=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2007\\Medicare Part D 2007 Plan Report 12-06-06.xls",sep="")
macd.data.2007=read_xls(macd.path.2007,range="A5:AC49252",col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                                                   "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                                                   "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                                                   "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                                                   "pard_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                                                                   "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))



## Raw 2008 data
ma.path.2008a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2008LandscapeSourceData_MA_09_25_07(A-M).csv",sep="")
ma.data.2008a=read.csv(ma.path.2008a,skip=5,stringsAsFactors=FALSE,col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                                                        "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                                                        "planid","segmentid"))

ma.path.2008b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2008LandscapeSourceData_MA_09_25_07(N-W).csv",sep="")
ma.data.2008b=read.csv(ma.path.2008b,skip=5,stringsAsFactors=FALSE,col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                                                               "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                                                               "planid","segmentid"))

ma.data.2008 = rbind(ma.data.2008a,ma.data.2008b)


macd.path.2008a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2008\\Medicare Part D 2008 Plan Report 11-06-07.xls",sep="")
macd.data.2008a=read_xls(macd.path.2008a,range="A5:AC39471",sheet="Alabama to Montana",col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                                                 "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                                                 "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                                                 "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                                                 "pard_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                                                                 "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))

macd.path.2008b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2008\\Medicare Part D 2008 Plan Report 11-06-07.xls",sep="")
macd.data.2008b=read_xls(macd.path.2008b,range="A5:AC44708",sheet="Nebraska to Wyoming",col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                                                                                   "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                                                                                   "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                                                                                   "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                                                                                   "pard_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                                                                                                   "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))

macd.data.2008 = rbind(macd.data.2008a,macd.data.2008b)



## Raw 2009 data
ma.path.2009a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2009LandscapeSourceData_MA_11_05_08_A_to_M.csv",sep="")
ma.data.2009a=read.csv(ma.path.2009a,skip=5,stringsAsFactors=FALSE,col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                                                               "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                                                               "planid","segmentid"))

ma.path.2009b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2009LandscapeSourceData_MA_11_05_08_N_to_W.csv",sep="")
ma.data.2009b=read.csv(ma.path.2009b,skip=5,stringsAsFactors=FALSE,col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                                                               "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                                                               "planid","segmentid"))
ma.data.2009 = rbind(ma.data.2009a,ma.data.2009b)


macd.path.2009a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2009\\Medicare Part D 2009 Plan Report 11-03-08.xls",sep="")
macd.data.2009a=read_xls(macd.path.2009a,range="A5:AB33304",sheet="Alabama to Montana",col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                                                                                   "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                                                                                   "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                                                                                   "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                                                                                   "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                                                                                   "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))


macd.path.2009b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2009\\Medicare Part D 2009 Plan Report 11-03-08.xls",sep="")
macd.data.2009b=read_xls(macd.path.2009b,range="A5:AB40219",sheet="Nebraska to Wyoming",col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                                                                                    "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                                                                                    "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                                                                                    "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                                                                                    "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                                                                                    "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))
macd.data.2009 = rbind(macd.data.2009a,macd.data.2009b)




## Raw 2010 data
ma.path.2010a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2010LandscapeSourceData_MA_12_01_09_A_to_M.csv",sep="")
ma.data.2010a=read.csv(ma.path.2010a,skip=5,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                   "planid","segmentid","moop"))


ma.path.2010b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2010LandscapeSourceData_MA_12_01_09_N_to_W.csv",sep="")
ma.data.2010b=read.csv(ma.path.2010b,skip=5,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                   "planid","segmentid","moop"))
ma.data.2010 = rbind(ma.data.2010a,ma.data.2010b)


macd.path.2010a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2010\\Medicare Part D 2010 Plan Report 09-14-09.xls",sep="")
macd.data.2010a=read_xls(macd.path.2010a,range="A5:AC26372",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))

macd.path.2010b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2010\\Medicare Part D 2010 Plan Report 09-14-09.xls",sep="")
macd.data.2010b=read_xls(macd.path.2010b,range="A5:AC31073",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))
macd.data.2010 = rbind(macd.data.2010a,macd.data.2010b)




## Raw 2011 data
ma.path.2011a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2011LandscapeSourceData_MA_12_17_10_AtoM.csv",sep="")
ma.data.2011a=read.csv(ma.path.2011a,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","free_preventive_care"))

ma.path.2011b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2011LandscapeSourceData_MA_12_17_10_NtoW.csv",sep="")
ma.data.2011b=read.csv(ma.path.2011b,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","free_preventive_care"))
ma.data.2011 = rbind(ma.data.2011a,ma.data.2011b)


macd.path.2011a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2011\\Medicare Part D 2011 Plan Report 09-15-10.xls",sep="")
macd.data.2011a=read_xls(macd.path.2011a,range="A5:AA18105",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))

macd.path.2011b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2011\\Medicare Part D 2011 Plan Report 09-15-10.xls",sep="")
macd.data.2011b=read_xls(macd.path.2011b,range="A5:AA20402",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))
macd.data.2011 = rbind(macd.data.2011a,macd.data.2011b)





## Raw 2012 data
ma.path.2012a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2012LandscapeSourceData_MA_3_08_12_AtoM.csv",sep="")
ma.data.2012a=read.csv(ma.path.2012a,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))


ma.path.2012b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2012LandscapeSourceData_MA_3_08_12_NtoW.csv",sep="")
ma.data.2012b=read.csv(ma.path.2012b,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))
ma.data.2012 = rbind(ma.data.2012a,ma.data.2012b)


macd.path.2012a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2012\\Medicare Part D 2012 Plan Report 09-08-11.xls",sep="")
macd.data.2012a=read_xls(macd.path.2012a,range="A5:AA18521",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))

macd.path.2012b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2012\\Medicare Part D 2012 Plan Report 09-08-11.xls",sep="")
macd.data.2012b=read_xls(macd.path.2012b,range="A5:AA21182",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))
macd.data.2012 = rbind(macd.data.2012a,macd.data.2012b)




## Raw 2013 data
ma.path.2013a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2013LandscapeSource file MA_AtoM 11212012.csv",sep="")
ma.data.2013a=read.csv(ma.path.2013a,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))

ma.path.2013b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2013LandscapeSource file MA_NtoW 11212012.csv",sep="")
ma.data.2013b=read.csv(ma.path.2013b,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))
ma.data.2013 = rbind(ma.data.2013a,ma.data.2013b)


macd.path.2013a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2013\\Medicare Part D 2013 Plan Report 04252013v1.xls",sep="")
macd.data.2013a=read_xls(macd.path.2013a,range="A5:AA20940",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))

macd.path.2013b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2013\\Medicare Part D 2013 Plan Report 04252013v1.xls",sep="")
macd.data.2013b=read_xls(macd.path.2013b,range="A5:AA23812",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))
macd.data.2013 = rbind(macd.data.2013a,macd.data.2013b)



## Raw 2014 data
ma.path.2014a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2014LandscapeSource file MA_AtoM 05292014.csv",sep="")
ma.data.2014a=read.csv(ma.path.2014a,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))

ma.path.2014b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2014LandscapeSource file MA_NtoW 05292014.csv",sep="")
ma.data.2014b=read.csv(ma.path.2014b,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))
ma.data.2014 = rbind(ma.data.2014a,ma.data.2014b)


macd.path.2014a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2014\\Medicare Part D 2014 Plan Report 05292014.xls",sep="")
macd.data.2014a=read_xls(macd.path.2014a,range="A5:AA15859",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))

macd.path.2014b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2014\\Medicare Part D 2014 Plan Report 05292014.xls",sep="")
macd.data.2014b=read_xls(macd.path.2014b,range="A5:AA20305",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage","gap_coverage_type"))
macd.data.2014 = rbind(macd.data.2014a,macd.data.2014b)



## Raw 2015 data
ma.path.2015a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2015LandscapeSource file MA_AtoM 11042014.csv",sep="")
ma.data.2015a=read.csv(ma.path.2015a,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))

ma.path.2015b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\2015LandscapeSource file MA_NtoW 11042014.csv",sep="")
ma.data.2015b=read.csv(ma.path.2015b,skip=6,stringsAsFactors=FALSE,
                       col.names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","contractid",
                                   "planid","segmentid","moop","star_rating"))
ma.data.2015 = rbind(ma.data.2015a,ma.data.2015b)


macd.path.2015a=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2015\\Medicare Part D 2015 Plan Report 03182015.xls",sep="")
macd.data.2015a=read_xls(macd.path.2015a,range="A5:Z16666",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage"))

macd.path.2015b=paste(path.data.ma,"\\MA Plan Characteristics\\Extracted Data\\PartCD\\2015\\Medicare Part D 2015 Plan Report 03182015.xls",sep="")
macd.data.2015b=read_xls(macd.path.2015b,range="A5:Z17038",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "pard_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                     "gap_coverage"))
macd.data.2015 = rbind(macd.data.2015a,macd.data.2015b)


for (y in 2007:2015) {

  ############ CLEAN MA-Only Data #####################
  ma.data=get(paste("ma.data.",y,sep=""))
  ma.data = ma.data %>%
    mutate(planid=as.numeric(planid)) %>%
    select(contractid, planid, state, county, premium)

  ## Remove dollar signs and assign as numeric variables
  ma.data = ma.data %>%
    mutate(premium=as.numeric(str_replace_all(premium,'\\$','')))

  ## Fill in missing plan info (by contract, plan, state, and county)
  ma.data = ma.data %>%
    group_by(contractid, planid, state, county) %>%
    fill(premium)

  ## Remove duplicates
  ma.data = ma.data %>%
    group_by(contractid, planid, state, county) %>%
    mutate(id_count=row_number())
  
  ma.data = ma.data %>%
    filter(id_count==1) %>%
    select(-id_count)

    
  ############ CLEAN MA-PD Data #####################
  macd.data=get(paste("macd.data.",y,sep=""))
  macd.data = macd.data %>% 
    mutate(planid=as.numeric(planid)) %>%
    select(contractid, planid, state, county, premium_partc, premium_partd_basic, 
           premium_partd_supp, premium_partd_total, partd_deductible)
  
  macd.data = macd.data %>%
    group_by(contractid, planid, state, county) %>%
    fill(premium_partc, premium_partd_basic, premium_partd_supp, premium_partd_total, partd_deductible)
  
  ## Remove duplicates
  macd.data = macd.data %>%
    group_by(contractid, planid, state, county) %>%
    mutate(id_count=row_number())
  
  macd.data = macd.data %>%
    filter(id_count==1) %>%
    select(-id_count)

  ## Merge Part D info to Part C info
  ma.macd.data = ma.data %>%
    left_join(macd.data, by=c("contractid", "planid", "state", "county")) %>%
    mutate(year=y)
  
  if (y==2007) {
    plan.premiums=ma.macd.data
  } else {
    plan.premiums=rbind(plan.premiums,ma.macd.data)
  }
  
  
}

write_tsv(plan.premiums,path=paste(path.data.final,"\\Plan_Premiums.txt",sep=""),append=FALSE,col_names=TRUE)
write_rds(plan.premiums,paste(path.data.final,"\\plan_premiums.rds",sep=""))