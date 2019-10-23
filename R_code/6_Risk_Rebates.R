##############################################################################
## Read in CMS payments, rebates, and risk scores for each plan */
##############################################################################

## Assign yearly datasets and clean variables

## 2006
ma.path.2006a=paste0(path.data.ma,"\\CMS Payment Data\\2006\\2006PartCPlanLevel2.xlsx")
risk.rebate.2006a=read_xlsx(ma.path.2006a,range="A4:H2088",
                           col_names=c("contractid","planid","contract_name","plan_type",
                                       "riskscore_partc","payment_partc","rebate_partc",
                                       "msa_deposit_partc"))
ma.path.2006b=paste0(path.data.ma,"\\CMS Payment Data\\2006\\2006PartDPlans2.xlsx")
risk.rebate.2006b=read_xlsx(ma.path.2006b,range="A4:H3232",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))



## 2007
ma.path.2007a=paste0(path.data.ma,"\\CMS Payment Data\\2007\\2007PartCPlanLevel2.xlsx")
risk.rebate.2007a=read_xlsx(ma.path.2007a,range="A4:H2572",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))
ma.path.2007b=paste0(path.data.ma,"\\CMS Payment Data\\2007\\2007PartDPlans2.xlsx")
risk.rebate.2007b=read_xlsx(ma.path.2007b,range="A4:H4066",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2008
ma.path.2008a=paste0(path.data.ma,"\\CMS Payment Data\\2008\\2008PartCPlanLevel2.xlsx")
risk.rebate.2008a=read_xlsx(ma.path.2008a,range="A4:H3346",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))
ma.path.2008b=paste0(path.data.ma,"\\CMS Payment Data\\2008\\2008PartDPlans2.xlsx")
risk.rebate.2008b=read_xlsx(ma.path.2008b,range="A4:H4686",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2009
ma.path.2009a=paste0(path.data.ma,"\\CMS Payment Data\\2009\\2009PartCPlanLevel2.xlsx")
risk.rebate.2009a=read_xlsx(ma.path.2009a,range="A4:H3506",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))

ma.path.2009b=paste0(path.data.ma,"\\CMS Payment Data\\2009\\2009PartDPlans2.xlsx")
risk.rebate.2009b=read_xlsx(ma.path.2009b,range="A4:H4733",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2010
ma.path.2010a=paste0(path.data.ma,"\\CMS Payment Data\\2010\\2010PartCPlanLevel2.xlsx")
risk.rebate.2010a=read_xlsx(ma.path.2010a,range="A4:H3157",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))

ma.path.2010b=paste0(path.data.ma,"\\CMS Payment Data\\2010\\2010PartDPlans2.xlsx")
risk.rebate.2010b=read_xlsx(ma.path.2010b,range="A4:H4417",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2011
ma.path.2011a=paste0(path.data.ma,"\\CMS Payment Data\\2011\\2011PartCPlanLevel.xlsx")
risk.rebate.2011a=read_xlsx(ma.path.2011a,range="A4:H2663",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))

ma.path.2011b=paste0(path.data.ma,"\\CMS Payment Data\\2011\\2011PartDPlans.xlsx")
risk.rebate.2011b=read_xlsx(ma.path.2011b,range="A4:H3561",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2012
ma.path.2012a=paste0(path.data.ma,"\\CMS Payment Data\\2012\\2012PartCPlanLevel.xlsx")
risk.rebate.2012a=read_xlsx(ma.path.2012a,range="A4:H2757",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))

ma.path.2012b=paste0(path.data.ma,"\\CMS Payment Data\\2012\\2012PartDPlans.xlsx")
risk.rebate.2012b=read_xlsx(ma.path.2012b,range="A4:H3605",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2013
ma.path.2013a=paste0(path.data.ma,"\\CMS Payment Data\\2013\\2013PartCPlan Level.xlsx")
risk.rebate.2013a=read_xlsx(ma.path.2013a,range="A4:G2968",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc"))

ma.path.2013b=paste0(path.data.ma,"\\CMS Payment Data\\2013\\2013PartDPlans.xlsx")
risk.rebate.2013b=read_xlsx(ma.path.2013b,range="A4:H3836",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2014
ma.path.2014a=paste0(path.data.ma,"\\CMS Payment Data\\2014\\2014PartCPlan Level.xlsx")
risk.rebate.2014a=read_xlsx(ma.path.2014a,range="A4:G2828",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc"))

ma.path.2014b=paste0(path.data.ma,"\\CMS Payment Data\\2014\\2014PartDPlans.xlsx")
risk.rebate.2014b=read_xlsx(ma.path.2014b,range="A4:H3902",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2015
ma.path.2015a=paste0(path.data.ma,"\\CMS Payment Data\\2015\\2015PartCPlanLevel.xlsx")
risk.rebate.2015a=read_xlsx(ma.path.2015a,range="A4:G2745",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc"))

ma.path.2015b=paste0(path.data.ma,"\\CMS Payment Data\\2015\\2015PartDPlans.xlsx")
risk.rebate.2015b=read_xlsx(ma.path.2015b,range="A4:H3755",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


for (y in 2006:2015) {
  risk.rebate.a=get(paste("risk.rebate.",y,"a",sep="")) %>%
    mutate_at(vars(c("riskscore_partc","payment_partc","rebate_partc")),
              ~as.numeric(str_replace_all(.,'\\$',''))) %>%
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
  
}

risk.rebate.final=rbind(risk.rebate.2006,risk.rebate.2007,risk.rebate.2008,
                        risk.rebate.2009,risk.rebate.2010,risk.rebate.2011,
                        risk.rebate.2012,risk.rebate.2013,risk.rebate.2014,
                        risk.rebate.2015)
write_tsv(risk.rebate.final,path=paste(path.data.final,"\\Risk_Rebate.txt",sep=""),
          append=FALSE,col_names=TRUE)
write_rds(risk.rebate.final,paste(path.data.final,"\\risk_rebate.rds",sep=""))