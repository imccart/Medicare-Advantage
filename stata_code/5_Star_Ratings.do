***********************************************************************************
/* Read in MA Domain Level Data */
***********************************************************************************


***********************************************************************************
** 2008 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2008\2008_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv", ///
  delimiters(",") varnames(4) stripquotes(yes) clear
gen year=2008
rename v1 contractid
rename v2 contractname
rename v32 NewContract

global StayingHealthy breastcancerscreening colorectalcancerscreening cardiovascularcarecholesterolscr diabetescarecholesterolscreening glaucomatesting ///
   appropriatemonitoringofpatientst annualfluvaccine pneumoniavaccine
global TimelyCare accesstoprimarycaredoctorvisits followupvisitafterhospitalstayfo doctorfollowupfordepression gettingneededcarewithoutdelays 
global Responsiveness gettingcarequickly overallratingofhealthcare overallratingofhealthplan callanswertimeliness doctorswhocommunicatewell
global ManagingChronic osteoporosismanagement diabetescareeyeexam diabetescaremonitoringkidneydise diabetescarebloodsugarcontrolled diabetescarecholesterolcontrolle ///
   antidepressantmedicationmanageme controllingbloodpressure rheumatoidarthritismanagement testingtoconfirmchronicobstructi continuousbetablockertreatment
global MemberComplaints planmakestimelydecisionsaboutapp reviewingappealsdecisions
global Measures ${StayingHealthy} ${TimelyCare} ${Responsiveness} ///
  ${ManagingChronic} ${MemberComplaints}

save temp_stars_2008, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2008\2008_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contract contractid
gen year=2008
**egen PartC_Summary_Star=rowmean(helpingyoustayhealthy gettingcarefromyourdoctorsandspe gettingtimelyinformationandcaref managingchroniclonglastingcondit yourrightstoappeal)
gen PartC_Summary_Star=.
gen NewContract=(too_new==1)
save temp_summary_2008, replace

use temp_stars_2008, clear
merge 1:1 contractid using temp_summary_2008, keepusing(PartC_Summary_Star NewContract) nogenerate
save temp_stars_2008, replace



***********************************************************************************
** 2009 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2009\2009_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv", ///
  delimiters(",") varnames(4) stripquotes(yes) clear
rename contractnumber contractid
gen year=2009

global StayingHealthy breastcancerscreening colorectalcancerscreening cardiovascularcarecholesterolscr diabetescarecholesterolscreening glaucomatesting ///
   appropriatemonitoringofpatientst annualfluvaccine pneumoniavaccine improvingormaintainingphysicalhe improvingormaintainingmentalheal osteoporosistesting monitoringphysicalactivity
global TimelyCare accesstoprimarycaredoctorvisits followupvisitafterhospitalstayfo doctorfollowupfordepression gettingneededcarewithoutdelays 
global Responsiveness gettingappointmentsandcarequickl overallratingofhealthcarequality overallratingofhealthplan callanswertimeliness doctorswhocommunicatewell customerservice
global ManagingChronic osteoporosismanagement diabetescareeyeexam diabetescarekidneydiseasemonitor diabetescarebloodsugarcontrolled diabetescarecholesterolcontrolle ///
   antidepressantmedicationmanageme controllingbloodpressure rheumatoidarthritismanagement testingtoconfirmchronicobstructi continuousbetablockertreatment ///
   improvingbladdercontrol reducingtheriskoffalling
global MemberComplaints planmakestimelydecisionsaboutapp reviewingappealsdecisions
global Measures ${StayingHealthy} ${TimelyCare} ${Responsiveness} ///
  ${ManagingChronic} ${MemberComplaints}

foreach x of varlist $Measures {
  replace `x'="1" if `x'=="1 out of 5 stars"
  replace `x'="2" if `x'=="2 out of 5 stars"
  replace `x'="3" if `x'=="3 out of 5 stars"
  replace `x'="4" if `x'=="4 out of 5 stars"
  replace `x'="5" if `x'=="5 stars"
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2009, replace


import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2009\2009_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2009
gen PartC_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if summaryscoreforhealthplanquality=="`x' out of 5 stars"
  replace PartC_Summary_Star=`x' if summaryscoreforhealthplanquality=="`x' stars"  
}
gen NewContract=(summaryscoreforhealthplanquality=="Plan too new to be measured")
save temp_summary_2009, replace

