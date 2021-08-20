#' Import events in a DHIS2 tracker program
#'
#' Imports single events into a tracker program through the `DHIS2 events API`
#' `endpoint`.
#'
#' @param tei_events A data.frame object, containing a list of events to import.
#' @param baseurl the baseurl.
#' @param user DHIS2 username.
#' @param pass DHIS2 password.
#' @param ua String, name that identifies the user agent.
#' @param timeout integer, specify the timeout in seconds.
#' @importFrom httr content timeout user_agent content_type_json
#'   authenticate
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom data.table as.data.table
#' @importFrom utils str
#' @name import_tei_events
NULL

#' @describeIn import_tei_events Create events in a DHIS2 program
#' @export
create_events <- function(tei_events,
                          baseurl = NULL,
                          user = NULL,
                          pass = NULL,
                          ua = NULL,
                          timeout = 60) {
  baseurl <- check_for_baseurl(baseurl)

  url <- paste0(baseurl, "api/events")

  auth <- check_for_authentication(user, pass)

  if (is.null(ua)) {
    ua <- Sys.getenv("USER_AGENT")
  }

  payload <- generate_tei_events_payload(tei_events)

  res <- httr::POST(url,
    user_agent(ua),
    timeout(timeout),
    authenticate(auth$user, auth$pass),
    body = toJSON(
      list(events = payload),
      auto_unbox = T
    ),
    content_type_json()
  )

  check_for_response(res)

  d <- parse_api_response(res)

  d
}

#' print function for create events
#'
#' @param x response returned by [create_teis()].
#' @param ... additional params passed to print.
#' @noRd
print.create_events <- function(x, ...) {
  cat(sprintf("XX-MIS <%s>\n", x$endpoint))
  str(x$content, list.len = 5, vec.len = 1)
  invisible(x)
}

#' @describeIn import_tei_events Generate events payload
#' @export
generate_tei_events_payload <- function(tei_events) {
  is_tei_event_obj(tei_events)
  tei_events <- data.table::as.data.table(tei_events)
  event_ids <- unique(tei_events$event)
  tei_events <- lapply(event_ids, function(x) {
    tei_event <- tei_events[event == x, ]
    event <- data.frame(
      event = tei_event[1, event],
      status = tei_event[1, status],
      program = tei_event[1, program],
      programStage = tei_event[1, programStage],
      enrollment = tei_event[1, enrollment],
      orgUnit = tei_event[1, orgUnit],
      eventDate = tei_event[1, eventDate],
      dueDate = tei_event[1, dueDate]
    )
    event$dataValues <- list(tei_event[,
                                       .(dataElement,
                                         value,
                                         storedBy,
                                         providedElsewhere,
                                         completedDate,
                                         completedBy)
                                       ])
    event
  })

  tei_events <- data.table::rbindlist(tei_events)
  tei_events
}

#' Checks the tei_event object
#'
#' Checks whether the passed object is a tei event.
#' @param tei_event A data.frame object, containing a list of events to import.
#' @noRd
is_tei_event_obj <- function(tei_events) {
  if (!is.data.frame(tei_events)) {
    stop("tei_events must be a data.frame", call. = F)
  }

  tei_event_obj_props <- c(
    "event",
    "program",
    "programStage",
    "enrollment",
    "orgUnit",
    "eventDate",
    "dueDate",
    "dataElement",
    "value",
    "storedBy",
    "providedElsewhere",
    "completedDate",
    "completedBy"
  )
  if (all(tei_event_obj_props %in% names(tei_events))) {
    TRUE
  } else {
    stop(sprintf(
      "tei_event_obj must at least contain the following col names: \n < %s > \n
      run ??tei_event to see an example of a supported object.",
      paste0(tei_event_obj_props, collapse = "", sep = ", ")
    ))
  }
}
