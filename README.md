ropensci registry
======

The ropensci registry...

To get the raw JSON of the registry, go to [https://raw.githubusercontent.com/ropensci/roregistry/master/registry.json](https://raw.githubusercontent.com/ropensci/roregistry/master/registry.json)

To read in from R:

```r
url <- "https://raw.githubusercontent.com/ropensci/roregistry/master/registry.json"
jsonlite::fromJSON(url)
```

```r
$name
[1] "ropensci_registry"

$version
[1] "0.2.1"

$updated
[1] "2015-05-26"

$meta
$meta$name
[1] "Package name, also the name in the DESCRIPTION file, note that this may be different from the GitHub repo name"

$meta$type
[1] "Category - only packages included for now, may include others later"

$meta$maintainer
[1] "Package maintainer name"

$meta$email
[1] "Package maintainer email"

$meta$status
$meta$status$description
[1] "Current state of the package, different from installable"

$meta$status$levels
$meta$status$levels$good
[1] "Everything is good, everything should work fine"

$meta$status$levels$hiatus
[1] "Taking a break for a reason, e.g., waiting for next version of an API"

$meta$status$levels$deprecated
[1] "Not maintaining any longer, though may still be installable"



$meta$installable
[1] "Logical - should the package install"

$meta$category
[1] "Category - what the package does/data it deals with"

$meta$on_cran
[1] "Logical - is the package on CRAN"

$meta$cran_archived
[1] "Logical - if the package is on CRAN, is it archived?"

$meta$url
[1] "Code repository URL, usually a GitHub repository"

$meta$root
[1] "Path to root of the R package (if an R package exists). If in root of repo, then zero length string"

$meta$fork
[1] "Logical - is the repo a fork"

$meta$description
[1] "Brief description of the package"


$packages
                name    type            maintainer                                  email     status
1                alm package     Scott Chamberlain                myrmecocystus@gmail.com       good
2             AntWeb package           Karthik Ram                  karthik.ram@gmail.com       good
3              aRxiv package           Karl Broman               kbroman@biostat.wisc.edu       good
4                bmc package     Scott Chamberlain                myrmecocystus@gmail.com       good
```