use temp_stars_2009, clear
merge 1:1 contractid using temp_summary_2009, keepusing(PartC_Summary_Star NewContract) nogenerate
save temp_stars_2009, replace


***********************************************************************************
** 2010 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2010\2010_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv", ///
  delimiters(",") varnames(4) stripquotes(yes) clear
rename contractnumber contractid
gen year=2010


global StayingHealthy breastcancerscreening colorectalcancerscreening cholesterolscreeningforpatientsw glaucomatesting ///
   monitoringofpatientstakinglongte annualfluvaccine pneumoniavaccine improvingormaintainingphysicalhe improvingormaintainingmentalheal ///
   osteoporosistesting monitoringphysicalactivity atleastoneprimarycaredoctorvisit
global ManagingChronic osteoporosismanagement providingcertainkindsofcarethath controllingbloodpressure rheumatoidarthritismanagement ///
   testingtoconfirmchronicobstructi improvingbladdercontrol reducingtheriskoffalling
global Responsiveness easeofgettingneededcareandseeing doctorswhocommunicatewell gettingappointmentsandcarequickl ///
   customerservice overallratingofhealthcarequality overallratingofplan
global MemberComplaints complaintsaboutthehealthplannumb healthplanmakestimelydecisionsab fairnessofhealthplansdenialstoam ///
   memberschoosingtoleavethehealthp seriousnessofproblemsmedicarefou 
global CustomerService timeonholdwhencustomercallshealt accuracyofinformationmembersgetw availabilityofttytddservicesando
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="1" if `x'=="1 out of 5 stars"
  replace `x'="2" if `x'=="2 out of 5 stars"
  replace `x'="3" if `x'=="3 out of 5 stars"
  replace `x'="4" if `x'=="4 out of 5 stars"
  replace `x'="5" if `x'=="5 stars"
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2010, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2010\2010_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2010
gen PartC_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if summaryscoreforhealthplanquality=="`x' out of 5 stars"
  replace PartC_Summary_Star=`x' if summaryscoreforhealthplanquality=="`x' stars"
}
gen NewContract=(summaryscoreforhealthplanquality=="Plan too new to be measured")
save temp_summary_2010, replace

use temp_stars_2010, clear
merge 1:1 contractid using temp_summary_2010, keepusing(PartC_Summary_Star NewContract) nogenerate
save temp_stars_2010, replace



***********************************************************************************
** 2011 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2011\2011_Part_C_Report_Card_Master_Table_2011_04_20_star.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
rename contractnumber contractid
gen year=2011


global StayingHealthy breastcancerscreening colorectalcancerscreening cardiovascularcarecholesterolscr diabetescarecholesterolscreening glaucomatesting ///
   appropriatemonitoringforpatients annualfluvaccine pneumoniavaccine improvingormaintainingphysicalhe improvingormaintainingmentalheal ///
   osteorporosistesting monitoringphysicalactivity accesstoprimarycaredoctorvisits
global ManagingChronic osteoporosismanagementinwomenwho diabetescareeyeexam diabetescarekidneydiseasemonitor diabetescarebloodsugarcontrolled ///
   diabetescarecholesterolcontrolle controllingbloodpressure rheumatoidarthritismanagement ///
   testingtoconfirmchronicobstructi improvingbladdercontrol reducingtheriskoffalling
global Responsiveness gettingneededcarewithoutdelays doctorswhocommunicatewell gettingappointmentsandcarequickl ///
   customerservice overallratingofhealthcarequality overallratingofplan
global MemberComplaints complaintstrackingmodule planmakestimelydecisionsaboutapp reviewingappealsdecisions correctiveactionplans
global CustomerService callcenterholdtime callcenterinformationaccuracy callcenterforeignlanguageinterpr
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="1" if `x'=="1 out of 5 stars" | `x'=="1 stars"
  replace `x'="2" if `x'=="2 out of 5 stars" | `x'=="2 stars"
  replace `x'="3" if `x'=="3 out of 5 stars" | `x'=="3 stars"
  replace `x'="4" if `x'=="4 out of 5 stars" | `x'=="4 stars"
  replace `x'="5" if `x'=="5 stars"
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2011, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2011\2011_Part_C_Report_Card_Master_Table_2011_04_20_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2011
gen PartC_Summary_Star=.
gen PartCD_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if summaryrating=="`x' out of 5 stars"
  replace PartC_Summary_Star=`x' if summaryrating=="`x' stars"
  replace PartCD_Summary_Star=`x' if overallrating=="`x' out of 5 stars"
  replace PartCD_Summary_Star=`x' if overallrating=="`x' stars"  
}
gen NewContract=(summaryrating=="Plan too new to be measured")
gen PartC_LowStar_Plan=(lowperformanceicon=="Yes")
save temp_summary_2011, replace

