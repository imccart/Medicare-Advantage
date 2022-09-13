
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/star-ratings/Extracted Star Ratings/2008/2008_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv"
star.data.a <- read_csv(ma.path.a,
                         skip=4,
                         col_names=rating.vars.2008)

ma.path.b <- "data/input/star-ratings/Extracted Star Ratings/2008/2008_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv"
star.data.b <- read_csv(ma.path.b,
                         skip=2,
                         col_names=c("contractid","contract_name","healthy","getting_care",
                                     "timely_care","chronic","appeal","new_contract"))
star.data.b <- as_tibble(star.data.b) %>%
  mutate(new_contract=replace(new_contract,is.na(new_contract),0)) %>%
  select("contractid","new_contract")

final.star.ratings <- (star.data.a %>% select(-new_contract)) %>%
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2008)
