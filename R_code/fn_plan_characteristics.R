mapd.clean.merge <- function(ma.data, mapd.data, y) {
  
  # Tidy MA-only data -------------------------------------------------------
  ma.data <- ma.data %>%
    select(contractid, planid, state, county, premium)
  
  ## Fill in missing plan info (by contract, plan, state, and county)
  ma.data <- ma.data %>%
    group_by(contractid, planid, state, county) %>%
    fill(premium)
  
  ## Remove duplicates
  ma.data <- ma.data %>%
    group_by(contractid, planid, state, county) %>%
    mutate(id_count=row_number())
  
  ma.data <- ma.data %>%
    filter(id_count==1) %>%
    select(-id_count)
  
  
  # Tidy MA-PD data ---------------------------------------------------------
  mapd.data <- mapd.data %>% 
    select(contractid, planid, state, county, premium_partc, premium_partd_basic, 
           premium_partd_supp, premium_partd_total, partd_deductible) %>%
    mutate(planid=as.numeric(planid))
  
  mapd.data <- mapd.data %>%
    group_by(contractid, planid, state, county) %>%
    fill(premium_partc, premium_partd_basic, premium_partd_supp, premium_partd_total, partd_deductible)
  
  ## Remove duplicates
  mapd.data <- mapd.data %>%
    group_by(contractid, planid, state, county) %>%
    mutate(id_count=row_number())
  
  mapd.data <- mapd.data %>%
    filter(id_count==1) %>%
    select(-id_count)
  
  ## Merge Part D info to Part C info
  plan.premiums <- ma.data %>%
    full_join(mapd.data, by=c("contractid", "planid", "state", "county")) %>%
    mutate(year=y)
  
  return(plan.premiums)  
}