use temp_stars_2011, clear
merge 1:1 contractid using temp_summary_2011, keepusing(PartC_Summary_Star PartCD_Summary_Star NewContract PartC_LowStar_Plan) nogenerate
save temp_stars_2011, replace



***********************************************************************************
** 2012 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2012 Fall\2012_Part_C_Report_Card_Master_Table_2011_11_01_star.csv", ///
  delimiters(",") varnames(5) stripquotes(yes) clear
rename contractnumber contractid
gen year=2012

global StayingHealthy breastcancerscreening colorectalcancerscreening cardiovascularcarecholesterolscr diabetescarecholesterolscreening glaucomatesting ///
   annualfluvaccine pneumoniavaccine improvingormaintainingphysicalhe improvingormaintainingmentalheal ///
   monitoringphysicalactivity accesstoprimarycaredoctorvisits adultbmiassessment
global ManagingChronic careforolderadultsmedicationrevi careforolderadultsfunctionalstat careforolderadultspainscreening osteoporosismanagementinwomenwho ///
   diabetescareeyeexam diabetescarekidneydiseasemonitor diabetescarebloodsugarcontrolled ///
   diabetescarecholesterolcontrolle controllingbloodpressure rheumatoidarthritismanagement ///
   improvingbladdercontrol reducingtheriskoffalling planallcausereadmissions
global Responsiveness gettingneededcare gettingappointmentsandcarequickl ///
   customerservice overallratingofhealthcarequality overallratingofplan
global MemberComplaints complaintsaboutthehealthplan beneficiaryaccessandperformancep memberschoosingtoleavetheplan
global CustomerService planmakestimelydecisionsaboutapp reviewingappealsdecisions callcenterforeignlanguageinterpr
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2012, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2012 Fall\2012_Part_C_Report_Card_Master_Table_2011_11_01_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2012
gen PartC_Summary_Star=.
gen PartCD_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if partcsummaryrating=="`x' out of 5 stars"
  replace PartC_Summary_Star=`x' if partcsummaryrating=="`x' stars"
  replace PartCD_Summary_Star=`x' if overallrating=="`x' out of 5 stars"
  replace PartCD_Summary_Star=`x' if overallrating=="`x' stars"  
}
gen NewContract=(partcsummaryrating=="Plan too new to be measured")
gen PartC_LowStar_Plan=(summarylowperformanceicon=="Yes")
gen PartCD_LowStar_Plan=(overalllowperformanceicon=="Yes")
save temp_summary_2012, replace

use temp_stars_2012, clear
merge 1:1 contractid using temp_summary_2012, keepusing(PartC_Summary_Star PartCD_Summary_Star NewContract PartC_LowStar_Plan PartCD_LowStar_Plan) nogenerate
save temp_stars_2012, replace



***********************************************************************************
** 2013 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2013 Fall\2013_Part_C_Report_Card_Master_Table_2012_10_17_star.csv", ///
  delimiters(",") varnames(4) stripquotes(yes) clear
rename v1 contractid
rename v2 organizationtype
rename v3 contractname
rename v4 organizationmarketingname
rename v5 parentorganization
drop if contractid==""
gen year=2013

global StayingHealthy c01breastcancerscreening c02colorectalcancerscreening c03cardiovascularcarecholesterol c04diabetescarecholesterolscreen c05glaucomatesting ///
   c06annualfluvaccine c07improvingormaintainingphysica c08improvingormaintainingmentalh ///
   c09monitoringphysicalactivity c10adultbmiassessment
global ManagingChronic c11careforolderadultsmedicationr c12careforolderadultsfunctionals c13careforolderadultspainscreeni c14osteoporosismanagementinwomen ///
   c15diabetescareeyeexam c16diabetescarekidneydiseasemoni c17diabetescarebloodsugarcontrol ///
   c18diabetescarecholesterolcontro c19controllingbloodpressure c20rheumatoidarthritismanagement ///
   c21improvingbladdercontrol c22reducingtheriskoffalling c23planallcausereadmissions
global Responsiveness c24gettingneededcare c25gettingappointmentsandcarequi ///
   c26customerservice c27overallratingofhealthcarequal c28overallratingofplan c29carecoordination
