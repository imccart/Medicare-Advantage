# Month list --------------------------------------------------------------
monthlist <- if (y == 2006) sprintf("%02d", 7:12) else sprintf("%02d", 1:12)

# Readers (quiet & typed) -------------------------------------------------
read_contract <- function(path) {
  read_csv(
    path,
    skip = 1,
    col_names = c(
      "contractid","planid","org_type","plan_type","partd","snp","eghp",
      "org_name","org_marketing_name","plan_name","parent_org","contract_date"
    ),
    col_types = cols(
      contractid = col_character(),
      planid     = col_double(),
      org_type   = col_character(),
      plan_type  = col_character(),
      partd      = col_character(),
      snp        = col_character(),
      eghp       = col_character(),
      org_name   = col_character(),
      org_marketing_name = col_character(),
      plan_name  = col_character(),
      parent_org = col_character(),
      contract_date = col_character()
    ),
    show_col_types = FALSE,
    progress = FALSE
  )
}

read_enroll <- function(path) {
  read_csv(
    path,
    skip = 1,
    col_names = c("contractid","planid","ssa","fips","state","county","enrollment"),
    col_types = cols(
      contractid = col_character(),
      planid     = col_double(),
      ssa        = col_double(),
      fips       = col_double(),
      state      = col_character(),
      county     = col_character(),
      enrollment = col_double()
    ),
    na = "*",
    show_col_types = FALSE,
    progress = FALSE
  )
}

# One-month loader --------------------------------------------------------
load_month <- function(m) {
  c_path <- paste0("data/input/ma/enrollment/Extracted Data/CPSC_Contract_Info_", y, "_", m, ".csv")
  e_path <- paste0("data/input/ma/enrollment/Extracted Data/CPSC_Enrollment_Info_", y, "_", m, ".csv")

  contract.info <- read_contract(c_path) %>%
    distinct(contractid, planid, .keep_all = TRUE)   

  enroll.info <- read_enroll(e_path)

  contract.info %>%
    left_join(enroll.info, by = c("contractid","planid")) %>%
    mutate(month = as.integer(m), year = y)
}

# Read all months, then tidy once ----------------------------------------

plan.year <- map_dfr(monthlist, load_month) %>%
  arrange(contractid, planid, state, county, month) %>%
  group_by(state, county) %>%
  fill(fips, .direction = "downup") %>%                
  ungroup() %>%
  group_by(contractid, planid) %>%
  fill(plan_type, partd, snp, eghp, plan_name, .direction = "downup") %>%
  ungroup() %>%
  group_by(contractid) %>%
  fill(org_type, org_name, org_marketing_name, parent_org, .direction = "downup") %>%
  ungroup()


# Collapse to yearly panel ------------------------------------------------
final.plans <- plan.year %>%
  group_by(contractid, planid, fips, year) %>%
  arrange(month, .by_group = TRUE) %>%
  summarize(
    n_nonmiss        = sum(!is.na(enrollment)),
    avg_enrollment   = ifelse(n_nonmiss > 0, mean(enrollment, na.rm = TRUE), NA_real_),
    sd_enrollment    = ifelse(n_nonmiss > 1, sd(enrollment, na.rm = TRUE), NA_real_),
    min_enrollment   = ifelse(n_nonmiss > 0, min(enrollment, na.rm = TRUE), NA_real_),
    max_enrollment   = ifelse(n_nonmiss > 0, max(enrollment, na.rm = TRUE), NA_real_),
    first_enrollment = ifelse(n_nonmiss > 0, first(na.omit(enrollment)), NA_real_),
    last_enrollment  = ifelse(n_nonmiss > 0,  last(na.omit(enrollment)), NA_real_),
    state            = last(state),
    county           = last(county),
    org_type         = last(org_type),
    plan_type        = last(plan_type),
    partd            = last(partd),
    snp              = last(snp),
    eghp             = last(eghp),
    org_name         = last(org_name),
    org_marketing_name = last(org_marketing_name),
    plan_name        = last(plan_name),
    parent_org       = last(parent_org),
    contract_date    = last(contract_date),
    year             = last(year),
    .groups = "drop"
  )
