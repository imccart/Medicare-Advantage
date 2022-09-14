
# Import data -------------------------------------------------------------

bench.data=read_csv("data/input/benchmarks/ratebook2009/countyrate2009.csv",
                    skip=9,
                    col_names=c("ssa","state","county_name","aged_parta",
                                "aged_partb","disabled_parta","disabled_partb",
                                "esrd_ab","risk_ab"))

final.benchmark = bench.data %>%
  select(ssa,aged_parta,aged_partb,risk_ab) %>%
  mutate(risk_star5=NA_real_, risk_star45=NA_real_, risk_star4=NA_real_,
         risk_star35=NA_real_, risk_star3=NA_real_, risk_star25=NA_real_,
         risk_bonus5=NA_real_, risk_bonus35=NA_real_, risk_bonus0=NA_real_,
         year=2009)
