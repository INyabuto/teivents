#' Tracked entity instance events
#'
#' A dataset containing tracked entity instance events for import.
#'
#' @format
#' \describe{
#'  \item{event}{event uids}
#'  \item{status}{status of the event}
#'  \item{program}{program id}
#'  \item{programStage}{id of a program stage}
#'  \item{enrollment}{enrollment id}
#'  \item{orgUnit}{the orgUnit id}
#'  \item{eventDate}{the event date}
#'  \item{dueDate}{due date of the event}
#'  \item{latitude}{coordianates, latitude}
#'  \item{longitude}{coordianes, longitude}
#'  \item{dataElement}{id of the datalement}
#'  \item{value}{value of the data element}
#'  \item{storedBy}{name of person / account uploading the events}
#'  \item{providedElseWhere}{logical, is this dataElement provided elsewhere?}
#'  \item{completedDate}{date of completion}
#'  \item{completedBy}{person or account completing the event}
#'  \item{geometry}{coordinates}
#' }
#' @source DHIS2 guide
"tei_events"
