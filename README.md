rOpenSci Package Registry
=========================

## How is the registry generated?

The rOpenSci registry (i.e., the `registry.json` file in this repo) used to be updated by hand. Manual curation got to be too big of a job; we now leverage computers to make it easier. Here's how it works:

The code is mostly in the [ropenscilabs/makeregistry][makereg] repository. On a server about every 7 hrs we:

- pull down the latest commit from every rOpenSci repository
- run [codemetar][] against each repository to generate its [codemeta.json](https://github.com/ropensci/codemetar#why-create-a-codemetajson-for-your-package) data
- combine all package codemeta data into one big codemeta (`raw_cm.json`)
- extract a smaller subset of metadata from the big codemeta file to make the `registry.json` file
- push the `raw_cm.json` and `registry.json` files up to this repo

We use an [exclude list](https://github.com/ropenscilabs/makeregistry/blob/master/inst/automation/exclude_list.txt) to manually exclude certain packages from the registry for any number of reasons.

On the server we use a combination of Ruby, R and Shell scripts to do the work.

## Getting the registry

To get just the raw JSON of the registry, go to <https://ropensci.github.io/roregistry/registry.json>

To read in from R with `jsonlite`:

```r
url <- "https://ropensci.github.io/roregistry/registry.json"
z <- jsonlite::fromJSON(url)
tibble::as_tibble(z$packages)
```

```r
# A tibble: 388 x 13
   name  description details maintainer keywords github status onboarding on_cran on_bioc url   ropensci_catego…
   <chr> <chr>       <chr>   <chr>      <chr>    <chr>  <chr>  <chr>      <lgl>   <lgl>   <chr> <chr>
 1 auk   eBird Data… "Extra… Matthew S… "datase… https… active "https://… TRUE    FALSE   http… data-access
 2 tree… Base Class… "'tree… Guangchua… "export… https… active "https://… FALSE   TRUE    http… data-tools
 3 apip… Package Ge… "Packa… Scott Cha… "yaml"   https… wip    ""         FALSE   FALSE   http… http-tools
 4 arre… Arrested D… "Here … Lucy D'Ag… "unconf… https… conce… ""         FALSE   FALSE   http… data-access
 5 aspa… Client for… "Clien… Scott Cha… "archiv… https… conce… ""         FALSE   FALSE   http… literature
 6 astr  Decompose … "Decom… Scott Cha… ""       https… conce… ""         FALSE   FALSE   http… NA
 7 bind… Create req… "Compu… Saras Win… "ozunco… https… conce… ""         FALSE   FALSE   http… NA
 8 blog… Helps Edit… "More … Maëlle Sa… ""       https… wip    ""         FALSE   FALSE   http… scalereprod
 9 cche… Client for… "Clien… Scott Cha… "cran, … https… conce… ""         FALSE   FALSE   http… scalereprod
10 chan… A simple i… "This … Nick Gold… "ozunco… https… conce… ""         FALSE   FALSE   http… scalereprod
# … with 378 more rows, and 1 more variable: date_last_commit <chr>
```

Note: we have a smaller subset of the registry data with just package names and their git urls. see <https://ropensci.github.io/roregistry/registry_urls.json>

[makereg]: https://github.com/ropenscilabs/makeregistry
[codemetar]: https://github.com/ropensci/codemetar
