##############################################################################
## Read in MA star rating data 
##############################################################################
source(paste0(path.code,"\\rating_variables.R"),local=TRUE,echo=FALSE)

## Assign yearly datasets and clean star rating information

## 2008
ma.path.2008a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2008\\2008_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv")
star.data.2008a=read_csv(ma.path.2008a,
                         skip=4,
                         col_names=rating.vars.2008)

ma.path.2008b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2008\\2008_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv")
star.data.2008b=read_csv(ma.path.2008b,
                         skip=2,
                         col_names=c("contractid","contract_name","healthy","getting_care",
                                     "timely_care","chronic","appeal","new_contract"))
star.data.2008b = as_tibble(star.data.2008b) %>%
  mutate(new_contract=replace(new_contract,is.na(new_contract),0)) %>%
  select("contractid","new_contract")

star.data.2008 = star.data.2008a %>%
  left_join(star.data.2008b, by=c("contractid")) %>%
  mutate(year=2008)


## 2009
ma.path.2009a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2009\\2009_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv")
star.data.2009a=read_csv(ma.path.2009a,
                         skip=4,
                         col_names=rating.vars.2009)
star.data.2009a=as_tibble(sapply(star.data.2009a,plyr::mapvalues,
                                 from=c("1 out of 5 stars","2 out of 5 stars","3 out of 5 stars",
                                        "4 out of 5 stars","5 stars"), 
                                 to=c("1","2","3","4","5")))
star.data.2009a = star.data.2009a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing")),
            as.numeric)

ma.path.2009b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2009\\2009_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv")
star.data.2009b=read_csv(ma.path.2009b,
                         skip=2,
                         col_names=c("contractid","org_type","contract_name","org_marketing","partc_score"))
star.data.2009b = star.data.2009b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,0)) %>%
  mutate(partc_score=plyr::mapvalues(partc_score,
                               from=c("1 out of 5 stars","1.5 out of 5 stars",
                                      "2 out of 5 stars","2.5 out of 5 stars",
                                      "3 out of 5 stars","3.5 out of 5 stars",
                                      "4 out of 5 stars","4.5 out of 5 stars",
                                      "5 stars"), 
                               to=c("1","1.5","2","2.5","3","3.5","4","4.5","5"))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  select(contractid, new_contract, partc_score)

star.data.2009 = star.data.2009a %>%
  left_join(star.data.2009b, by=c("contractid")) %>%
  mutate(year=2009)


## 2010
ma.path.2010a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2010\\2010_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv")
star.data.2010a=read_csv(ma.path.2010a,
                         skip=4,
                         col_names=rating.vars.2010)
star.data.2010a=as_tibble(sapply(star.data.2010a,plyr::mapvalues,
                                 from=c("1 out of 5 stars","2 out of 5 stars","3 out of 5 stars",
                                        "4 out of 5 stars","5 stars"), 
                                 to=c("1","2","3","4","5")))
star.data.2010a = star.data.2010a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing")),
            as.numeric)



ma.path.2010b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2010\\2010_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv")
star.data.2010b=read_csv(ma.path.2010b,
                         skip=2,
                         col_names=c("contractid","org_type","contract_name","org_marketing","partc_score"))
star.data.2010b = star.data.2010b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,0)) %>%
  mutate(partc_score=plyr::mapvalues(partc_score,
                               from=c("1 out of 5 stars","1.5 out of 5 stars",
                                      "2 out of 5 stars","2.5 out of 5 stars",
                                      "3 out of 5 stars","3.5 out of 5 stars",
                                      "4 out of 5 stars","4.5 out of 5 stars",
                                      "5 stars"), 
                               to=c("1","1.5","2","2.5","3","3.5","4","4.5","5"))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  select(contractid, new_contract, partc_score)

star.data.2010 = star.data.2010a %>%
  left_join(star.data.2010b, by=c("contractid")) %>%
  mutate(year=2010)


## 2011
ma.path.2011a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2011\\2011_Part_C_Report_Card_Master_Table_2011_04_20_star.csv")
star.data.2011a=read_csv(ma.path.2011a,
                         skip=5,
                         col_names=rating.vars.2011)
star.data.2011a=as_tibble(sapply(star.data.2011a,plyr::mapvalues,
                                 from=c("1 stars","2 stars","3 stars",
                                        "4 stars","5 stars"), 
                                 to=c("1","2","3","4","5")))
star.data.2011a = star.data.2011a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing")),
            as.numeric)

ma.path.2011b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2011\\2011_Part_C_Report_Card_Master_Table_2011_04_20_summary.csv")
star.data.2011b=read_csv(ma.path.2011b,
                         skip=2,
                         col_names=c("contractid","org_type","contract_name","org_marketing","partc_lowstar",
                                     "partc_score","partcd_score"))
star.data.2011b = star.data.2011b %>%
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

star.data.2011 = star.data.2011a %>%
  left_join(star.data.2011b, by=c("contractid")) %>%
  mutate(year=2011)




