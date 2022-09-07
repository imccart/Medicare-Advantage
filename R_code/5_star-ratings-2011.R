
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/star-ratings/Extracted Star Ratings/2011/2011_Part_C_Report_Card_Master_Table_2011_04_20_star.csv"
star.data.a <- read_csv(ma.path.a,
                            skip=5,
                            col_names=rating.vars.2011)
star.data.a <- as_tibble(sapply(star.data.a,plyr::mapvalues,
                                    from=c("1 stars","2 stars","3 stars",
                                           "4 stars","5 stars"), 
                                    to=c("1","2","3","4","5")))
star.data.a <- star.data.a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing")),
            as.numeric)

ma.path.b <- "data/input/star-ratings/Extracted Star Ratings/2011/2011_Part_C_Report_Card_Master_Table_2011_04_20_summary.csv"
star.data.b <- read_csv(ma.path.b,
                            skip=2,
                            col_names=c("contractid","org_type","contract_name","org_marketing","partc_lowstar",
                                        "partc_score","partcd_score"))
star.data.b <- star.data.b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=plyr::mapvalues(partc_score,
                                     from=c("1 out of 5 stars","1.5 out of 5 stars",
                                            "2 out of 5 stars","2.5 out of 5 stars",
                                            "3 out of 5 stars","3.5 out of 5 stars",
                                            "4 out of 5 stars","4.5 out of 5 stars",
                                            "5 stars"), 
                                     to=c("1","1.5","2","2.5","3","3.5","4","4.5","5"))) %>%
  mutate(partcd_score=plyr::mapvalues(partcd_score,
                                      from=c("1 out of 5 stars","1.5 out of 5 stars",
                                             "2 out of 5 stars","2.5 out of 5 stars",
                                             "3 out of 5 stars","3.5 out of 5 stars",
                                             "4 out of 5 stars","4.5 out of 5 stars",
                                             "5 stars"), 
                                      to=c("1","1.5","2","2.5","3","3.5","4","4.5","5"))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  mutate(low_score=as.numeric(ifelse(partc_lowstar=="Yes",1,0))) %>%
  select(contractid, new_contract, low_score, partc_score, partcd_score)

final.star.ratings <- star.data.a %>%
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2011)
