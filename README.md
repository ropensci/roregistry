rOpenSci Package Registry
=========================

## What is this

This repository contains 2 files that define the official rOpenSci package suite:

 [packages.json](packages.json): the official list of rOpenSci packages, identified by the package name and git url (updated hourly).
 [registry.json](registry.json): a large collection of metadata about these packages that is regularly collected using [codemetar](https://docs.ropensci.org/codemetar) (updated daily).

The rOpenSci package suite consists of all R packages in the [ropensci](https://github.com/ropensci) and [ropensci-labs](https://github.com/ropensci-labs) GitHub organizations, except for packages listed in [exclude list](info/exclude_list.txt), plus some extra packages listed in [not_transferred.json](info/not_transferred.json). 

The CI automatically updates the [packages.json](packages.json) and [registry.json](registry.json) files using the [makeregistry](https://github.com/ropensci-org/makeregistry) package.


## Generating packages.json

The code to re-generate packages.json and registry.json is in the [makeregistry](https://github.com/ropensci-org/makeregistry) package. The `build_ropensci_packages_json()` function works as follows:

 1. It queries the GitHub API for all repositories in `ropensci` and `ropensci-labs`.
 2. It removes entries from the [exclude list](info/exclude_list.txt) 
 3. It adds packages listed in [not_transferred.json](info/not_transferred.json)
 4. Saves the final list in `packages.json`

This function should take less then a minute to complete, be very reliable, and we run it frequently.

On a daily basis we also try to collect metadata from all ropensci packages, using `make_registry()` function. This function uses the following steps:

- load the package list from packages.json
- pull down the latest commit from every rOpenSci repository
- run [codemetar][] against each repository to generate its [codemeta.json](https://github.com/ropensci/codemetar#why-create-a-codemetajson-for-your-package) data
- combine all package codemeta data into one big codemeta (`raw_cm.json`)
- extract a smaller subset of metadata from the big codemeta file to make the `registry.json` file
- push the `raw_cm.json` and `registry.json` files up to this repo

This second function can run up to 10 minutes and requires many API calls (multiple per package). It is not very robust and sometimes fails for a number of random reasons.

## Why the CI runs in a container

To speed up the CI builds, the roregistry workflow runs in a docker container which has R and makeregistry preinstalled. This container is automatically built and published on GHCR in the same [ropenscilabs/makeregistry][https://github.com/ropensci-org/makeregistry/pkgs/container/makeregistry] repository using [this workflow](https://github.com/ropensci-org/makeregistry/blob/master/.github/workflows/docker-build.yml). 

When a change is committed to makeregistry, it takes a few minutes before the container is updated. This is exactly the time we save for each CI run in roregistry because it does not have to install R and makeregistry + dependencies for each build.

## Getting the registry

To get just the raw JSON of the registry, go to <https://ropensci.github.io/roregistry/registry.json>

To read in from R with `jsonlite`:

```r
url <- "https://ropensci.github.io/roregistry/registry.json"
z <- jsonlite::fromJSON(url)
tibble::as_tibble(z$packages)
```

```r
#> # A tibble: 388 x 13
#>    name  description details maintainer keywords github status onboarding on_cran on_bioc url   ropensci_catego…
#>    <chr> <chr>       <chr>   <chr>      <chr>    <chr>  <chr>  <chr>      <lgl>   <lgl>   <chr> <chr>
#>  1 auk   eBird Data… "Extra… Matthew S… "datase… https… active "https://… TRUE    FALSE   http… data-access
#>  2 tree… Base Class… "'tree… Guangchua… "export… https… active "https://… FALSE   TRUE    http… data-tools
#>  3 apip… Package Ge… "Packa… Scott Cha… "yaml"   https… wip    ""         FALSE   FALSE   http… http-tools
#>  4 arre… Arrested D… "Here … Lucy D'Ag… "unconf… https… conce… ""         FALSE   FALSE   http… data-access
#>  5 aspa… Client for… "Clien… Scott Cha… "archiv… https… conce… ""         FALSE   FALSE   http… literature
#>  6 astr  Decompose … "Decom… Scott Cha… ""       https… conce… ""         FALSE   FALSE   http… NA
#>  7 bind… Create req… "Compu… Saras Win… "ozunco… https… conce… ""         FALSE   FALSE   http… NA
#>  8 blog… Helps Edit… "More … Maëlle Sa… ""       https… wip    ""         FALSE   FALSE   http… scalereprod
#>  9 cche… Client for… "Clien… Scott Cha… "cran, … https… conce… ""         FALSE   FALSE   http… scalereprod
#> 10 chan… A simple i… "This … Nick Gold… "ozunco… https… conce… ""         FALSE   FALSE   http… scalereprod
#> # … with 378 more rows, and 1 more variable: date_last_commit <chr>
```
