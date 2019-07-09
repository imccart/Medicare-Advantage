use temp_plancd_2008a, clear
append using temp_plancd_2008b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
destring planid, replace
save temp_plancd_2008, replace


******************************************
  ** 2009 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2009LandscapeSourceData_MA_11_05_08_A_to_M.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2009
save temp_plan_2009a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2009LandscapeSourceData_MA_11_05_08_N_to_W.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2009
save temp_plan_2009b, replace

use temp_plan_2009a, clear
append using temp_plan_2009b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2009, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2009\Medicare Part D 2009 Plan Report 11-03-08.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AB33304) clear
rename PartCPremium3 Premium_PartC
rename PartDBasicPremium4 Premium_PartD_Basic
rename PartDSupplementalPremium5 Premium_PartD_Supplemental
rename PartDTotalPremium6 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2009
save temp_plancd_2009a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2009\Medicare Part D 2009 Plan Report 11-03-08.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AB40219) clear
rename PartCPremium3 Premium_PartC
rename PartDBasicPremium4 Premium_PartD_Basic
rename PartDSupplementalPremium5 Premium_PartD_Supplemental
rename PartDTotalPremium6 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2009
save temp_plancd_2009b, replace

use temp_plancd_2009a, clear
append using temp_plancd_2009b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
destring planid, replace
save temp_plancd_2009, replace




******************************************
  ** 2010 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2010LandscapeSourceData_MA_12_01_09_A_to_M.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2010
save temp_plan_2010a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2010LandscapeSourceData_MA_12_01_09_N_to_W.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2010
save temp_plan_2010b, replace

use temp_plan_2010a, clear
append using temp_plan_2010b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2010, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2010\Medicare Part D 2010 Plan Report 09-14-09.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AC26372) clear
rename PartCPremium3 Premium_PartC
rename PartDBasicPremium4 Premium_PartD_Basic
rename PartDSupplementalPremium5 Premium_PartD_Supplemental
rename PartDTotalPremium6 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2010
save temp_plancd_2010a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2010\Medicare Part D 2010 Plan Report 09-14-09.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AC31073) clear
rename PartCPremium3 Premium_PartC
rename PartDBasicPremium4 Premium_PartD_Basic
rename PartDSupplementalPremium5 Premium_PartD_Supplemental
rename PartDTotalPremium6 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2010
save temp_plancd_2010b, replace

use temp_plancd_2010a, clear
append using temp_plancd_2010b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plancd_2010, replace



******************************************
  ** 2011 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2011LandscapeSourceData_MA_12_17_10_AtoM.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2011
save temp_plan_2011a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2011LandscapeSourceData_MA_12_17_10_NtoW.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2011
save temp_plan_2011b, replace

use temp_plan_2011a, clear
append using temp_plan_2011b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2011, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2011\Medicare Part D 2011 Plan Report 09-15-10.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AA18105) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2011
save temp_plancd_2011a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2011\Medicare Part D 2011 Plan Report 09-15-10.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AA20402) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2011
save temp_plancd_2011b, replace

use temp_plancd_2011a, clear
append using temp_plancd_2011b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plancd_2011, replace


******************************************
  ** 2012 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2012LandscapeSourceData_MA_3_08_12_AtoM.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2012
save temp_plan_2012a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2012LandscapeSourceData_MA_3_08_12_NtoW.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2012
save temp_plan_2012b, replace

use temp_plan_2012a, clear
append using temp_plan_2012b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2012, replace



import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2012\Medicare Part D 2012 Plan Report 09-08-11.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AA18521) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2012
save temp_plancd_2012a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2012\Medicare Part D 2012 Plan Report 09-08-11.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AA21182) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2012
save temp_plancd_2012b, replace

use temp_plancd_2012a, clear
append using temp_plancd_2012b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plancd_2012, replace


******************************************
  ** 2013 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2013LandscapeSource file MA_AtoM 11212012.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2013
save temp_plan_2013a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2013LandscapeSource file MA_NtoW 11212012.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) stringcols(6) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2013
save temp_plan_2013b, replace

use temp_plan_2013a, clear
append using temp_plan_2013b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2013, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2013\Medicare Part D 2013 Plan Report 04252013v1.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AA20940) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2013
save temp_plancd_2013a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2013\Medicare Part D 2013 Plan Report 04252013v1.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AA23812) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2013
save temp_plancd_2013b, replace

