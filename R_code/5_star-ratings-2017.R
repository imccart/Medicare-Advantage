
# Import data -------------------------------------------------------------

ma.path.a <- "data/input/star-ratings/Extracted Star Ratings/2017 Fall/2017_Report_Card_Master_Table_2016_10_26_stars.csv"
star.data.a <- fread(ma.path.a,
                         skip=4,
                         stringsAsFactors=FALSE,
                         select=c(1:37),
                         col.names=rating.vars.2017)
star.data.a <- star.data.a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)


ma.path.b <- "data/input/star-ratings/Extracted Star Ratings/2017 Fall/2017_Report_Card_Master_Table_2016_10_26_summary.csv"
star.data.b <- fread(ma.path.b,
                         skip=2,
                         stringsAsFactors=FALSE, 
                         select=c(1:10),
                         col.names=c("contractid","org_type","org_marketing","contract_name",
                                     "org_parent","snp","sanction",
                                     "partc_score","partdscore","partcd_score"))
star.data.b <- star.data.b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  select(contractid, new_contract, partc_score, partcd_score)

final.star.ratings <- star.data.a %>%
  select(-contract_name, -org_type, -org_marketing) %>%  
  left_join(star.data.b, by=c("contractid")) %>%
  mutate(year=2017)
