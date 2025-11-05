y=2008
# Month list --------------------------------------------------------------
monthlist <- if (y == 2008) sprintf("%02d", 6:12) else sprintf("%02d", 1:12)

# Reader: read numerics as text, then parse --------------------------------
read_penetration <- function(path) {
  raw <- read_csv(
    path,
    skip = 1,
    col_names = c(
      "state","county","fips_state","fips_cnty","fips",
      "ssa_state","ssa_cnty","ssa","eligibles","enrolled","penetration"
    ),
    # read potential problem columns as character first
    col_types = cols(
      state      = col_character(),
      county     = col_character(),
      fips_state = col_integer(),
      fips_cnty  = col_integer(),
      fips       = col_double(),
      ssa_state  = col_integer(),
      ssa_cnty   = col_integer(),
      ssa        = col_double(),
      eligibles  = col_character(),
      enrolled   = col_character(),
      penetration= col_character()
    ),
    na = c("", "NA", "*", "-", "--"),
    show_col_types = FALSE,
    progress = FALSE
  )

  # robust numeric parsing (handles commas, %, stray text)
  raw %>%
    mutate(
      eligibles   = parse_number(eligibles),
      enrolled    = parse_number(enrolled),
      penetration = parse_number(penetration)
    )
}

# One-month loader --------------------------------------------------------
load_month_pen <- function(m) {
  path <- paste0("data/input/ma/penetration/Extracted Data/State_County_Penetration_MA_",y, "_", m, ".csv")

  read_penetration(path) %>%
    mutate(month = as.integer(m), year = y)
}

# Read all months, then tidy once ----------------------------------------
ma.penetration <- map_dfr(monthlist, load_month_pen) %>%
  arrange(state, county, month) %>%
  group_by(state, county) %>%
  fill(fips, .direction = "downup") %>%
  ungroup()

# Collapse to yearly (safe summaries; avoid NaN/Inf) ----------------------
final.penetration <- ma.penetration %>%
  group_by(fips, state, county, year) %>%
  arrange(month, .by_group = TRUE) %>%
  summarize(
    n_elig  = sum(!is.na(eligibles)),
    n_enrol = sum(!is.na(enrolled)),

    avg_eligibles   = ifelse(n_elig  > 0, mean(eligibles, na.rm = TRUE), NA_real_),
    sd_eligibles    = ifelse(n_elig  > 1,  sd(eligibles,  na.rm = TRUE), NA_real_),
    min_eligibles   = ifelse(n_elig  > 0, min(eligibles,  na.rm = TRUE), NA_real_),
    max_eligibles   = ifelse(n_elig  > 0, max(eligibles,  na.rm = TRUE), NA_real_),
    first_eligibles = ifelse(n_elig  > 0, first(na.omit(eligibles)),     NA_real_),
    last_eligibles  = ifelse(n_elig  > 0,  last(na.omit(eligibles)),     NA_real_),

    avg_enrolled    = ifelse(n_enrol > 0, mean(enrolled,   na.rm = TRUE), NA_real_),
    sd_enrolled     = ifelse(n_enrol > 1,  sd(enrolled,    na.rm = TRUE), NA_real_),
    min_enrolled    = ifelse(n_enrol > 0, min(enrolled,    na.rm = TRUE), NA_real_),
    max_enrolled    = ifelse(n_enrol > 0, max(enrolled,    na.rm = TRUE), NA_real_),
    first_enrolled  = ifelse(n_enrol > 0, first(na.omit(enrolled)),       NA_real_),
    last_enrolled   = ifelse(n_enrol > 0,  last(na.omit(enrolled)),       NA_real_),

    ssa = last(ssa),
    .groups = "drop"
  )
