# Month list --------------------------------------------------------------
monthlist <- if (y == 2006) sprintf("%02d", 10:12) else sprintf("%02d", 1:12)

# Reader ------------------------------------------------------------------
read_service_area <- function(path) {
  read_csv(
    path, skip = 1,
    col_names = c(
      "contractid","org_name","org_type","plan_type","partial","eghp",
      "ssa","fips","county","state","notes"
    ),
    col_types = cols(
      contractid = col_character(),
      org_name   = col_character(),
      org_type   = col_character(),
      plan_type  = col_character(),
      partial    = col_logical(),
      eghp       = col_character(),
      ssa        = col_double(),
      fips       = col_double(),
      county     = col_character(),
      state      = col_character(),
      notes      = col_character()
    ),
    na = "*",
    show_col_types = FALSE,
    progress = FALSE
  )
}

# One-month loader --------------------------------------------------------
load_month_sa <- function(m) {
  path <- paste0("data/input/ma/service-area/Extracted Data/MA_Cnty_SA_",y, "_", m, ".csv")
  
  read_service_area(path) %>%
    mutate(month = as.integer(m), year = y)
}

# Read all months, then tidy once ----------------------------------------
service.year <- map_dfr(monthlist, load_month_sa)

# Ensure stable order before fills
service.year <- service.year %>%
  arrange(contractid, fips, state, county, month)

# Fill missing identifiers/labels
service.year <- service.year %>%
  group_by(state, county) %>%
  fill(fips, .direction = "downup") %>%
  ungroup() %>%
  group_by(contractid) %>%
  fill(plan_type, partial, eghp, org_type, org_name, .direction = "downup") %>%
  ungroup()

# Collapse to yearly: one row per contract × county (fips) × year --------
final.service.area <- service.year %>%
  group_by(contractid, fips, year) %>%
  arrange(month, .by_group = TRUE) %>%
  summarize(
    state     = last(state),
    county    = last(county),
    org_name  = last(org_name),
    org_type  = last(org_type),
    plan_type = last(plan_type),
    partial   = last(partial),
    eghp      = last(eghp),
    ssa       = last(ssa),
    notes     = last(notes),
    .groups = "drop"
  )

