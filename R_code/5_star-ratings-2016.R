
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/ma/star-ratings/Extracted Star Ratings/2016 Fall/2016_Report_Card_Master_Table_2015_10_02_stars.csv"
star.data.a <- fread(
  ma.path.a,
  skip = 4,
  stringsAsFactors=FALSE,
  select=c(1:37),
  col.names=rating.vars.2016,
  na = c("", "NA", "*")
) %>%
  mutate(across(
    -any_of(c("contractid","org_type","contract_name","org_marketing","org_parent")),
    ~ parse_number(as.character(.))
  ))


ma.path.b <- "data/input/ma/star-ratings/Extracted Star Ratings/2016 Fall/2016_Report_Card_Master_Table_2015_10_02_summary.csv"
star.data.b <- fread(
  ma.path.b,
  skip = 2,
  stringsAsFactors=FALSE, 
  select=c(1:10),
  col.names=c("contractid","org_type","org_marketing","contract_name", "org_parent","snp","sanction", "partc_score","partd_score","partcd_score"),
  na = c("", "NA", "*")
) %>%
  mutate(
    new_contract=ifelse(partc_score=="Plan too new to be measured",1, ifelse(partcd_score=="Plan too new to be measured",1,0)),
    partc_score  = ifelse(new_contract == 1, NA_real_, parse_number(as.character(partc_score))),
    partcd_score = ifelse(new_contract == 1, NA_real_, parse_number(as.character(partcd_score)))
  ) %>%
  select(contractid, new_contract, partc_score, partcd_score)

final.star.ratings <- as_tibble(star.data.a) %>%
  select(-contract_name, -org_type, -org_marketing) %>%  
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2016)
