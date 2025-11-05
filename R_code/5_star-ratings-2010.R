
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/ma/star-ratings/Extracted Star Ratings/2010/2010_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv"
star.data.a <- read_csv(
  ma.path.a,
  skip = 4,
  col_names = rating.vars.2010,
  na = c("", "NA", "*")
) %>%
  mutate(across(
    -any_of(c("contractid","org_type","contract_name","org_marketing")),
    ~ parse_number(as.character(.))
  ))


ma.path.b <- "data/input/ma/star-ratings/Extracted Star Ratings/2010/2010_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv"
star.data.b <- read_csv(
  ma.path.b,
  skip = 2,
  col_names = c("contractid","org_type","contract_name","org_marketing","partc_score"),
  na = c("", "NA", "*")
) %>%
  mutate(
    new_contract = ifelse(partc_score == "Plan too new to be measured", 1, 0),
    partc_score  = ifelse(new_contract == 1, NA_real_, parse_number(as.character(partc_score)))
  ) %>%
  select(contractid, new_contract, partc_score) %>%
  mutate(partcd_score = NA_real_)

final.star.ratings <- star.data.a %>%
  select(-contract_name, -org_type, -org_marketing) %>%  
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2010)