## 2012
ma.path.2012a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2012 Fall\\2012_Part_C_Report_Card_Master_Table_2011_11_01_star.csv")
star.data.2012a=read_csv(ma.path.2012a,
                         skip=5,
                         col_names=rating.vars.2012)
star.data.2012a = star.data.2012a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)


ma.path.2012b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2012 Fall\\2012_Part_C_Report_Card_Master_Table_2011_11_01_summary.csv")
star.data.2012b=read_csv(ma.path.2012b,
                         skip=2,
                         col_names=c("contractid","org_type","org_parent","org_marketing",
                                     "partc_score","partc_lowscore","partc_highscore",
                                     "partcd_score","partcd_lowscore","partcd_highscore"))
star.data.2012b = star.data.2012b %>%
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
  mutate(low_score=as.numeric(ifelse(partc_lowscore=="Yes",1,0))) %>%
  select(contractid, new_contract, low_score, partc_score, partcd_score)

star.data.2012 = star.data.2012a %>%
  left_join(star.data.2012b, by=c("contractid")) %>%
  mutate(year=2012)




## 2013
ma.path.2013a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2013 Fall\\2013_Part_C_Report_Card_Master_Table_2012_10_17_star.csv")
star.data.2013a=read_csv(ma.path.2013a,
                         skip=4,
                         col_names=rating.vars.2013)
star.data.2013a = star.data.2013a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)

ma.path.2013b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2013 Fall\\2013_Part_C_Report_Card_Master_Table_2012_10_17_summary.csv")
star.data.2013b=read_csv(ma.path.2013b,
                         skip=2,
                         col_names=c("contractid","org_type","org_marketing","contract_name",
                                     "org_parent",
                                     "partc_score","partc_lowscore","partc_highscore",
                                     "partcd_score","partcd_lowscore","partcd_highscore"))
star.data.2013b = star.data.2013b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  mutate(low_score=as.numeric(ifelse(partc_lowscore=="Yes",1,0))) %>%
  select(contractid, new_contract, low_score, partc_score, partcd_score)

star.data.2013 = star.data.2013a %>%
  left_join(star.data.2013b, by=c("contractid")) %>%
  mutate(year=2013)



## 2014
ma.path.2014a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2014 Fall\\2014_Part_C_Report_Card_Master_Table_2013_10_17_stars.csv")
star.data.2014a=read_csv(ma.path.2014a,
                         skip=3,
                         col_names=rating.vars.2014)
star.data.2014a = star.data.2014a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)


ma.path.2014b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2014 Fall\\2014_Part_C_Report_Card_Master_Table_2013_10_17_summary.csv")
star.data.2014b=fread(ma.path.2014b,
                      skip=2,
                      stringsAsFactors=FALSE, 
                      select=c(1:9),
                      col.names=c("contractid","org_type","org_marketing","contract_name",
                                  "org_parent","snp","sanction",
                                  "partc_score","partcd_score"))
star.data.2014b = star.data.2014b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  select(contractid, new_contract, partc_score, partcd_score)

star.data.2014 = star.data.2014a %>%
  left_join(star.data.2014b, by=c("contractid")) %>%
  mutate(year=2014)


## 2015
ma.path.2015a=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2015 Fall\\2015_Report_Card_Master_Table_2014_10_03_stars.csv")
star.data.2015a=fread(ma.path.2015a,
                      skip=4,
                      stringsAsFactors=FALSE,
                      select=c(1:38),
                      col.names=rating.vars.2015)
star.data.2015a = star.data.2015a %>%
  mutate_at(vars(-one_of("contractid","org_type","contract_name","org_marketing","org_parent")),
            as.numeric)


ma.path.2015b=paste0(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2015 Fall\\2015_Report_Card_Master_Table_2014_10_03_summary.csv")
star.data.2015b=fread(ma.path.2015b,
                      skip=2,
                      stringsAsFactors=FALSE, 
                      select=c(1:10),
                      col.names=c("contractid","org_type","org_marketing","contract_name",
                                  "org_parent","snp","sanction",
                                  "partc_score","partdscore","partcd_score"))
star.data.2015b = star.data.2015b %>%
  mutate(new_contract=ifelse(partc_score=="Plan too new to be measured",1,
                             ifelse(partcd_score=="Plan too new to be measured",1,0))) %>%
  mutate(partc_score=as.numeric(partc_score)) %>%
  mutate(partcd_score=as.numeric(partcd_score)) %>%
  select(contractid, new_contract, partc_score, partcd_score)

star.data.2015 = star.data.2015a %>%
  left_join(star.data.2015b, by=c("contractid")) %>%
  mutate(year=2015)




star.ratings=plyr::rbind.fill(star.data.2008, star.data.2009, star.data.2010, star.data.2011,
                   star.data.2012, star.data.2013, star.data.2014, star.data.2015)
write_tsv(star.ratings,path=paste(path.data.final,"\\Star_Ratings.txt",sep=""),append=FALSE,col_names=TRUE)
write_rds(star.ratings,paste(path.data.final,"\\star_ratings.rds",sep=""))