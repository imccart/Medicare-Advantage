***********************************************************************************
** 2007 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2007\countyrate2007.csv", comma clear
keep v1 v4 v5 v9
drop in 1/9
rename v1 code
rename v4 PartA
rename v5 PartB
rename v9 Risk
foreach x of varlist code PartA PartB Risk {
  destring `x', replace
}
gen Year=2007
save temp_bench_2007, replace

***********************************************************************************
** 2008 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2008\countyrate2008.csv", comma clear
keep v1 v4 v5 v9
drop in 1/10
rename v1 code
rename v4 PartA
rename v5 PartB
rename v9 Risk
foreach x of varlist code PartA PartB Risk {
  destring `x', replace
}
gen Year=2008
save temp_bench_2008, replace

***********************************************************************************
** 2009 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2009\countyrate2009.csv", comma clear
keep v1 v4 v5 v9
drop in 1/7
rename v1 code
rename v4 PartA
rename v5 PartB
rename v9 Risk
foreach x of varlist code PartA PartB Risk {
  destring `x', replace
}
gen Year=2009
save temp_bench_2009, replace

***********************************************************************************
** 2010 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2010\CountyRate2010.csv", comma clear
keep v1 v4 v5 v9
drop in 1/5
rename v1 code
rename v4 PartA
rename v5 PartB
rename v9 Risk
foreach x of varlist code PartA PartB Risk {
  destring `x', replace
}
gen Year=2010
save temp_bench_2010, replace


***********************************************************************************
** 2011 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2011\CountyRate2011.csv", comma clear
keep v1 v4 v5 v9
drop in 1/7
rename v1 code
rename v4 PartA
rename v5 PartB
rename v9 Risk
foreach x of varlist code PartA PartB Risk {
  destring `x', replace
}
gen Year=2011
save temp_bench_2011, replace


***********************************************************************************
** 2012 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2012\CountyRate2012.csv", comma clear
keep v1 v4 v5 v6 v7 v8 v9
drop in 1/5
rename v1 code
rename v4 Risk_Star50
rename v5 Risk_Star45
rename v6 Risk_Star40
rename v7 Risk_Star35
rename v8 Risk_Star30
rename v9 Risk_Star25
foreach x of varlist code Risk_* {
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen Year=2012
save temp_bench_2012, replace


***********************************************************************************
** 2013 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2013\CountyRate2013.csv", comma clear
keep v1 v4 v5 v6 v7 v8 v9
drop in 1/4
rename v1 code
rename v4 Risk_Star50
rename v5 Risk_Star45
rename v6 Risk_Star40
rename v7 Risk_Star35
rename v8 Risk_Star30
rename v9 Risk_Star25
foreach x of varlist code Risk_* {
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen Year=2013
save temp_bench_2013, replace


***********************************************************************************
** 2014 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2014\CountyRate2014.csv", comma clear
keep v1 v4 v5 v6 v7 v8 v9
drop in 1/2
rename v1 code
rename v4 Risk_Star50
rename v5 Risk_Star45
rename v6 Risk_Star40
rename v7 Risk_Star35
rename v8 Risk_Star30
rename v9 Risk_Star25
foreach x of varlist code Risk_* {
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen Year=2014
save temp_bench_2014, replace


***********************************************************************************
** 2015 files
insheet using "${DATA_MA}MA Benchmarks\ratebook2015\CSV\CountyRate2015.csv", comma clear
keep v1 v4 v5 v6
drop in 1/3
rename v1 code
rename v4 Risk_Bonus5
rename v5 Risk_Bonus35
rename v6 Risk_Bonus0
gen bad_code=(strpos(code,"X")>0)
drop if bad_code==1
drop bad_code
foreach x of varlist code Risk_* {
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen Year=2015
save temp_bench_2015, replace

***********************************************************************************
** Append Yearly Data
use temp_bench_2007, clear
forvalues t=2008(1)2015 {
  append using temp_bench_`t'
}
drop if code==.
rename code ssa
rename Year year
save "${DATA_FINAL}MA_Benchmark.dta", replace
