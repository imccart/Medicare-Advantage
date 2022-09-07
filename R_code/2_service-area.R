
# Set month lists ---------------------------------------------------------

#########################################################################
## Set local "month lists" to identify different files relevant for each year
## Month lists differ by year just in case you work with data that are only available
## in a fraction of a year, which often happens for new data as new monthly releases
## are made. Some data sources are also only available in certain years.
#########################################################################

if (y==2006) {
  monthlist <- c("10", "11", "12")  
} else {
  monthlist <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")  
}



# Import monthly data -----------------------------------------------------

step <- 0
for (m in monthlist) {
  step <- step+1
    
  ## Pull service area data by contract/month
  ma.path <- paste0("data/input/service-area/Extracted Data/MA_Cnty_SA_",y,"_",m,".csv")
  service.area <- read_csv(ma.path,skip=1,
                        col_names=c("contractid","org_name","org_type","plan_type","partial","eghp",
                                    "ssa","fips","county","state","notes"),
                        col_types = cols(
                          contractid = col_character(),
                          org_name = col_character(),
                          org_type = col_character(),
                          plan_type = col_character(),
                          partial = col_logical(),
                          eghp = col_character(),
                          ssa = col_double(),
                          fips = col_double(),
                          county = col_character(),
                          notes = col_character()
                        ), na='*')
  
  service.area <- service.area %>%
    mutate(month=as.numeric(m), year=y)
  
  if (step==1) {
    service.year <- service.area
  } else {
    service.year <- rbind(service.year,service.area)
  }
}
  

# Tidy data ---------------------------------------------------------------

## Fill in missing fips codes (by state and county)
service.year <- service.year %>%
  group_by(state, county) %>%
  fill(fips)

## Fill in missing plan type, org info, partial status, and eghp status (by contractid)
service.year <- service.year %>%
  group_by(contractid) %>%
  fill(plan_type, partial, eghp, org_type, org_name)
  
## Collapse to yearly data
service.year <- service.year %>%
  group_by(contractid, fips) %>%
  mutate(id_count=row_number())
  
final.service.area <- service.year %>%
  filter(id_count==1) %>%
  select(-c(id_count,month))
