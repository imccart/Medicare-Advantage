
# Import data -------------------------------------------------------------

bench.data=read_csv("data/input/benchmarks/ratebook2016/CSV/CountyRate2016.csv",
                    skip=4,
                    col_names=c("ssa","state","county_name",
                                "risk_bonus5","risk_bonus35",
                                "risk_bonus0","esrd_ab"), na="#N/A")

bench.data = bench.data %>%
  select(ssa,risk_bonus5,risk_bonus35,risk_bonus0) %>%
  mutate(risk_star5=NA, risk_star45=NA, risk_star4=NA,
         risk_star35=NA, risk_star3=NA, risk_star25=NA,
         aged_parta=NA, aged_partb=NA, risk_ab=NA,
         year=2016)
