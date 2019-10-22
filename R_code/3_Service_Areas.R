##############################################################################
## Read in service area data */
##############################################################################


#########################################################################
## Set local "month lists" to identify different files relevant for each year
## Month lists differ by year just in case you work with data that are only available
## in a fraction of a year, which often happens for new data as new monthly releases
## are made. Some data sources are also only available in certain years.
#########################################################################

monthlist_2006=c("10", "11", "12")
monthlist_2007=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2008=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2009=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2010=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2011=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2012=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2013=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2014=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
monthlist_2015=c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")


## Read in monthly files, append to yearly file, fill in missing info, and collapse down to yearly file
for (y in 2006:2015) {
  monthlist=get(paste0("monthlist_",y))
  step=0
  for (m in monthlist) {
    step=step+1
    
    ## Pull service area data by contract/month
    ma.path=paste0(path.data.ma,"\\Monthly MA Contract Service Area\\Extracted Data\\MA_Cnty_SA_",y,"_",m,".csv")
    service.area=read_csv(ma.path,
                          col_names=c("contractid","org_name","org_type","plan_type","partial","eghp",
                                      "ssa","fips","county","state","notes"))
    service.area = service.area %>%
      mutate(month=m, year=y)
    if (step==1) {
      service.year=service.area
    } else {
      service.year=rbind(service.year,service.area)
    }
  }
  
  
  ## Fill in missing fips codes (by state and county)
  service.year = service.year %>%
    group_by(state, county) %>%
    fill(fips)

  ## Fill in missing plan type, org info, partial status, and eghp status (by contractid)
  service.year = service.year %>%
    group_by(contractid) %>%
    fill(plan_type, partial, eghp, org_type, org_name)
  

  ## Collapse to yearly data
  service.year = service.year %>%
    group_by(contractid, fips) %>%
    mutate(id_count=row_number())
  
  service.year = service.year %>%
    filter(id_count==1) %>%
    select(-c(id_count,month))

  
  assign(paste("service.area.",y,sep=""),service.year)  
}

contract.service.area=rbind(service.area.2006,service.area.2007,service.area.2008,service.area.2009,service.area.2010,
                            service.area.2011,service.area.2012,service.area.2013,service.area.2014,service.area.2015)
write_tsv(contract.service.area,path=paste(path.data.final,"\\Contract_Service_Area.txt",sep=""),append=FALSE,col_names=TRUE)
write_rds(contract.service.area,paste(path.data.final,"\\contract_service_area.rds",sep=""))