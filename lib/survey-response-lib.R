# survey-response-lib.R
# Copyright (c) 2016 Code for Hampton Roads (Norfolk/Virginia Beach)


# helper functions -------------------------------------------------------------------------------------------------------------

#' Establish a connection to OKCandidate Survey DB
#' 
#' This function connects to the 
#' database holding the OKCandidate survey responses
#'
#' @usage connectOKCDB(user=NULL, password=NULL)
#' @keywords database postgres login connection
#' @importFrom RPostgreSQL dbConnect dbDisconnect
#' @importFrom DBI dbDriver
#' @param user a character string defining the Postgres DB username credential
#' @param password a character string defining the Postgres DB password credential
#' @return An object \code{PostgreSQLConnection} whose class extends \code{DBIConnection}. 
#'  This object can be used to execute SQL queries on the database.
#' @seealso
#'  \code{\link[DBI]{dbDriver}},
#'  \code{\link[RPostgreSQL]{dbConnect}},
#'  \code{\link[RPostgreSQL]{dbDisconnect}},
#' @examples
#' \dontrun{
#' # establish a connection
#' con <- connectOKCDB()
#' 
#' # close that connection
#' dbDisconnect(con)
#' }
#' @export
connectOKCDB <- function(user=NULL, password=NULL) {
  
  dbname <- "okc" 
  host <- "okcpostgres.okcandidate.225baddf.svc.dockerapp.io"
  port <- 5432
  
  if(is.null(user) | is.null(password)){
    user <- "readonly"
    password <- "Z222KqjjHgiii"
  }
  
  con <- dbConnect(dbDriver("PostgreSQL"), 
                   dbname=dbname, 
                   host=host, 
                   port=port,
                   user=user, 
                   password=password)
  
  return(con)
  
}


#' Execute a Query Against the OKCandidate Survey DB
#' 
#' This function executes a query against the 
#' database holding the OKCandidate survey responses
#'
#' @usage queryOKCDB(query, con=NULL)
#' @keywords database query sql postgres warehouse
#' @importFrom RPostgreSQL dbGetQuery
#' @param query a character string defining a query to be executed against the DB
#' @param con a \code{PostgreSQLConnection} returned by \link{createPostgresConn}. If
#' one is not provided, a new connection is created and closed just for the execution 
#' of this query.
#' @return A \code{data.frame} object of the query's resultset
#' @seealso
#'  \code{\link[RPostgreSQL]{dbGetQuery}},
#' @examples
#' \dontrun{
#' # This query pulls the existing LoCo prices by Zip Code
#' loco_prices_query <- "SELECT * FROM app_loco_rev_potential.prices_raw"
#' 
#' prices_data <- queryOKCDB(loco_prices_query)
#' 
#' head(prices_data)
#' }
#' @export
queryOKCDB <- function(query, con=NULL) {
  
  user_supplied_con <- TRUE
  
  if(is.null(con)){
    
    message("Connecting to OKCDB")
    
    con <- connectOKCDB()
    user_supplied_con <- FALSE
  }
  
  query_result <- tryCatch({
    
    message("Running Query")
    
    dbGetQuery(con, query)
    
  }, error = function(e){
    
    message("There was an error with your query. See details below.")
    
    message(e)
    
  }, finally = {
    
    tryCatch({
      if(exists("con") & !user_supplied_con){
        
        dbDisconnect(con)
        
        message("Closed OKC DB Connection")
      }
    })
    
  }
  )
  
  query_result
  
}

#' Proper Capitalize Columns with Some Exceptions
#'
#' This function is helper for data and table column names
#' when they should be converted to proper case, but also
#' retain some words in all uppercase because they are 
#' business-specific acronyms
#'
#' @usage format_col_names(x)
#' @keywords formatting export Excel googlesheets Shiny
#' @importFrom stringr str_to_title
#' @param cols a character string or vector to be formatting
#' @return a version of x with underscores removed and proper casing
#' @examples 
#' \dontrun{
#' format_col_names(c('intensity_by_question_category'))
#' }
#' @export
format_col_names <- function(cols) {
  cols <- gsub("_", " ", tolower(cols))
  cols <- str_to_title(cols)
  return(cols)
}


