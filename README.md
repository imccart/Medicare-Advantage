# Medicare Advantage
This describes all of my primary Medicare Advantage (MA) datasets and code files. Project-specific uses of these data are treated as their own repositories and will be cited here over time. This is a living document and changes regularly.

## Master Do File
Each of the relevant data sources are available individually and discussed in more detail below. Just scroll down to the [Raw Data Sources](https://github.com/imccart/Medicare-Advantage#raw-data-sources). All of these files can also be called as part of a main data file, [_BuildFinalData.do](https://github.com/imccart/Medicare-Advantage/blob/main/stata_code/_BuildFinalData.do) for Stata and [_BuildFinalData.r](https://github.com/imccart/Medicare-Advantage/blob/main/R_code/_BuildFinalData.R) in R. I name these files so that they appear (by default) in Windows folders in a way that makes sense to me. So the main do file begins with an underscore, and the individual do files are numbered. This is just personal preference but helps me to keep things in order. 

Since initially creating this repository, I've moved to `R` from `Stata`. The `R` code files are maintained and compile MA data through 2024. The `Stata` code files only work with data through 2015. The `R` code files also build yearly MA datasets, rather than one giant dataset as I was originally doing in the `Stata` files.

## Raw Data Sources
All of the raw data are publicly available from the Centers for Medicare and Medicaid Services (CMS) website, although navigating the different pages can be cumbersome. There is more information available than what I discuss here, but this is sufficient to create a panel of MA plans/contracts/insurers by county over several years, complete with plan characteristics, quality ratings, and plan enrollments.

Below, I introduce files in the order in which I've found things to be easiest to work with, but there's no magic order that needs to be followed. 

1. [Monthly Plan Enrollment Data](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData/Monthly-Enrollment-by-Contract-Plan-State-County.html)

   The monthly enrollment data by contract/plan/state/county (CPSC) are the most comprehensive enrollment files, providingplan-level enrollments each month. Consistent with CMS data restrictions, the data are only provided for plans and months in which at least 11 beneficiaries enrolled in the plan. In all other cases, the enrollment data are indicated as missing.
   
   Stata .do file to organize CPSC enrollment data is available here: [1_Plan_Data.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/1_Plan_Data.do)
   
   R script to organize CPSC enrollment data is available here: [1_plan-data.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/1_plan-data.R)


2. [Service Area Files](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData/MA-Contract-Service-Area-by-State-County.html)

   The MA Contract Service Area files provide a list of contracts and the counties in which the contracts are approved to operate. Contracts may have enrollees in counties for which the contract is not approved due, for example, to beneficiaries that moved from one county to another and maintained their old plan. The files are available monthly. I usually look across months in a year for any month in which a contract was approved. If such a month exists, then I flag that contract/county as "approved" and ultimately merge those approved contract/counties with other plan-level data.
   
   Stata .do file to organize the service area files is available here: [2_Service_Areas.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/2_Service_Areas.do)

   R script to organize the service area files is available here: [2_service-area.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/2_service-area.R)
   

3. [Plan Characteristics](https://www.cms.gov/Medicare/Prescription-Drug-Coverage/PrescriptionDrugCovGenIn/index)

   The MA Landscape Files provide data on several plan characteristics. Note that there are separate folders for stand-along prescription drug plans (PDPs), special needs plans (SNPs), MA plans, and MA+PD plans. The accompanying code files focus only on MA and MA+PD plans. Also note that another source for similar information is in the Plan Benefits Data files. Those files are more comprehensive but also significantly harder to work with. I've found the landscape files to have all of the most important information, as well as being much more accessible.
   
   Stata .do file to organize plan premiums and other characteristics is available here: [3_Plan_Characteristics.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/3_Plan_Characteristics.do)
   
   R scripts to organize plan premiums and other characteristics are available here. Due to slight differences in variables and file structures over time, I've created separate code files for each year of the data. Just change the year at the end of the file path for the correct code file, as needed: [3_plan-characteristics-2007.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/3_plan-characteristics-2007.R) through [3_plan-characteristics-2019.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/3_plan-characteristics-2019.R)



4. [Penetration Files](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData/MA-State-County-Penetration.html)

   The MA penetration files provide the overall MA share for each county and month. These data are useful since plan-level enrollments are masked for plans with too few enrollees. As such, summing the plan-level enrollments will always underestimate the total number of MA enrollees in a county. The MA penetration files therefore provide a direct measure of the size of the MA market in each county. Note that these data are only available from CMS beginning in 2008.
   
   Stata .do file to organize the penetration files is available here: [4_Penetration_Files.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/4_Penetration_Files.do)

   R script to organize the penetration files is available here: [4_penetration.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/4_penetration.R)

   
5. [Star Ratings](https://www.cms.gov/medicare/prescription-drug-coverage/prescriptiondrugcovgenin/performancedata.html)

   The MA star ratings data are available as part of the Part C and D Performance Data. The data are not in a good analytical format and the variable names differ over time. In the associated code files, I've renamed variables so that sufficiently similar data are given the same name across all years of data.
   
   Stata .do file to organize the star ratings data is available here: [5_Star_Ratings.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/5_Star_Ratings.do)

   R scripts to organize the star ratings data are available here. Due to slight differences in variables and file structures over time, I've created separate code files for each year of the data. Just change the year at the end of the file path for the correct code file, as needed: [5_star-ratings-2008.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/5_star-ratings-2008.R) through [5_star-ratings-2019.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/5_star-ratings-2019.R)


6. [CMS Payment Data](https://www.cms.gov/Medicare/Medicare-Advantage/Plan-Payment/Plan-Payment-Data.html)

   CMS pays MA plans based on their bid and the county-level benchmarks. The final risk-adjusted payments (per beneficiary) are available on the CMS website.
   
   Stata .do file to organize the CMS payment and rebate data is available here:
   [6_Risk_Rebates.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/6_Risk_Rebates.do)

   R scripts to organize the CMS payment and rebate data are available here. Due to slight differences in variables and file structures over time, I've created separate code files for each year of the data. Just change the year at the end of the file path for the correct code file, as needed:
   [6_risk-rebates-2006.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/6_risk-rebates-2006.R) through [6_risk-rebates-2019.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/6_risk-rebates-2019.R)

   
7. [MA Benchmark Rates](https://www.cms.gov/Medicare/Health-Plans/MedicareAdvtgSpecRateStats/Ratebooks-and-Supporting-Data.html)

   CMS sets benchmarks for each county, to which plan bids are assessed when determining final premiums. These benchmark formulas are adjusted regularly but are legislatively defined. Details of the benchmarks and underlying data are available at the link above.
   
   Stata .do file to organize the benchmark rates is available here: [7_MA_Benchmark.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/7_MA_Benchmark.do)

   R scripts to organize the benchmark rates are available here. Due to slight differences in variables and file structures over time, I've created separate code files for each year of the data. Just change the year at the end of the file path for the correct code file, as needed: [7_benchmarks-2007.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/7_benchmarks-2007.R) through [7_benchmarks-2019.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/7_benchmarks-2019.R)

   
8. [CMS Fee-for-service Costs](https://www.cms.gov/Medicare/Health-Plans/MedicareAdvtgSpecRateStats/FFS-Data.html)

   CMS also publishes average fee-for-service (FFS) costs for each county, which is sometimes useful as a proxy for insurer's costs in MA (although the patient population remains very different between Traditional Medicare FFS and Medicare Advantage). Data specifically on the 65+ population was available through 2014, but CMS now only provides the combined "aged" and disabled enrollment and reimbursement figures. Due to the change in data from 2014 to 2015, I use the total (aged+disabled) enrollment and reimbursement figures when working with data that spans before and after 2015.
   
   Stata .do file to organize the CMS FFS cost data is available here:
   [8_FFS_Costs.do](https://github.com/imccart/Medicare-Advantage/blob/master/stata_code/8_FFS_Costs.do)
   
   R scripts to organize the CMS FFS cost data are available here. Due to slight differences in variables and file structures over time, I've created separate code files for each year of the data. Just change the year at the end of the file path for the correct code file, as needed:
   [8_ffs-costs-2007.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/8_ffs-costs-2007.R) through [8_ffs-costs-2019.R](https://github.com/imccart/Medicare-Advantage/blob/master/R_code/8_ffs-costs-2019.R).