global MemberComplaints c30complaintsaboutthehealthplan c31beneficiaryaccessandperforman c32memberschoosingtoleavetheplan c33improvement
global CustomerService c34planmakestimelydecisionsabout c35reviewingappealsdecisions c36callcenterforeignlanguageinte c37enrollmenttimeliness
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2013, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2013 Fall\2013_Part_C_Report_Card_Master_Table_2012_10_17_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2013
gen PartC_Summary_Star=.
gen PartCD_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if partcsummaryrating=="`x'"
  replace PartCD_Summary_Star=`x' if overallrating=="`x'"
}
gen NewContract=(partcsummaryrating=="Plan too new to be measured")
gen PartC_LowStar_Plan=(summarylowperformericon=="Yes")
gen PartCD_LowStar_Plan=(overalllowperformericon=="Yes")
save temp_summary_2013, replace

use temp_stars_2013, clear
merge 1:1 contractid using temp_summary_2013, keepusing(PartC_Summary_Star PartCD_Summary_Star NewContract PartC_LowStar_Plan PartCD_LowStar_Plan) nogenerate
save temp_stars_2013, replace



***********************************************************************************
** 2014 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2014 Fall\2014_Part_C_Report_Card_Master_Table_2013_10_17_stars.csv", ///
  delimiters(",") varnames(3) stripquotes(yes) clear
rename v1 contractid
rename v2 organizationtype
rename v3 contractname
rename v4 organizationmarketingname
rename v5 parentorganization
drop if contractid==""
gen year=2014

global StayingHealthy c01breastcancerscreening c02colorectalcancerscreening c03cardiovascularcarecholesterol c04diabetescarecholesterolscreen c05glaucomatesting ///
   c06annualfluvaccine c07improvingormaintainingphysica c08improvingormaintainingmentalh ///
   c09monitoringphysicalactivity c10adultbmiassessment
global ManagingChronic c11careforolderadultsmedicationr c12careforolderadultsfunctionals c13careforolderadultspainscreeni c14osteoporosismanagementinwomen ///
   c15diabetescareeyeexam c16diabetescarekidneydiseasemoni c17diabetescarebloodsugarcontrol ///
   c18diabetescarecholesterolcontro c19controllingbloodpressure c20rheumatoidarthritismanagement ///
   c21improvingbladdercontrol c22reducingtheriskoffalling c23planallcausereadmissions
global Responsiveness c24gettingneededcare c25gettingappointmentsandcarequi ///
   c26customerservice c27ratingofhealthcarequality c28ratingofhealthplan c29carecoordination
global MemberComplaints c30complaintsaboutthehealthplan c31beneficiaryaccessandperforman c32memberschoosingtoleavetheplan c33healthplanqualityimprovement
global CustomerService c34planmakestimelydecisionsabout c35reviewingappealsdecisions c36callcenterforeignlanguageinte
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2014, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2014 Fall\2014_Part_C_Report_Card_Master_Table_2013_10_17_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
drop v10-v41
rename contractnumber contractid
gen year=2014
gen PartC_Summary_Star=.
gen PartCD_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if partcsummaryrating=="`x'"
  replace PartCD_Summary_Star=`x' if overallrating=="`x'"
}
gen NewContract=(partcsummaryrating=="Plan too new to be measured")
save temp_summary_2014, replace


import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\Part C 2014 Fall\2014_Part_C_Report_Card_Master_Table_2013_10_17_lpi.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2014
gen PartCD_LowStar_Plan=1
save temp_lpi_2014, replace

use temp_stars_2014, clear
merge 1:1 contractid using temp_summary_2014, keepusing(PartC_Summary_Star PartCD_Summary_Star NewContract) nogenerate
merge 1:1 contractid using temp_lpi_2014, keepusing(PartCD_LowStar_Plan) keep(master match) nogenerate
replace PartCD_LowStar_Plan=0 if PartCD_LowStar_Plan==.
save temp_stars_2014, replace



***********************************************************************************
** 2015 files
import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2015 Fall\2015_Report_Card_Master_Table_2014_10_03_stars.csv", ///
  delimiters(",") varnames(3) stripquotes(yes) clear
rename v1 contractid
rename v2 organizationtype
rename v3 contractname
rename v4 organizationmarketingname
rename v5 parentorganization
drop if contractid==""
gen year=2015

