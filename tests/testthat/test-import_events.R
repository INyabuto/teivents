user <- Sys.getenv("C_USER")
pass <- Sys.getenv("C_PASS")

d <- httr::GET("https://clone.psi-mis.org/api/events?program=g4P0sySF7KD",
               authenticate(user,pass))
d <- content(d, "text")
events <- fromJSON(d)

