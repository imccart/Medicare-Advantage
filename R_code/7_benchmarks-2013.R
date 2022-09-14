
# Import data -------------------------------------------------------------

bench.data=read_csv("data/input/benchmarks/ratebook2013/CountyRate2013.csv",
                    skip=4,
                    col_names=c("ssa","state","county_name","risk_star5",
                                "risk_star45","risk_star4","risk_star35",
                                "risk_star3","risk_star25","esrd_ab"))

final.benchmark = bench.data %>%
  select(ssa,risk_star5,risk_star45,risk_star4,risk_star35,risk_star3,risk_star25) %>%
  mutate(aged_parta=NA_real_, aged_partb=NA_real_, risk_ab=NA_real_,
         risk_bonus5=NA_real_, risk_bonus35=NA_real_, risk_bonus0=NA_real_,
         year=2013)