global StayingHealthy c01colorectalcancerscreening c02cardiovascularcarecholesterol c03diabetescarecholesterolscreen ///
   c04annualfluvaccine c05improvingormaintainingphysica c06improvingormaintainingmentalh ///
   c07monitoringphysicalactivity c08adultbmiassessment
global ManagingChronic c09specialneedsplansnpcaremanage c10careforolderadultsmedicationr c11careforolderadultsfunctionals c12careforolderadultspainassessm c13osteoporosismanagementinwomen ///
   c14diabetescareeyeexam c15diabetescarekidneydiseasemoni c16diabetescarebloodsugarcontrol ///
   c17diabetescarecholesterolcontro c18controllingbloodpressure c19rheumatoidarthritismanagement ///
   c20improvingbladdercontrol c21reducingtheriskoffalling c22planallcausereadmissions
global Responsiveness c23gettingneededcare c24gettingappointmentsandcarequi ///
   c25customerservice c26ratingofhealthcarequality c27ratingofhealthplan c28carecoordination
global MemberComplaints c29complaintsaboutthehealthplan c30memberschoosingtoleavetheplan c31healthplanqualityimprovement
global CustomerService c32planmakestimelydecisionsabout c33reviewingappealsdecisions
global Measures ${StayingHealthy} ${ManagingChronic} ${Responsiveness} ///
  ${MemberComplaints} ${CustomerService} 

foreach x of varlist $Measures {
  replace `x'="" if (`x'!="1" & `x'!="2" & `x'!="3" & `x'!="4" & `x'!="5")
  destring `x', replace
}
save temp_stars_2015, replace

import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2015 Fall\2015_Report_Card_Master_Table_2014_10_03_summary.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
drop v11-v51
rename contractnumber contractid
gen year=2015
gen PartC_Summary_Star=.
gen PartCD_Summary_Star=.
forvalues x=1.5(.5)5 {
  replace PartC_Summary_Star=`x' if partcsummary=="`x'"
  replace PartCD_Summary_Star=`x' if overall=="`x'"
}
gen NewContract=(partcsummary=="Plan too new to be measured")
save temp_summary_2015, replace


import delimited using ///
  "${DATA_MA}MA Star Ratings\Extracted Star Ratings\2015 Fall\2015_Report_Card_Master_Table_2014_10_03_lpi.csv", ///
  delimiters(",") varnames(2) stripquotes(yes) clear
rename contractnumber contractid
gen year=2014
gen PartCD_LowStar_Plan=1
save temp_lpi_2015, replace

use temp_stars_2015, clear
merge 1:1 contractid using temp_summary_2015, keepusing(PartC_Summary_Star PartCD_Summary_Star NewContract) nogenerate
merge 1:1 contractid using temp_lpi_2015, keepusing(PartCD_LowStar_Plan) keep(master match) nogenerate
replace PartCD_LowStar_Plan=0 if PartCD_LowStar_Plan==.
save temp_stars_2015, replace




***********************************************************************************
/* Clean and Append Data */
***********************************************************************************

** 2008 Variable Names
use temp_stars_2008, clear
rename breastcancerscreening bc_screen
rename colorectalcancerscreening cr_screen
rename diabetescarecholesterolscreening diab_chol_screen
rename glaucomatesting g_test
rename appropriatemonitoringofpatientst drug_monitor
rename annualfluvaccine flu
rename pneumoniavaccine pneumonia

rename accesstoprimarycaredoctorvisits doctor_access
rename followupvisitafterhospitalstayfo fu_hospital
rename doctorfollowupfordepression fu_depression 
rename gettingneededcarewithoutdelays needed_care

rename gettingcarequickly care_quickly
rename overallratingofhealthcare rate_care
rename overallratingofhealthplan rate_plan
rename callanswertimeliness call_timeliness
rename doctorswhocommunicatewell doctor_comm

rename osteoporosismanagement osteo_manage
rename diabetescareeyeexam diab_eye
rename diabetescaremonitoringkidneydise diab_kidney
rename diabetescarebloodsugarcontrolled diab_bloodsugar
rename diabetescarecholesterolcontrolle diab_chol
rename antidepressantmedicationmanageme antidep_manage
rename controllingbloodpressure bp_control
rename rheumatoidarthritismanagement ra_manage
rename testingtoconfirmchronicobstructi copd_confirm
rename continuousbetablockertreatment beta_treat

rename planmakestimelydecisionsaboutapp timely_appeals
rename reviewingappealsdecisions review_appeals
save temp_stars_2008, replace


