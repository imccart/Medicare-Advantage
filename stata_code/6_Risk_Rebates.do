***********************************************************************************
** 2006 files
import excel using "${DATA_MA}CMS Payment Data\2006\2006PartCPlanLevel2.xlsx", firstrow cellrange(A3:H2088) clear
rename AverageRebatePMPMPayment Rebate_PartC
replace Rebate_PartC= subinstr(Rebate_PartC, "$", "",.)
destring Rebate_PartC, replace
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2006
save temp_paypartc_2006, replace


import excel using "${DATA_MA}CMS Payment Data\2006\2006PartDPlans2.xlsx", firstrow cellrange(A3:H3232) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2006
save temp_paypartd_2006, replace

***********************************************************************************
** 2007 files
import excel using "${DATA_MA}CMS Payment Data\2007\2007PartCPlanLevel2.xlsx", firstrow cellrange(A3:H2572) clear
rename AverageRebatePMPMPayment Rebate_PartC
replace Rebate_PartC= subinstr(Rebate_PartC, "$", "",.)
destring Rebate_PartC, replace
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2007
save temp_paypartc_2007, replace

import excel using "${DATA_MA}CMS Payment Data\2007\2007PartDPlans2.xlsx", firstrow cellrange(A3:H4066) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2007
save temp_paypartd_2007, replace


***********************************************************************************
** 2008 files
import excel using "${DATA_MA}CMS Payment Data\2008\2008PartCPlanLevel2.xlsx", firstrow cellrange(A3:H3346) clear
rename AverageRebatePMPMPayment Rebate_PartC
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AverageABPMPMPayment Payment_PartC
rename AverageRiskScore RiskScore_PartC
keep Payment_PartC RiskScore_PartC Rebate_PartC ContractID PlanID
gen year=2008
save temp_paypartc_2008, replace

import excel using "${DATA_MA}CMS Payment Data\2008\2008PartDPlans2.xlsx", firstrow cellrange(A3:H4686) clear
gen Payment_PartD=AveragePartDDirectSubsidyPM+AverageReinsurancePMPMPaymen+AverageLowIncomeCostSharing
gen DirectSubsidy_PartD=AveragePartDDirectSubsidyPM
rename ContractNumber ContractID
rename PlanBenefitPackage PlanID
destring PlanID, replace
rename AveragePartDRiskScore RiskScore_PartD
keep Payment_PartD RiskScore_PartD ContractID PlanID DirectSubsidy_PartD
gen year=2008
save temp_paypartd_2008, replace


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
