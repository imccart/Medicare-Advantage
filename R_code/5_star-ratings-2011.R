
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/ma/star-ratings/Extracted Star Ratings/2011/2011_Part_C_Report_Card_Master_Table_2011_04_20_star.csv"
star.data.a <- read_csv(
  ma.path.a,
  skip = 5,
  col_names = rating.vars.2011,
  na = c("", "NA", "*")
) %>%
  mutate(across(
    -any_of(c("contractid","org_type","contract_name","org_marketing")),
    ~ parse_number(as.character(.))
  ))

ma.path.b <- "data/input/ma/star-ratings/Extracted Star Ratings/2011/2011_Part_C_Report_Card_Master_Table_2011_04_20_summary.csv"
star.data.b <- read_csv(
  ma.path.b,
  skip = 2,
  col_names=c("contractid","org_type","contract_name","org_marketing","partc_lowstar","partc_score","partcd_score"),
  na = c("", "NA", "*")
) %>%
  mutate(
    new_contract=ifelse(partc_score=="Plan too new to be measured",1, ifelse(partcd_score=="Plan too new to be measured",1,0)),
    partc_score  = ifelse(new_contract == 1, NA_real_, parse_number(as.character(partc_score))),
    partcd_score = ifelse(new_contract == 1, NA_real_, parse_number(as.character(partcd_score))),
    low_score=as.numeric(ifelse(partc_lowstar=="Yes",1,0))
  ) %>%
  select(contractid, new_contract, low_score, partc_score, partcd_score)

final.star.ratings <- star.data.a %>%
  select(-contract_name, -org_type, -org_marketing) %>%  
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2011)
