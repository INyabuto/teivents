#' Review an API response
#'
#' Check that API returned a `JSON` element without any errrors.
#'
#' @param res A DHIS2 response object.
#' @importFrom httr http_type http_error content status_code
#' @importFrom jsonlite fromJSON
check_for_response <- function(res = NULL) {
  if (!is.null(res)) {
    if (http_type(res) != "application/json") {
      stop("xx-mis did not return json", call. = F)
    }
    parsed <- fromJSON(content(res, "text"), simplifyVector = F)
    if (http_error(res)) {
      stop(
        sprintf(
          "xx-mis request failed [%s] \n%s\n<%s>",
          status_code(res),
          parsed$message,
          parsed$url
        ),
        call. = F
      )
    }
  }
}

#' Review API authentication
#'
#' Check that the API pass key is specified. It looks for the API key from the
#' `r` `environment`, if not supplied, otherwise throws an error.
#'
#' @param user A DHIS2 user account to authenticate.
#' @param pass Password of the DHIS2 Account.
#' @return A list with API key (user and pass) if found.
check_for_authentication <- function(user = NULL, pass = NULL) {
  if (is.null(user) && is.null(pass)) {
    user <- Sys.getenv("C_USER")
    pass <- Sys.getenv("C_PASS")

    if (user == "" || pass == "") {
      stop("teivents: couldn't find the authenication key in the r_environ either, please specify on the function call or refresh setting")
    }
  }
  list(user = user, pass = pass)
}

#' Check for the baseurl
#'
#' @param baseurl thee baseurl.
#' @noRd
check_for_baseurl <- function(baseurl = NULL){
  if (is.null(baseurl)){
    baseurl <- Sys.getenv("BASEURL")
    if (baseurl == ""){
      stop("teivents: couldn't find the baseurl from the r_environ either, please specify on the function call or refresh setting",
           call. = F)
    }
  }
  baseurl
}

#' Check if an event has data values
#'
#' @param events A data.frame or data table object. Events to search.
#' @return logical.
#' @noRd
has_data_values <- function(events = NULL) {
  if (!is.null(events) && "dataValues" %in% names(events)) {
    TRUE
  } else {
    FALSE
  }
}

#' Parse an API response
#'
#' @param res the API response
#' @param url the endpoint url
#' @param simplify_vector passed to [jsonlite::fromJSON()]
#' @param name class name of the S3 object
#' @return S3 object
parse_api_response <- function(res, url, simplify_vector = F, name = NULL) {
  d <- content(res, "text")
  d <- fromJSON(d, simplifyVector = simplify_vector)


  if (is.null(name)) {
    name <- "xx-mis_api"
  }

  structure(
    list(
      content = d,
      endpoint = url,
      response = res
    ),
    class = name
  )
}



