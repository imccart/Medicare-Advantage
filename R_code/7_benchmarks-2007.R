
# Import data -------------------------------------------------------------

bench.data=read_csv("data/input/benchmarks/ratebook2007/countyrate2007.csv",
                    skip=9,
                    col_names=c("ssa","state","county_name","aged_parta",
                                "aged_partb","disabled_parta","disabled_partb",
                                "esrd_ab","risk_ab"))

final.benchmark = bench.data %>%
  select(ssa,aged_parta,aged_partb,risk_ab) %>%
  mutate(risk_star5=NA, risk_star45=NA, risk_star4=NA,
         risk_star35=NA, risk_star3=NA, risk_star25=NA,
         risk_bonus5=NA, risk_bonus35=NA, risk_bonus0=NA,
         year=2007)
