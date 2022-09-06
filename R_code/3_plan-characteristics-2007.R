
# Import data -------------------------------------------------------------

ma.path <- paste0("data/input/landscape/Extracted Data/2007 MA Landscape Source File 11-16-06.csv")
ma.data <- read_csv(ma.path,
                 skip=4,
                 col_names=c("state","county","org_name","plan_name","plan_type","premium","drug_premium","partd_deductible",
                             "drug_type","gap_coverage","variable_drug_copay","drug_type_detail","demo_type","contractid",
                             "planid","segmentid"),
                 col_types = cols(
                   state = col_character(),
                   county = col_character(),
                   org_name = col_character(),
                   plan_name = col_character(),
                   plan_type = col_character(),
                   premium = col_number(),
                   drug_premium = col_number(),
                   partd_deductible = col_number(),
                   drug_type = col_character(),
                   gap_coverage = col_character(),
                   variable_drug_copay = col_character(),
                   drug_type_detail = col_character(),
                   demo_type = col_character(),
                   contractid = col_character(),
                   planid = col_double(),
                   segmentid = col_double()
                 ))

mapd.path <- paste0("data/input/landscape/Extracted Data/PartCD/2007/Medicare Part D 2007 Plan Report 12-06-06.xls")
mapd.data <- read_xls(mapd.path,
                   range="A5:AC49252",
                   col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                               "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                               "national_pdp","partd_rein_demo","partd_rein_demo_type","premium_partc",
                               "premium_partd_basic","premium_partd_supp","premium_partd_total",
                               "partd_assist_full","nothing","partd_assist_75","partd_assist_50","partd_assist_25",
                               "partd_deductible","increase_coverage_limit","gap_coverage","gap_coverage_type"))

plan.premiums <- mapd.clean.merge(ma.data=ma.data, mapd.data=mapd.data)

