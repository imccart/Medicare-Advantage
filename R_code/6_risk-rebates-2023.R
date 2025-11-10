
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/ma/cms-payment/2023/2023PartCPlanLevel.xlsx"
risk.rebate.a <- read_xlsx(ma.path.a,range="A4:G5495",sheet="result.html",
                        col_names=c("contractid","planid","contract_name","plan_type",
                                    "riskscore_partc","payment_partc","rebate_partc"))
ma.path.b <- "data/input/ma/cms-payment/2023/2023PartDPlans.xlsx"
risk.rebate.b <- read_xlsx(ma.path.b,range="A4:H6190",sheet="result.html",
                        col_names=c("contractid","planid","contract_name","plan_type",
                                    "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                    "costsharing_partd"))


risk.rebate.a <- risk.rebate.a %>%
  mutate(
    across(c(riskscore_partc, payment_partc, rebate_partc),
           ~ parse_number(as.character(.))),
    planid = as.numeric(planid),
    year   = 2023
  ) %>%
  select(contractid, planid, contract_name, plan_type,
         riskscore_partc, payment_partc, rebate_partc, year)    

risk.rebate.b <- risk.rebate.b %>%
  mutate(
    across(c(directsubsidy_partd, reinsurance_partd, costsharing_partd),
           ~ parse_number(as.character(.))),
    payment_partd = directsubsidy_partd + reinsurance_partd + costsharing_partd,
    planid        = as.numeric(planid)
  ) %>%
  select(contractid, planid, payment_partd,
         directsubsidy_partd, reinsurance_partd, costsharing_partd,
         riskscore_partd)  
  
final.risk.rebate <- risk.rebate.a %>%
  left_join(risk.rebate.b, by=c("contractid","planid"))