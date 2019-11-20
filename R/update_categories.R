# current categories information
categories <- readr::read_csv(here::here("final_categories.csv"))

library("magrittr")

# current packages
jsonlite::read_json(here::here("registry.json")) %>%
  .[[1]] %>%
  purrr::map_chr("name") -> packages

# only keep categories information
# for current packages
categories <- dplyr::filter(categories,
                            name %in% packages)
readr::write_csv(categories, here::here("final_categories.csv"))

# missing categories information
dplyr::filter(categories, is.na(ropensci_category))
# update csv by hand and save it
