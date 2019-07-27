##############################################################################
## Read in CMS payments, rebates, and risk scores for each plan */
##############################################################################

## Assign yearly datasets and clean variables

## 2006
ma.path.2006a=paste(path.data.ma,"\\CMS Payment Data\\2006\\2006PartCPlanLevel2.xlsx",sep="")
risk.rebate.2006a=read_xlsx(ma.path.2006a,range="A4:H2088",
                           col_names=c("contractid","planid","contract_name","plan_type",
                                       "riskscore_partc","payment_partc","rebate_partc",
                                       "msa_deposit_partc"))
ma.path.2006b=paste(path.data.ma,"\\CMS Payment Data\\2006\\2006PartDPlans2.xlsx",sep="")
risk.rebate.2006b=read_xlsx(ma.path.2006b,range="A4:H3232",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))



risk.rebate.2006a = risk.rebate.2006a %>%
  mutate_at(vars(c("riskscore_partc","payment_partc","rebate_partc")),
            ~as.numeric(str_replace_all(.,'\\$',''))) %>%
  mutate(planid=as.numeric(planid))

risk.rebate.2006b = risk.rebate.2006b %>%
  mutate(payment_partd=directsubsidy_partd + reinsurance_partd + costsharing_partd)


## 2007
ma.path.2007a=paste(path.data.ma,"\\CMS Payment Data\\2007\\2007PartCPlanLevel2.xlsx",sep="")
risk.rebate.2007a=read_xlsx(ma.path.2007a,range="A4:H2572",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))
ma.path.2007b=paste(path.data.ma,"\\CMS Payment Data\\2007\\2007PartDPlans2.xlsx",sep="")
risk.rebate.2007b=read_xlsx(ma.path.2007b,range="A4:H4066",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))


## 2008
ma.path.2008a=paste(path.data.ma,"\\CMS Payment Data\\2008\\2008PartCPlanLevel2.xlsx",sep="")
risk.rebate.2008a=read_xlsx(ma.path.2008a,range="A4:H3346",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "riskscore_partc","payment_partc","rebate_partc",
                                        "msa_deposit_partc"))
ma.path.2008b=paste(path.data.ma,"\\CMS Payment Data\\2008\\2008PartDPlans2.xlsx",sep="")
risk.rebate.2008b=read_xlsx(ma.path.2008b,range="A4:H4686",
                            col_names=c("contractid","planid","contract_name","plan_type",
                                        "directsubsidy_partd","riskscore_partd","reinsurance_partd",
                                        "costsharing_partd"))





***********************************************************************************
  ** 2009 files
import excel using "${DATA_MA}CMS Payment Data\2009\2009PartCPlanLevel2.xlsx", firstrow cellrange(A3:H3506) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2009
save temp_paypartc_2009, replace

import excel using "${DATA_MA}CMS Payment Data\2009\2009PartDPlans2.xlsx", firstrow cellrange(A3:H4733) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2009
save temp_paypartd_2009, replace


***********************************************************************************
  ** 2010 files
import excel using "${DATA_MA}CMS Payment Data\2010\2010PartCPlanLevel2.xlsx", firstrow cellrange(A3:H3157) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2010
save temp_paypartc_2010, replace

import excel using "${DATA_MA}CMS Payment Data\2010\2010PartDPlans2.xlsx", firstrow cellrange(A3:H4417) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2010
save temp_paypartd_2010, replace


***********************************************************************************
  ** 2011 files
import excel using "${DATA_MA}CMS Payment Data\2011\2011PartCPlanLevel.xlsx", firstrow cellrange(A3:H2663) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2011
save temp_paypartc_2011, replace

import excel using "${DATA_MA}CMS Payment Data\2011\2011PartDPlans.xlsx", firstrow cellrange(A3:H3561) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2011
save temp_paypartd_2011, replace


***********************************************************************************
  ** 2012 files
import excel using "${DATA_MA}CMS Payment Data\2012\2012PartCPlanLevel.xlsx", firstrow cellrange(A3:H2757) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2012
save temp_paypartc_2012, replace

import excel using "${DATA_MA}CMS Payment Data\2012\2012PartDPlans.xlsx", firstrow cellrange(A3:H3605) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2012
save temp_paypartd_2012, replace


***********************************************************************************
  ** 2013 files
import excel using "${DATA_MA}CMS Payment Data\2013\2013PartCPlan Level.xlsx", firstrow cellrange(A3:G2968) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2013
save temp_paypartc_2013, replace

import excel using "${DATA_MA}CMS Payment Data\2013\2013PartDPlans.xlsx", firstrow cellrange(A3:H3836) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2013
save temp_paypartd_2013, replace

***********************************************************************************
  ** 2014 files
import excel using "${DATA_MA}CMS Payment Data\2014\2014PartCPlan Level.xlsx", firstrow cellrange(A3:G2828) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AveragePartRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2014
save temp_paypartc_2014, replace

import excel using "${DATA_MA}CMS Payment Data\2014\2014PartDPlans.xlsx", firstrow cellrange(A3:H3902) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2014
save temp_paypartd_2014, replace


***********************************************************************************
  ** 2015 files
import excel using "${DATA_MA}CMS Payment Data\2015\2015PartCPlanLevel.xlsx", firstrow cellrange(A3:G2745) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AveragePartCRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2015
save temp_paypartc_2015, replace

import excel using "${DATA_MA}CMS Payment Data\2015\2015PartDPlans.xlsx", firstrow cellrange(A3:H3755) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2015
save temp_paypartd_2015, replace

***********************************************************************************
  ** Append Yearly Data
forvalues t=2006(1)2015 {
  use temp_paypartc_`t'
  merge 1:1 ContractID PlanID using temp_paypartd_`t', nogenerate
  save temp_pay_`t', replace
}

use temp_pay_2006, clear
forvalues t=2007(1)2015 {
  append using temp_pay_`t'
}

** Save Final Risk/Rebate Data
rename ContractID contractid
rename PlanID planid
save "${DATA_FINAL}RiskRebate.dta", replace







risk.rebate=rbind.fill(risk.rebate.2008, risk.rebate.2009, risk.rebate.2010, risk.rebate.2011,
                       risk.rebate.2012, risk.rebate.2013, risk.rebate.2014, risk.rebate.2015)
write_tsv(risk.rebate,path=paste(path.data.final,"\\Risk_Rebate.txt",sep=""),append=FALSE,col_names=TRUE)
