# Meta --------------------------------------------------------------------
## Author:        Ian McCarthy
## Date Created:  7/8/2019
## Date Edited:   1/9/2023
## Notes:         R file to build Medicare Advantage dataset


# Preliminaries -----------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata, purrr)

## functions
source("R_code/fn_plan_characteristics.R")
source("R_code/rating_variables.R")

build_year_ma <- function(y) {
  
  source("R_code/1_plan-data.R", local=TRUE)   
  source("R_code/2_service-area.R", local=TRUE)
  source(paste0("R_code/3_plan-characteristics-",y,".R"), local=TRUE)
  source("R_code/4_penetration.R", local=TRUE)  
  source(paste0("R_code/5_star-ratings-",y,".R"), local=TRUE)  
  source(paste0("R_code/6_risk-rebates-",y,".R"), local=TRUE)
  source(paste0("R_code/7_benchmarks-",y,".R"), local=TRUE)
  source(paste0("R_code/8_ffs-costs-",y,".R"), local=TRUE)

  # shorthand objects created by the sourced files
  fp   <- final.plans
  fsa  <- final.service.area
  fsr  <- final.star.ratings
  fpen <- final.penetration
  fls  <- final.landscape
  frr  <- final.risk.rebate
  fbm  <- final.benchmark
  ffs  <- final.ffs.costs

  final.ma <- fp %>%
    inner_join(fsa %>% select(contractid, fips, year),
               by = c("contractid","fips","year")) %>%
    filter(!state %in% c("VI","PR","MP","GU","AS",""),
           snp == "No",
           (planid < 800 | planid >= 900),
           !is.na(planid), !is.na(fips)) %>%
    left_join(fsr, by = c("contractid","year")) %>%
    left_join(fpen %>% ungroup() %>% rename(state_long = state, county_long = county),
              by = c("fips","year"))

  final.state <- final.ma %>%
    group_by(state) %>%
    summarize(state_name = dplyr::last(state_long[!is.na(state_long)]), .groups = "drop")

  final.ma <- final.ma %>%
    left_join(final.state, by = "state") %>%
    left_join(fls, by = c("contractid","planid","state_name" = "state","county","year")) %>%
    left_join(frr %>% select(-contract_name, -plan_type), by = c("contractid","planid","year")) %>%
    left_join(fbm %>% mutate(ssa = as.numeric(ssa)), by = c("ssa","year")) %>%
    mutate(
      Star_Rating = case_when(
        partd == "No"                                ~ partc_score,
        partd == "Yes" &  is.na(partcd_score)        ~ partc_score,
        partd == "Yes" & !is.na(partcd_score)        ~ partcd_score,
        TRUE ~ NA_real_
      ),
      ma_rate = case_when(
        year < 2012 ~ risk_ab,
        year >= 2012 & year < 2015 & Star_Rating == 5   ~ risk_star5,
        year >= 2012 & year < 2015 & Star_Rating == 4.5 ~ risk_star45,
        year >= 2012 & year < 2015 & Star_Rating == 4   ~ risk_star4,
        year >= 2012 & year < 2015 & Star_Rating == 3.5 ~ risk_star35,
        year >= 2012 & year < 2015 & Star_Rating == 3   ~ risk_star3,
        year >= 2012 & year < 2015 & Star_Rating < 3    ~ risk_star25,
        year >= 2012 & year < 2015 & is.na(Star_Rating) ~ risk_star35,
        year >= 2015 & Star_Rating >= 4                 ~ risk_bonus5,
        year >= 2015 & Star_Rating < 4                  ~ risk_bonus0,
        year >= 2015 & is.na(Star_Rating)               ~ risk_bonus35,
        TRUE ~ NA_real_
      ),
      basic_premium = case_when(
        rebate_partc > 0 ~ 0,
        partd == "No" & !is.na(premium) & is.na(premium_partc) ~ premium,
        TRUE ~ premium_partc
      ),
      bid = case_when(
        rebate_partc == 0 & basic_premium > 0 ~ (payment_partc + basic_premium) / riskscore_partc,
        rebate_partc > 0  | basic_premium == 0 ~  payment_partc / riskscore_partc,
        TRUE ~ NA_real_
      )
    ) %>%
    left_join(ffs %>% select(-state), by = c("ssa","year")) %>%
    mutate(
      avg_ffscost = case_when(
        parta_enroll == 0 & partb_enroll == 0 ~ 0,
        parta_enroll == 0 & partb_enroll >  0 ~ partb_reimb / partb_enroll,
        parta_enroll >  0 & partb_enroll == 0 ~ parta_reimb / parta_enroll,
        parta_enroll >  0 & partb_enroll >  0 ~ (parta_reimb / parta_enroll) + (partb_reimb / partb_enroll),
        TRUE ~ NA_real_
      )
    )

  write_tsv(final.ma,file=paste0("data/output/ma_data_",y,".txt"), append=FALSE)
  final.ma
}


years <- 2008:2009
final.ma.full <- map_dfr(years, ~{
  message("Building MA data for year: ", .x)
  build_year_ma(.x)
})

write_tsv(final.ma.full, "data/output/ma_data_full.txt")

