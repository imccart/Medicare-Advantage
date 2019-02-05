***********************************************************************************
insheet using "${DATA_FFS}CMS FFS Costs.csv", comma clear

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  destring `x', replace
}
rename code ssa
save "${DATA_FINAL}FFS_Costs.dta", replace
