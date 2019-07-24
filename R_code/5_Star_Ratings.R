##############################################################################
## Read in MA star rating data */
##############################################################################
source(paste(path.code,"\\rating_variables.R",sep=""),local=TRUE,echo=FALSE)

## Assign yearly datasets and clean star rating information

## 2008
ma.path.2008a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2008\\2008_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv",sep="")
star.data.2008a=read.csv(ma.path.2008a,skip=4,stringsAsFactors=FALSE,col.names=rating.vars.2008)

ma.path.2008b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2008\\2008_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv",sep="")
star.data.2008b=read.csv(ma.path.2008b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","contract_name","healthy","getting_care",
                                     "timely_care","chronic","appeal","new_contract"))


## 2009
ma.path.2009a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2009\\2009_Part_C_Report_Card_Master_Table_2009_11_30_stars.csv",sep="")
star.data.2009a=read.csv(ma.path.2009a,skip=4,stringsAsFactors=FALSE,col.names=rating.vars.2009)
star.data.2009a=as_tibble(sapply(star.data.2009a,mapvalues,
                                 from=c("1 out of 5 stars","2 out of 5 stars","3 out of 5 stars",
                                        "4 out of 5 stars","5 stars"), 
                                 to=c("1","2","3","4","5")))



ma.path.2009b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2009\\2009_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv",sep="")
star.data.2009b=read.csv(ma.path.2009b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","org_type","contract_name","org_marketing","partc_score"))



## 2010
ma.path.2010a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2010\\2010_Part_C_Report_Card_Master_Table_2009_11_30_domain.csv",sep="")
star.data.2010a=read.csv(ma.path.2010a,skip=4,stringsAsFactors=FALSE,col.names=rating.vars.2010)

ma.path.2010b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2010\\2010_Part_C_Report_Card_Master_Table_2009_11_30_summary.csv",sep="")
star.data.2010b=read.csv(ma.path.2010b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","org_type","contract_name","org_marketing","partc_score"))



## 2011
ma.path.2011a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2011\\2011_Part_C_Report_Card_Master_Table_2011_04_20_star.csv",sep="")
star.data.2011a=read.csv(ma.path.2011a,skip=5,stringsAsFactors=FALSE,col.names=rating.vars.2011)

ma.path.2011b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2011\\2011_Part_C_Report_Card_Master_Table_2011_04_20_summary.csv",sep="")
star.data.2011b=read.csv(ma.path.2011b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","org_type","contract_name","org_marketing","partc_lowstar",
                                     "partc_score","partcd_score"))


## 2012
ma.path.2012a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2012 Fall\\2012_Part_C_Report_Card_Master_Table_2011_11_01_star.csv",sep="")
star.data.2012a=read.csv(ma.path.2012a,skip=5,stringsAsFactors=FALSE,col.names=rating.vars.2012)

ma.path.2012b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2012 Fall\\2012_Part_C_Report_Card_Master_Table_2011_11_01_summary.csv",sep="")
star.data.2012b=read.csv(ma.path.2012b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","org_type","org_parent","org_marketing",
                                     "partc_score","partc_lowscore","partc_highscore",
                                     "partcd_score","partcd_lowscore","partcd_highscore"))


## 2013
ma.path.2013a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2013 Fall\\2013_Part_C_Report_Card_Master_Table_2012_10_17_star.csv",sep="")
star.data.2013a=read.csv(ma.path.2013a,skip=4,stringsAsFactors=FALSE,col.names=rating.vars.2013)

ma.path.2013b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2013 Fall\\2013_Part_C_Report_Card_Master_Table_2012_10_17_summary.csv",sep="")
star.data.2013b=read.csv(ma.path.2013b,skip=2,stringsAsFactors=FALSE,
                         col.names=c("contractid","org_type","org_marketing","contract_name",
                                     "org_parent",
                                     "partc_score","partc_lowscore","partc_highscore",
                                     "partcd_score","partcd_lowscore","partcd_highscore"))


## 2014
ma.path.2014a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2014 Fall\\2014_Part_C_Report_Card_Master_Table_2013_10_17_stars.csv",sep="")
star.data.2014a=read.csv(ma.path.2014a,skip=3,stringsAsFactors=FALSE,col.names=rating.vars.2014)

