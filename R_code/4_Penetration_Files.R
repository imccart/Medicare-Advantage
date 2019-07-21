##############################################################################
## Read in service area data */
##############################################################################


#########################################################################
## Set local "month lists" to identify different files relevant for each year
## Month lists differ by year just in case you work with data that are only available
## in a fraction of a year, which often happens for new data as new monthly releases
## are made. Some data sources are also only available in certain years.
#########################################################################

monthlist_2008=c("06","07","08","09","10", "11", "12")
monthlist_2010=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2011=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2012=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2013=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2014=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2015=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")


## Read in monthly files, append to yearly file, fill in missing info, and collapse down to yearly file
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