use temp_plancd_2013a, clear
append using temp_plancd_2013b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plancd_2013, replace

******************************************
  ** 2014 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2014LandscapeSource file MA_AtoM 05292014.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2014
save temp_plan_2014a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2014LandscapeSource file MA_NtoW 05292014.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2014
save temp_plan_2014b, replace

use temp_plan_2014a, clear
append using temp_plan_2014b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2014, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2014\Medicare Part D 2014 Plan Report 05292014.xls", sheet("Alabama to Montana") firstrow cellrange(A4:AA15859) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2014
save temp_plancd_2014a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2014\Medicare Part D 2014 Plan Report 05292014.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:AA20305) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2014
save temp_plancd_2014b, replace

use temp_plancd_2014a, clear
append using temp_plancd_2014b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
destring planid, replace
save temp_plancd_2014, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2014\Medicare Part D 2014 Plan Report 05292014.xls", sheet("Sanctioned Plans") firstrow cellrange(A4:AA203) clear
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county
gen year=2014
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
destring planid, replace
save temp_sanction_2014, replace


******************************************
  ** 2015 files
import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2015LandscapeSource file MA_AtoM 11042014.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2015
save temp_plan_2015a, replace

import delimited using ///
  "${DATA_MA}MA Plan Characteristics\Extracted Data\2015LandscapeSource file MA_NtoW 11042014.csv", ///
  delimiters(",") varnames(6) stripquotes(yes) clear
keep contractid planid state county typeofmedicarehealthplan monthlyconsolidatedpremium  
gen year=2015
save temp_plan_2015b, replace

use temp_plan_2015a, clear
append using temp_plan_2015b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plan_2015, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2015\Medicare Part D 2015 Plan Report 03182015.xls", sheet("Alabama to Montana") firstrow cellrange(A4:Z16666) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2015
save temp_plancd_2015a, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2015\Medicare Part D 2015 Plan Report 03182015.xls", sheet("Nebraska to Wyoming") firstrow cellrange(A4:Z17038) clear
rename PartCPremium2 Premium_PartC
rename PartDBasicPremium3 Premium_PartD_Basic
rename PartDSupplementalPremium4 Premium_PartD_Supplemental
rename PartDTotalPremium5 Premium_PartD_Total
rename PartDDrugDeductible PartD_Deductible
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county Premium_PartC Premium_PartD_Basic Premium_PartD_Supplemental Premium_PartD_Total PartD_Deductible
gen year=2015
save temp_plancd_2015b, replace

use temp_plancd_2015a, clear
append using temp_plancd_2015b
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_plancd_2015, replace


import excel using "${DATA_MA}MA Plan Characteristics\Extracted Data\PartCD\2015\Medicare Part D 2015 Plan Report 03182015.xls", sheet("Sanctioned Plans") firstrow cellrange(A4:Z367) clear
rename ContractID contractid 
rename PlanID planid
rename State state
rename County county
keep contractid planid state county
gen year=2015
bys contractid planid state county: gen obs=_N
keep if obs==1
drop obs
save temp_sanction_2015, replace


***********************************************************************************
  /* Append yearly datasets and clean */
  ***********************************************************************************
  forvalues t=2007(1)2015 {
    use temp_plan_`t', clear
  merge 1:1 contractid planid state county using temp_plancd_`t', nogenerate
    save temp_planall_`t', replace
}

use temp_planall_2007, clear
forvalues y=2008(1)2015 {
  append using temp_planall_`y'
  }

split monthlyconsolidatedpremium, parse("$")
replace monthlyconsolidatedpremium=""
replace monthlyconsolidatedpremium=monthlyconsolidatedpremium1 if monthlyconsolidatedpremium1!="" & monthlyconsolidatedpremium1!="-"
replace monthlyconsolidatedpremium=monthlyconsolidatedpremium2 if monthlyconsolidatedpremium2!="" & monthlyconsolidatedpremium2!="-"
replace monthlyconsolidatedpremium="0" if monthlyconsolidatedpremium=="" & (monthlyconsolidatedpremium1=="-" | monthlyconsolidatedpremium2=="-")
destring monthlyconsolidatedpremium, replace
drop monthlyconsolidatedpremium1 monthlyconsolidatedpremium2

rename monthlyconsolidatedpremium Premium
save "${DATA_FINAL}Plan_Premiums.dta", replace
