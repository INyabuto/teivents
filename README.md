
<!-- README.md is generated from README.Rmd. Please edit that file -->

# teivents

<!-- badges: start -->

<!-- badges: end -->

Utility functions for importing events in tracker program.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("INyabuto/teivents")
```

## Example

This is a basic example which shows you how to generate an event payload
from event line list:

``` r
library(teivents)
## generate event payload
sample_events <- teivents::tei_events

event_payload <- generate_tei_events_payload(sample_events)

# as json
d <- jsonlite::toJSON(list(events = event_payload), auto_unbox = T, pretty = T)

d
#> {
#>   "events": [
#>     {
#>       "event": "ajy9vyv690U",
#>       "status": "ACTIVE",
#>       "program": "YwHgjZuI7R5",
#>       "programStage": "HpVpdvMGqiI",
#>       "enrollment": "Pk2k7i9JqtK",
#>       "orgUnit": "k2BV5zuMsCr",
#>       "eventDate": "2019-09-24",
#>       "dueDate": "2019-09-24",
#>       "dataValues": [
#>         {
#>           "dataElement": "jUKmQapxBo1",
#>           "value": "true",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-09-24"
#>         },
#>         {
#>           "dataElement": "qMnTVhZ5iXo",
#>           "value": "Local Community Development Association in Al Badary",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-09-24"
#>         },
#>         {
#>           "dataElement": "DfRAAYhpA35",
#>           "value": "2",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-09-24"
#>         },
#>         {
#>           "dataElement": "Jw8pmTOhjhB",
#>           "value": "0",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-09-24"
#>         },
#>         {
#>           "dataElement": "hExhhzGcJLF",
#>           "value": "true",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-09-24"
#>         }
#>       ]
#>     },
#>     {
#>       "event": "ApC16gw74yS",
#>       "status": "ACTIVE",
#>       "program": "YwHgjZuI7R5",
#>       "programStage": "HpVpdvMGqiI",
#>       "enrollment": "zAQma0SbDFY",
#>       "orgUnit": "NcgPUs1sT4X",
#>       "eventDate": "2019-12-17",
#>       "dueDate": "2019-12-17",
#>       "dataValues": [
#>         {
#>           "dataElement": "jUKmQapxBo1",
#>           "value": "true",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-12-17"
#>         },
#>         {
#>           "dataElement": "qMnTVhZ5iXo",
#>           "value": "Afdal Community Development Association in Al Sawalim Al Bahariya",
#>           "storedBy": "IhaT",
#>           "providedElsewhere": false,
#>           "completedDate": "2019-12-17"
#>         }
#>       ]
#>     }
#>   ]
#> }
```

You can save the json payload to disk and send to the `events endpoint`
using curl as described on the [DHIS2
guide](https://docs.dhis2.org/en/develop/using-the-api/dhis-core-version-master/tracker.html)
or upload the events directly with `create_events` as follows:

``` r

#d <- create_events(sample_events)
```

this will generate the payload and uplaod to the events endpoint using
`httr` package.

Be sure to first set the config params in your `r_environ` or you could
pass them directly in the function call as follows:

``` r
# d <- create_events(sample_events, 
#                    baseurl = "https://play.dhis2.org/2.33nightly/",
#                    user = "admin",
#                    pass = "district"
#                    )
```

or by including the config in the `r_environ`:

``` r
usethis::edit_r_environ()
#> • Edit '/Users/isaiahnyabuto/.Renviron'
#> • Restart R for changes to take effect
```

the following is a sample config:

``` r

C_USER = "admin" # dhis2 account
C_PASS = "district" # dhis2 pass 
BASEURL = "https://play.dhis2.org/2.33nightly/" # the server url
USER_AGENT = "https://github.com/INyabuto/teivents"
```