** 2009 Variable Names
use temp_stars_2009, clear
rename breastcancerscreening bc_screen
rename colorectalcancerscreening cr_screen
rename cardiovascularcarecholesterolscr cv_chol_screen
rename diabetescarecholesterolscreening diab_chol_screen
rename glaucomatesting g_test
rename appropriatemonitoringofpatientst drug_monitor
rename annualfluvaccine flu
rename pneumoniavaccine pneumonia
rename improvingormaintainingphysicalhe physical_health
rename improvingormaintainingmentalheal mental_health 
rename osteoporosistesting osteo_test
rename monitoringphysicalactivity physical_monitor

rename accesstoprimarycaredoctorvisits doctor_access
rename followupvisitafterhospitalstayfo fu_hospital
rename doctorfollowupfordepression fu_depression
rename gettingneededcarewithoutdelays needed_care

rename gettingappointmentsandcarequickl care_quickly
rename overallratingofhealthcarequality rate_care
rename overallratingofhealthplan rate_plan
rename callanswertimeliness call_timeliness
rename doctorswhocommunicatewell doctor_comm
rename customerservice cust_service

rename osteoporosismanagement osteo_manage
rename diabetescareeyeexam diab_eye
rename diabetescarekidneydiseasemonitor diab_kidney
rename diabetescarebloodsugarcontrolled diab_bloodsugar
rename diabetescarecholesterolcontrolle diab_chol
rename antidepressantmedicationmanageme antidep_manage
rename controllingbloodpressure bp_control
rename rheumatoidarthritismanagement ra_manage
rename testingtoconfirmchronicobstructi copd_confirm
rename continuousbetablockertreatment beta_treat
rename improvingbladdercontrol bladder_control
rename reducingtheriskoffalling fall_risk

rename planmakestimelydecisionsaboutapp timely_appeals
rename reviewingappealsdecisions review_appeals
save temp_stars_2009, replace


** 2010 Variable Names
use temp_stars_2010, clear
rename breastcancerscreening bc_screen
rename colorectalcancerscreening cr_screen
rename cholesterolscreeningforpatientsw chol_screen
rename glaucomatesting g_test
rename monitoringofpatientstakinglongte drug_monitor
rename annualfluvaccine flu
rename pneumoniavaccine pneumonia
rename improvingormaintainingphysicalhe physical_health
rename improvingormaintainingmentalheal mental_health
rename osteoporosistesting osteo_test
rename monitoringphysicalactivity physical_monitor
rename atleastoneprimarycaredoctorvisit primary_care_visit

rename osteoporosismanagement osteo_manage
rename providingcertainkindsofcarethath diab_care 
rename controllingbloodpressure bp_control
rename rheumatoidarthritismanagement ra_manage
rename testingtoconfirmchronicobstructi copd_confirm
rename improvingbladdercontrol bladder_control
rename reducingtheriskoffalling fall_risk

rename easeofgettingneededcareandseeing needed_care
rename doctorswhocommunicatewell doctor_comm
rename gettingappointmentsandcarequickl care_quickly
rename customerservice cust_service
rename overallratingofhealthcarequality rate_care
rename overallratingofplan rate_plan

rename complaintsaboutthehealthplannumb complaints
rename healthplanmakestimelydecisionsab timely_appeals
rename fairnessofhealthplansdenialstoam fairness
rename memberschoosingtoleavethehealthp switching
rename seriousnessofproblemsmedicarefou audit

rename timeonholdwhencustomercallshealt hold_time
rename accuracyofinformationmembersgetw info_accuracy
rename availabilityofttytddservicesando phone_service
save temp_stars_2010, replace


** 2011 Variable Names
use temp_stars_2011, clear
rename breastcancerscreening bc_screen
rename colorectalcancerscreening cr_screen
rename cardiovascularcarecholesterolscr cv_chol_screen
rename diabetescarecholesterolscreening diab_chol_screen
rename glaucomatesting g_test
rename appropriatemonitoringforpatients drug_monitor
rename annualfluvaccine flu
rename pneumoniavaccine pneumonia
rename improvingormaintainingphysicalhe physical_health
rename improvingormaintainingmentalheal mental_health
rename osteorporosistesting osteo_test
rename monitoringphysicalactivity physical_monitor
rename accesstoprimarycaredoctorvisits doctor_acccess

