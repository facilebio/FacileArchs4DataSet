
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FacileArchs4DataSet

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/facilebio/FacileArchs4DataSet.svg?branch=master)](https://travis-ci.org/facilebio/FacileArchs4DataSet)
[![Codecov test
coverage](https://codecov.io/gh/facilebio/FacileArchs4DataSet/branch/master/graph/badge.svg)](https://codecov.io/gh/facilebio/FacileArchs4DataSet?branch=master)
<!-- badges: end -->

[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

This package enables the use of the mouse and human [ARCHS4
datasets](https://amp.pharm.mssm.edu/archs4/index.html) within the
[facilebio](https://facile.bio/) ecosystem by defining a `FacileDataSet`
subclass (`FacileArchs4DataSet`) that uses the [HDF5
files](https://amp.pharm.mssm.edu/archs4/download.html) provided by the
ARCHS4 project as the assay data source, as opposed to the
FacileDataSet-native way of storing these data on disk.

The `FacileArchs4DataSet` class therefore provides the facile data API
over these data, thereby enabling its use in the
[facilebio](https://facile.bio/) ecosystem.

## Installation

``` r
# remotes::install("facilebio/FacileArchs4DataSet")
library(FacileArchs4DataSet)
```

1.  Users need to download the both the gene and transcript level HDF5
    files for the species of interest (mouse or human) from the [ARCHS4
    project](https://amp.pharm.mssm.edu/archs4/download.html) into a
    new/empty folder, ie. `ARCHS4DATADIR` =
    “/archs4dir/with/human/hdf5files”.

2.  Run the `FacileArchs4DataSet::build(ARCHS4DATADIR, species =
    "human")`

This will take a few seconds to build the appropriate sample and gene
level database. After which, the user can perform a differential
expression analysis over the data from the `"GSE89189"` study like so:

``` r
library(FacileAnalysis)
a4.mouse <- FacileArchs4DataSet(ARCHS4DATADIR)
a4.mouse %>% 
  filter_samples(dataset == "GSE89189") %>% 
  fdgeGadget()
```

Refer to the
[FacileAnalysis](https://facilebio.github.io/FacileAnalysis/)
documentation for details on how to easily perform diferential
expression analysis, GSEA, etc.

## License

There is not data provided within this package, and the code within is
released under \[The Apache 2 License\]\[apache2\].

In order for this package to be useful, however, the end user must
download the HDF5 files provifed by the [ARCHS4
project](https://amp.pharm.mssm.edu/archs4/download.html). Use of the
ARCHS4 data is subject to its own [terms of
use](https://amp.pharm.mssm.edu/archs4/help.html), and it is the
end-user’s responsibility to ensure that they are using it in a
compliant manner.

## Acknowledgements

  - Thanks Alexander Lachmann and The Ma’ayan Laboratory for the
    development and continued updates to the [ARCHS4
    project](https://amp.pharm.mssm.edu/archs4/index.html).
