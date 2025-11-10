
# Import data -------------------------------------------------------------

bench.data <- read_csv("data/input/ma/benchmarks/ratebook2022/CountyRate2022.csv",
                    skip=3,
                    col_names=c("ssa","state","county_name",
                                "risk_bonus5","risk_bonus35",
                                "risk_bonus0","esrd_ab"), na="#N/A")

final.benchmark <- bench.data %>%
  select(ssa,risk_bonus5,risk_bonus35,risk_bonus0) %>%
  mutate(risk_star5=NA_real_, risk_star45=NA_real_, risk_star4=NA_real_,
         risk_star35=NA_real_, risk_star3=NA_real_, risk_star25=NA_real_,
         aged_parta=NA_real_, aged_partb=NA_real_, risk_ab=NA_real_,
         year=2022)
