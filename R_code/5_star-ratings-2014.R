
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/star-ratings/Extracted Star Ratings/Part C 2014 Fall/2014_Part_C_Report_Card_Master_Table_2013_10_17_stars.csv"
star.data.a <- read_csv(ma.path.a,
                            skip=3,
                            col_names=rating.vars.2014)
star.data.a <- star.data.a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)


ma.path.b <- "data/input/star-ratings/Extracted Star Ratings/Part C 2014 Fall/2014_Part_C_Report_Card_Master_Table_2013_10_17_summary.csv"
star.data.b <- fread(ma.path.b,
                         skip=2,
                         stringsAsFactors=FALSE, 
                         select=c(1:9),
                         col.names=c("contractid","org_type","org_marketing","contract_name",
                                     "org_parent","snp","sanction",
                                     "partc_score","partcd_score"))
star.data.b <- star.data.b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  select(contractid, new_contract, partc_score, partcd_score)

final.star.ratings <- star.data.a %>%
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2014)
