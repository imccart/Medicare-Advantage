
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/star-ratings/Extracted Star Ratings/Part C 2013 Fall/2013_Part_C_Report_Card_Master_Table_2012_10_17_Star.csv"
star.data.a <- read_csv(ma.path.a,
                            skip=4,
                            col_names=rating.vars.2013)
star.data.a <- star.data.a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)

ma.path.b <- "data/input/star-ratings/Extracted Star Ratings/Part C 2013 Fall/2013_Part_C_Report_Card_Master_Table_2012_10_17_Summary.csv"
star.data.b <- read_csv(ma.path.b,
                            skip=2,
                            col_names=c("contractid","org_type","org_marketing","contract_name",
                                        "org_parent",
                                        "partc_score","partc_lowscore","partc_highscore",
                                        "partcd_score","partcd_lowscore","partcd_highscore"))
star.data.b <- star.data.b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  mutate(low_score=as.numeric(ifelse(partc_lowscore=="Yes",1,0))) %>%
  select(contractid, new_contract, low_score, partc_score, partcd_score)

final.star.ratings <- star.data.a %>%
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2013)
