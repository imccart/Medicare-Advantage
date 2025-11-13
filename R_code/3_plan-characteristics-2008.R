
# Import data -------------------------------------------------------------

ma.path.a <- paste0("data/input/ma/landscape/Extracted Data/2008LandscapeSourceData_MA_09_25_07(A-M).csv")
ma.data.a <- read_csv(ma.path.a,
                       skip=5,
                       col_names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                   "planid","segmentid"),
                       col_types = cols(
                         state = col_character(),
                         county = col_character(),
                         org_name = col_character(),
                         plan_name = col_character(),
                         plan_type = col_character(),
                         premium = col_number(),
                         partd_deductible = col_number(),
                         drug_type = col_character(),
                         gap_coverage = col_character(),
                         drug_type_detail = col_character(),
                         demo_type = col_character(),
                         contractid = col_character(),
                         planid = col_double(),
                         segmentid = col_double()
                       ))


ma.path.b <- paste0("data/input/ma/landscape/Extracted Data/2008LandscapeSourceData_MA_09_25_07(N-W).csv")
ma.data.b <- read_csv(ma.path.b,
                       skip=5,
                       col_names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                   "drug_type","gap_coverage","drug_type_detail","demo_type","contractid",
                                   "planid","segmentid"),
                       col_types = cols(
                         state = col_character(),
                         county = col_character(),
                         org_name = col_character(),
                         plan_name = col_character(),
                         plan_type = col_character(),
                         premium = col_number(),
                         partd_deductible = col_number(),
                         drug_type = col_character(),
                         gap_coverage = col_character(),
                         drug_type_detail = col_character(),
                         demo_type = col_character(),
                         contractid = col_character(),
                         planid = col_double(),
                         segmentid = col_double()
                       ))


ma.data <- rbind(ma.data.a,ma.data.b)


mapd.path.a <- paste0("data/input/ma/landscape/Extracted Data/PartCD/2008/Medicare Part D 2008 Plan Report 11-06-07.xls")
mapd.data.a <- read_xls(mapd.path.a,
                         range="A5:AC39471",
                         sheet="Alabama to Montana",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "partd_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))

mapd.path.b <- paste0("data/input/ma/landscape/Extracted Data/PartCD/2008/Medicare Part D 2008 Plan Report 11-06-07.xls")
mapd.data.b <- read_xls(mapd.path.b,
                         range="A5:AC44708",
                         sheet="Nebraska to Wyoming",
                         col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                     "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                     "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                                     "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                     "partd_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                                     "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))

mapd.data <- rbind(mapd.data.a,mapd.data.b)

final.landscape <- mapd.clean.merge(ma.data=ma.data, mapd.data=mapd.data, y)

