
# Import data -------------------------------------------------------------

ma.path.a="data/input/cms-payment/2007/2007PartCPlanLevel2.xlsx"
risk.rebate.a=read_xlsx(ma.path.a,range="A4:H2572",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))
ma.path.b="data/input/cms-payment/2007/2007PartDPlans2.xlsx"
risk.rebate.b=read_xlsx(ma.path.b,range="A4:H4066",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))

risk.rebate.a=risk.rebate.a %>%
  mutate_at(vars(c("riskscore_partc","payment_partc","rebate_partc")),
            ~as.numeric(str_replace_all(.,'/$',''))) %>%
  mutate(planid=as.numeric(planid), year=y) %>%
  select(contractid, planid, contract_name, plan_type, riskscore_partc,
         payment_partc, rebate_partc, year)
    

risk.rebate.b=risk.rebate.b %>%
  mutate(payment_partd=directsubsidy_partd + reinsurance_partd + costsharing_partd) %>%
  mutate(planid=as.numeric(planid)) %>%
  select(contractid, planid, payment_partd, directsubsidy_partd, reinsurance_partd, costsharing_partd,
         riskscore_partd)
  
final.risk.rebate = risk.rebate.a %>%
  left_join(risk.rebate.b, by=c("contractid","planid"))

  