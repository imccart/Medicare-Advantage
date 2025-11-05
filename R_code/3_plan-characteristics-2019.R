
# Import data -------------------------------------------------------------

ma.path.a <- paste0("data/input/ma/landscape/Extracted Data/2019LandscapeSource file MA_AtoM 10122018.csv")
ma.data.a <- read_csv(ma.path.a,
                      skip=6,
                      col_names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                  "drug_type","gap_coverage","drug_type_detail","contractid",
                                  "planid","segmentid","moop","star_rating"),
                      col_types = cols(
                        state = col_character(),
                        county = col_character(),
                        org_name = col_character(),
                        plan_name = col_character(),
                        plan_type = col_character(),
                        premium = col_character(),
                        partd_deductible = col_character(),
                        drug_type = col_character(),
                        gap_coverage = col_character(),
                        drug_type_detail = col_character(),
                        contractid = col_character(),
                        planid = col_double(),
                        segmentid = col_double(),
                        moop = col_character(),
                        star_rating = col_character()
                      )) %>%
  mutate_at(c('premium','partd_deductible'), ~str_replace(.,"-","0")) %>%
  mutate_at(c('premium','partd_deductible'), ~parse_number(.))
  


ma.path.b <- paste0("data/input/ma/landscape/Extracted Data/2019LandscapeSource file MA_NtoW 10122018.csv")
ma.data.b <- read_csv(ma.path.b,
                      skip=6,
                      col_names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                  "drug_type","gap_coverage","drug_type_detail","contractid",
                                  "planid","segmentid","moop","star_rating"),
                      col_types = cols(
                        state = col_character(),
                        county = col_character(),
                        org_name = col_character(),
                        plan_name = col_character(),
                        plan_type = col_character(),
                        premium = col_character(),
                        partd_deductible = col_character(),
                        drug_type = col_character(),
                        gap_coverage = col_character(),
                        drug_type_detail = col_character(),
                        contractid = col_character(),
                        planid = col_double(),
                        segmentid = col_double(),
                        moop = col_character(),
                        star_rating = col_character()
                      )) %>%
  mutate_at(c('premium','partd_deductible'), ~str_replace(.,"-","0")) %>%
  mutate_at(c('premium','partd_deductible'), ~parse_number(.))


ma.data <- rbind(ma.data.a,ma.data.b)


mapd.path.a <- paste0("data/input/ma/landscape/Extracted Data/PartCD/2019/Medicare Part D 2019 Plan Report 10012018.xls")
mapd.data.a <- read_xls(mapd.path.a,
                        range="A5:Z22233",
                        sheet="Alabama to Montana",
                        col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                    "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                    "national_pdp","premium_partc",
                                    "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                    "partd_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                    "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                    "gap_coverage"))



mapd.path.b <- paste0("data/input/ma/landscape/Extracted Data/PartCD/2019/Medicare Part D 2019 Plan Report 10012018.xls")
mapd.data.b <- read_xls(mapd.path.b,
                        range="A5:Z27124",
                        sheet="Nebraska to Wyoming",
                        col_names=c("state","county","org_name","plan_name","contractid","planid","segmentid",
                                    "org_type","plan_type","snp","snp_type","benefit_type","below_benchmark",
                                    "national_pdp","premium_partc",
                                    "premium_partd_basic","premium_partd_supp","premium_partd_total",
                                    "partd_assist_full","partd_assist_75","partd_assist_50","partd_assist_25",
                                    "partd_deductible","deductible_exclusions","increase_coverage_limit",
                                    "gap_coverage"))
mapd.data <- rbind(mapd.data.a,mapd.data.b)

final.landscape <- mapd.clean.merge(ma.data=ma.data, mapd.data=mapd.data)