rename osteoporosismanagementinwomenwho osteo_manage
rename diabetescareeyeexam diab_eye
rename diabetescarekidneydiseasemonitor diab_kidney
rename diabetescarebloodsugarcontrolled diab_bloodsugar
rename diabetescarecholesterolcontrolle diab_chol
rename controllingbloodpressure bp_control
rename rheumatoidarthritismanagement ra_manage
rename testingtoconfirmchronicobstructi copd_confirm
rename improvingbladdercontrol bladder_control
rename reducingtheriskoffalling fall_risk

rename gettingneededcarewithoutdelays needed_care
rename doctorswhocommunicatewell doctor_comm 
rename gettingappointmentsandcarequickl care_quickly
rename customerservice cust_service
rename overallratingofhealthcarequality rate_care
rename overallratingofplan rate_plan

rename complaintstrackingmodule complaints
rename planmakestimelydecisionsaboutapp timely_appeals
rename reviewingappealsdecisions review_appeals
rename correctiveactionplans action_plans

rename callcenterholdtime hold_time
rename callcenterinformationaccuracy info_accuracy
rename callcenterforeignlanguageinterpr phone_service
save temp_stars_2011, replace


** 2012 Variable Names
use temp_stars_2012, clear
rename breastcancerscreening bc_screen
rename colorectalcancerscreening cr_screen
rename cardiovascularcarecholesterolscr cv_chol_screen
rename diabetescarecholesterolscreening diab_chol_screen
rename glaucomatesting g_test
rename annualfluvaccine flu
rename pneumoniavaccine pneumonia
rename improvingormaintainingphysicalhe physical_health
rename improvingormaintainingmentalheal mental_health
rename monitoringphysicalactivity physical_monitor
rename accesstoprimarycaredoctorvisits doctor_access
rename adultbmiassessment bmi_assess

rename careforolderadultsmedicationrevi med_review
rename careforolderadultsfunctionalstat functional_status
rename careforolderadultspainscreening pain_screen
rename osteoporosismanagementinwomenwho osteo_manage
rename diabetescareeyeexam diab_eye
rename diabetescarekidneydiseasemonitor diab_kidney
rename diabetescarebloodsugarcontrolled diab_bloodsugar
rename diabetescarecholesterolcontrolle diab_chol
rename controllingbloodpressure bp_control
rename rheumatoidarthritismanagement ra_manage
renam improvingbladdercontrol bladder_control
rename reducingtheriskoffalling fall_risk
rename planallcausereadmissions readmit

rename gettingneededcare needed_care
rename gettingappointmentsandcarequickl care_quickly
rename customerservice cust_service
rename overallratingofhealthcarequality rate_care
rename overallratingofplan rate_plan

rename complaintsaboutthehealthplan complaints
rename beneficiaryaccessandperformancep problems
rename memberschoosingtoleavetheplan switching

rename planmakestimelydecisionsaboutapp timely_appeals
rename reviewingappealsdecisions review_appeals
rename callcenterforeignlanguageinterpr phone_service
save temp_stars_2012, replace


** 2013 Variable Names
use temp_stars_2013, clear
rename c01breastcancerscreening bc_screen
rename c02colorectalcancerscreening cr_screen
rename c03cardiovascularcarecholesterol cv_chol_screen
rename c04diabetescarecholesterolscreen diab_chol_screen
rename c05glaucomatesting g_test
rename c06annualfluvaccine flu
rename c07improvingormaintainingphysica physical_health
rename c08improvingormaintainingmentalh mental_health
rename c09monitoringphysicalactivity physical_monitor
rename c10adultbmiassessment bmi_assess

rename c11careforolderadultsmedicationr med_review
rename c12careforolderadultsfunctionals functional_status
rename c13careforolderadultspainscreeni pain_screen
rename c14osteoporosismanagementinwomen osteo_manage
rename c15diabetescareeyeexam diab_eye
rename c16diabetescarekidneydiseasemoni diab_kidney
rename c17diabetescarebloodsugarcontrol diab_bloodsugar
rename c18diabetescarecholesterolcontro diab_chol
rename c19controllingbloodpressure bp_control
rename c20rheumatoidarthritismanagement ra_manage
rename c21improvingbladdercontrol bladder_control
rename c22reducingtheriskoffalling fall_risk
rename c23planallcausereadmissions readmit

rename c24gettingneededcare needed_care
rename c25gettingappointmentsandcarequi care_quickly
rename c26customerservice cust_service
rename c27overallratingofhealthcarequal rate_care
rename c28overallratingofplan rate_plan
rename c29carecoordination coordination

