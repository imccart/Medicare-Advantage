
# Import data -------------------------------------------------------------

bench.data=read_csv("data/input/benchmarks/ratebook2013/CountyRate2013.csv",
                    skip=4,
                    col_names=c("ssa","state","county_name","risk_star5",
                                "risk_star45","risk_star4","risk_star35",
                                "risk_star3","risk_star25","esrd_ab"))

bench.data = bench.data %>%
  select(ssa,risk_star5,risk_star45,risk_star4,risk_star35,risk_star3,risk_star25) %>%
  mutate(aged_parta=NA, aged_partb=NA, risk_ab=NA,
         risk_bonus5=NA, risk_bonus35=NA, risk_bonus0=NA,
         year=2013)
