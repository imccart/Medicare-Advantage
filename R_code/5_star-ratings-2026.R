
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/ma/star-ratings/Extracted Star Ratings/2026/2026 Star Ratings Data Table - Measure Stars (Oct 8 2025).csv"
star.data.a <- fread(
  ma.path.a,
  skip = 4,
  stringsAsFactors=FALSE,
  select=c(1:38),
  col.names=rating.vars.2026,
  na = c("", "NA", "*")
) %>%
  mutate(across(
    -any_of(c("contractid","org_type","contract_name","org_marketing","org_parent")),
    ~ parse_number(as.character(.))
  ))


ma.path.b <- "data/input/ma/star-ratings/Extracted Star Ratings/2026/2026 Star Ratings Data Table - Summary Ratings (July 22 2026).xlsx"
star.data.b <- read_xlsx(
  ma.path.b,
  range = cell_limits(c(3, 1), c(NA, 11)),
  col_names = FALSE,
  col_types = "text"
) %>%
  set_names("contractid","org_type","contract_name","org_marketing","org_parent","snp","disaster_2023","disaster_2024","partc_score","partd_score","partcd_score") %>%
  mutate(across(everything(), str_trim),
         new_contract=ifelse(partc_score=="Plan too new to be measured",1, ifelse(partcd_score=="Plan too new to be measured",1,0)),
         partc_score  = ifelse(new_contract == 1, NA_real_, parse_number(partc_score)),
         partcd_score = ifelse(new_contract == 1, NA_real_, parse_number(partcd_score))
  ) %>%
  select(contractid, new_contract, partc_score, partcd_score)

final.star.ratings <- as_tibble(star.data.a) %>%
  select(-contract_name, -org_type, -org_marketing) %>%  
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2026)