rename c30complaintsaboutthehealthplan complaints
rename c31beneficiaryaccessandperforman problems
rename c32memberschoosingtoleavetheplan switching
rename c33improvement improvement

rename c34planmakestimelydecisionsabout timely_appeals
rename c35reviewingappealsdecisions review_appeals
rename c36callcenterforeignlanguageinte phone_service
rename c37enrollmenttimeliness timely_enrollment
save temp_stars_2013, replace


** 2014 Variable Names
use temp_stars_2014, clear
rename c01breastcancerscreening bc_screen
rename c02colorectalcancerscreening cr_screen
rename c03cardiovascularcarecholesterol cv_chol_screen
rename c04diabetescarecholesterolscreen diab_chol_screen
rename c05glaucomatesting g_test
rename c06annualfluvaccine flu
rename c07improvingormaintainingphysica physical_health
rename c08improvingormaintainingmentalh mental_health
rename c09monitoringphysicalactivity physical_monitor
rename c10adultbmiassessment bmi_assess

rename c11careforolderadultsmedicationr med_review
rename c12careforolderadultsfunctionals functional_status
rename c13careforolderadultspainscreeni pain_screen
rename c14osteoporosismanagementinwomen osteo_manage
rename c15diabetescareeyeexam diab_eye
rename c16diabetescarekidneydiseasemoni diab_kidney
rename c17diabetescarebloodsugarcontrol diab_bloodsugar
rename c18diabetescarecholesterolcontro diab_chol
rename c19controllingbloodpressure bp_control
rename c20rheumatoidarthritismanagement ra_manage
rename c21improvingbladdercontrol bladder_control
rename c22reducingtheriskoffalling fall_risk
rename c23planallcausereadmissions readmit

rename c24gettingneededcare needed_care
rename c25gettingappointmentsandcarequi care_quickly
rename c26customerservice cust_service
rename c27ratingofhealthcarequality rate_care
rename c28ratingofhealthplan rate_plan
rename c29carecoordination coordination

rename c30complaintsaboutthehealthplan complaints
rename c31beneficiaryaccessandperforman problems
rename c32memberschoosingtoleavetheplan switching
rename c33healthplanqualityimprovement improvement

rename c34planmakestimelydecisionsabout timely_appeals
rename c35reviewingappealsdecisions review_appeals
rename c36callcenterforeignlanguageinte phone_service
save temp_stars_2014, replace


** 2015 Variable Names
use temp_stars_2015, clear
rename c01colorectalcancerscreening cr_screen
rename c02cardiovascularcarecholesterol cv_chol_screen
rename c03diabetescarecholesterolscreen diab_chol_screen
rename c04annualfluvaccine flu
rename c05improvingormaintainingphysica physical_health
rename c06improvingormaintainingmentalh mental_health
rename c07monitoringphysicalactivity physical_monitor
rename c08adultbmiassessment bmi_assess

rename c09specialneedsplansnpcaremanage snp_manage
rename c10careforolderadultsmedicationr med_review
rename c11careforolderadultsfunctionals functional_status
rename c12careforolderadultspainassessm pain_screen
rename c13osteoporosismanagementinwomen osteo_manage
rename c14diabetescareeyeexam diab_eye
rename c15diabetescarekidneydiseasemoni diab_kidney
rename c16diabetescarebloodsugarcontrol diab_bloodsugar
rename c17diabetescarecholesterolcontro diab_chol
rename c18controllingbloodpressure bp_control
rename c19rheumatoidarthritismanagement ra_manage
rename c20improvingbladdercontrol bladder_control
rename c21reducingtheriskoffalling fall_risk
rename c22planallcausereadmissions readmit

rename c23gettingneededcare needed_care
rename c24gettingappointmentsandcarequi care_quickly
rename c25customerservice cust_service
rename c26ratingofhealthcarequality rate_care
rename c27ratingofhealthplan rate_plan
rename c28carecoordination coordination

rename c29complaintsaboutthehealthplan complaints
rename c30memberschoosingtoleavetheplan switching
rename c31healthplanqualityimprovement improvement

rename c32planmakestimelydecisionsabout timely_appeals
rename c33reviewingappealsdecisions review_appeals
save temp_stars_2015, replace

** Append Star Ratings
use temp_stars_2008, clear
forvalues t=2009(1)2015 {
  append using temp_stars_`t'
}

** Save Final Star Ratings Data
save "${DATA_FINAL}Star_Ratings.dta", replace
