
# Import data -------------------------------------------------------------

ma.path.2006a=paste0(path.data.ma,"/CMS Payment Data/2006/2006PartCPlanLevel2.xlsx")
risk.rebate.2006a=read_xlsx(ma.path.2006a,range="A4:H2088",
                           col_names=c("contractid","planid","contract_name","plan_type",
                                       "riskscore_partc","payment_partc","rebate_partc",
                                       "msa_deposit_partc"))
ma.path.2006b=paste0(path.data.ma,"/CMS Payment Data/2006/2006PartDPlans2.xlsx")
risk.rebate.2006b=read_xlsx(ma.path.2006b,range="A4:H3232",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))

  risk.rebate.a=get(paste("risk.rebate.",y,"a",sep="")) %>%
    mutate_at(vars(c("riskscore_partc","payment_partc","rebate_partc")),
              ~as.numeric(str_replace_all(.,'/$',''))) %>%
    mutate(planid=as.numeric(planid), year=y) %>%
    select(contractid, planid, contract_name, plan_type, riskscore_partc,
           payment_partc, rebate_partc, year)
    

  risk.rebate.b=get(paste("risk.rebate.",y,"b",sep="")) %>%
    mutate(payment_partd=directsubsidy_partd + reinsurance_partd + costsharing_partd) %>%
    mutate(planid=as.numeric(planid)) %>%
    select(contractid, planid, payment_partd, directsubsidy_partd, reinsurance_partd, costsharing_partd,
           riskscore_partd)
  
  risk.rebate = risk.rebate.a %>%
    left_join(risk.rebate.b, by=c("contractid","planid"))

  assign(paste("risk.rebate.",y,sep=""),risk.rebate)
  