
# Import data -------------------------------------------------------------

ma.data <- read_csv("data/input/ma/landscape/Extracted Data/CY2024_Landscape_MA_20240723.csv",
                    skip=1,
                    col_names=c("state","county","org_name","plan_name","plan_type","premium","partd_deductible",
                                "drug_type","gap_coverage","drug_type_detail","contractid",
                                "planid","segmentid","moop","star_rating"),
                    col_types = cols(.default = col_character(),
                                     planid = col_double(),
                                     segmentid = col_double())) %>%
  mutate(across(c(premium, partd_deductible), ~parse_number(.)))


mapd.data <- read_csv("data/input/ma/landscape/Extracted Data/PartCD/2024/CY2024_Plan_Premium_Report_20240723.csv",
                      skip=1,
                      col_names=c("state","county","org_name","org_type","plan_name","plan_type","snp","snp_type",
                                  "benefit_type","contractid","planid","segmentid","national_pdp","below_benchmark",
                                  "premium_partc","premium_partd_basic","premium_partd_supp","premium_partd_total",
                                  "partd_assist_full","partd_deductible","deductible_exclusions",
                                  "increase_coverage_limit","gap_coverage","star_partc","star_partd","star_overall"),
                      col_types = cols(.default = col_character())) %>%
  mutate(across(c(premium_partc, premium_partd_basic, premium_partd_supp, premium_partd_total, partd_deductible),
                ~parse_number(str_replace_all(., "[(]", "-") %>% str_replace_all("[)]", ""))))

final.landscape <- mapd.clean.merge(ma.data=ma.data, mapd.data=mapd.data, y)