ma.path.2014b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\Part C 2014 Fall\\2014_Part_C_Report_Card_Master_Table_2013_10_17_summary.csv",sep="")
star.data.2014b=fread(ma.path.2014b,skip=2,stringsAsFactors=FALSE, select=c(1:9),
                         col.names=c("contractid","org_type","org_marketing","contract_name",
                                     "org_parent","snp","sanction",
                                     "partc_score","partcd_score"))


## 2015
ma.path.2015a=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2015 Fall\\2015_Report_Card_Master_Table_2014_10_03_stars.csv",sep="")
star.data.2015a=fread(ma.path.2015a,skip=3,stringsAsFactors=FALSE,select=c(1:38),col.names=rating.vars.2015)


ma.path.2015b=paste(path.data.ma,"\\MA Star Ratings\\Extracted Star Ratings\\2015 Fall\\2015_Report_Card_Master_Table_2014_10_03_summary.csv",sep="")
star.data.2015b=fread(ma.path.2015b,skip=2,stringsAsFactors=FALSE, select=c(1:10),
                      col.names=c("contractid","org_type","org_marketing","contract_name",
                                  "org_parent","snp","sanction",
                                  "partc_score","partdscore","partcd_score"))


## Read in yearly data
for (y in 2008:2015) {
  monthlist=get(paste("monthlist_",y,sep=""))
  step=0
  for (m in monthlist) {
    step=step+1
    
    ## Pull market penetration data by contract/month
    ma.path=paste(path.data.ma,"\\Monthly MA State and County Penetration\\Extracted Data\\State_County_Penetration_MA_",y,"_",m,".csv",sep="")
    pene.data=read.csv(ma.path,col.names=c("state","county","fips_state","fips_cnty","fips",
                                           "ssa_state","ssa_cnty","ssa","eligibles","enrolled",
                                           "penetration"),
                          stringsAsFactors=FALSE)
    
    ## Add month and year data
    pene.data = pene.data %>%
      mutate(month=m, year=y)
    
    ## Clean data to remove characters and destring
    pene.data = pene.data %>%
      mutate(eligibles=replace(eligibles,eligibles=="*",NA)) %>%
      mutate(enrolled=replace(enrolled,enrolled=="*",NA)) %>%
      mutate(fips=replace(fips,fips=="UK",NA)) %>%
      as.data.frame()

    pene.data = pene.data %>%
      mutate(eligibles=as.numeric(str_replace_all(eligibles,'\\,',''))) %>%
      mutate(enrolled=as.numeric(str_replace_all(enrolled,'\\,','')))
    
    pene.data = pene.data %>%
      mutate(eligibles=as.numeric(eligibles)) %>%
      mutate(enrolled=as.numeric(enrolled)) %>%
      mutate(fips=as.numeric(fips))
    
    if (step==1) {
      ma.penetration=pene.data
    } else {
      ma.penetration=rbind(ma.penetration,pene.data)
    }
  }
  
  
  ## Fill in missing fips codes (by state and county)
  ma.penetration = ma.penetration %>%
    group_by(state, county) %>%
    fill(fips)

  ## Collapse to yearly data
  ma.penetration = ma.penetration %>%
    group_by(fips,state,county) %>%
    summarize(avg_eligibles=mean(eligibles),sd_eligibles=sd(eligibles),
              min_eligibles=min(eligibles),max_eligibles=max(eligibles),
              first_eligibles=first(eligibles),last_eligibles=last(eligibles),
              avg_enrolled=mean(enrolled),sd_enrolled=sd(enrolled),
              min_enrolled=min(enrolled),max_enrolled=max(enrolled),
              first_enrolled=first(enrolled),last_enrolled=last(enrolled),              
              year=last(year),ssa=first(ssa))
  
  assign(paste("ma.pene.",y,sep=""),ma.penetration)  
}

ma.penetration.data=rbind(ma.pene.2008,ma.pene.2009,ma.pene.2010,
                          ma.pene.2011,ma.pene.2012,ma.pene.2013,ma.pene.2014,ma.pene.2015)
write_tsv(ma.penetration.data,path=paste(path.data.final,"\\MA_Penetration.txt",sep=""),append=FALSE,col_names=TRUE)
