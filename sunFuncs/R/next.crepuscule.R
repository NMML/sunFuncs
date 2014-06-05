# TODO: Add comment
# 
# Author: johnsond@afsc.noaa.gov
###############################################################################




#' Calculates the next (or previous) crepuscule time
#' 
#'  ~~ A concise (1-5 lines) description of what the function does. ~~
#' 
#'  ~~ If necessary, more details than the description above ~~
#' 
#' @param crds  ~~Describe \code{crds} here~~
#' @param dateTime  ~~Describe \code{dateTime} here~~
#' @param solarDep  ~~Describe \code{solarDep} here~~
#' @param direction  ~~Describe \code{direction} here~~
#' @param proj4string  ~~Describe \code{proj4string} here~~
#' @return  ~Describe the value returned  If it is a LIST, use 
#' \item{comp1 }{Description of 'comp1'} 
#' \item{comp2 }{Description of comp2'}  ...
#' @note  ~~further notes~~
#' @author  ~~who you are~~
#' @export
#' 
next.crepuscule <- function(crds, dateTime, solarDep, direction, proj4string=CRS("+proj=longlat +datum=WGS84")){
	tzone <- attr(as.POSIXlt(dateTime), "tzone")
  dateTime=as.POSIXct(round(dateTime, "mins"))
	#if(direction=="dusk") dateTime <- dateTime-86400
	dt <- as.POSIXct(paste(as.Date(dateTime),"00:00:00"), tz=tzone) 
	#dt <- dt - 86400*(direction=="dusk") + 86400*(direction=="dawn")
	Epoch <- as.POSIXct(strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S",tz=tzone),tz=tzone)
	crep.m24 <- as.POSIXct(round(crepuscule(crds=crds, dateTime=dt-86400, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep <- as.POSIXct(round(crepuscule(crds=crds, dateTime=dt, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep.p24 <- as.POSIXct(round(crepuscule(crds=crds, dateTime=dt+86400, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep.p48 <- as.POSIXct(round(crepuscule(crds=crds, dateTime=dt+172800, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time,"mins"))
	c1 <- ifelse(crep.m24>=dateTime, crep.m24, 0)
	c2 <-  ifelse(dateTime>crep.m24 & crep>=dateTime, crep, 0)
	c3 <- ifelse(dateTime>crep & crep.p24>=dateTime, crep.p24, 0)
	c4 <-  ifelse(dateTime>crep.p24 & crep.p48>=dateTime, crep.p48, 0)
	if(any(c1+c2+c3+c4==0)) stop("Error in evaluation of 'next.crepuscule' function-- Talk to Devin <devin.johnson@noaa.gov> ;)\n")
	return(c1+c2+c3+c4+Epoch)
}



#' Calculate previous crepuscule day and time
#' 
#'  ~~ A concise (1-5 lines) description of what the function does. ~~
#' 
#'  ~~ If necessary, more details than the description above ~~
#' 
#' @param crds  ~~Describe \code{crds} here~~
#' @param dateTime  ~~Describe \code{dateTime} here~~
#' @param solarDep  ~~Describe \code{solarDep} here~~
#' @param direction  ~~Describe \code{direction} here~~
#' @param proj4string  ~~Describe \code{proj4string} here~~
#' @return  ~Describe the value returned  If it is a LIST, use 
#' \item{comp1 }{Description of 'comp1'} 
#'  \item{comp2 }{Description of comp2'}  ...
#' @note  ~~further notes~~
#' @author  ~~who you are~~
#' @export
#' 
prev.crepuscule <- function(crds, dateTime, solarDep, direction, proj4string=CRS("+proj=longlat +datum=WGS84")){
	tzone <- attr(as.POSIXlt(dateTime), "tzone")
  dateTime=as.POSIXct(round(dateTime, "mins"))
	#if(direction=="dusk") dateTime <- dateTime-86400
	dt <- as.POSIXct(paste(as.Date(dateTime),"00:00:00"), tz=tzone) 
	#dt <- dt - 86400*(direction=="dusk") + 86400*(direction=="dawn")
	Epoch <- as.POSIXct(strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S",tz=tzone),tz=tzone)
	crep.m48 <- as.POSIXct(round(crepuscule(crds=crds, dateTime=dt-172800, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep.m24 <-  as.POSIXct(round(crepuscule(crds=crds, dateTime=dt-86400, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep <-  as.POSIXct(round(crepuscule(crds=crds, dateTime=dt, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	crep.p24 <-  as.POSIXct(round(crepuscule(crds=crds, dateTime=dt+86400, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time, "mins"))
	c1 <- ifelse(crep.p24<=dateTime, crep.p24, 0)
	c2 <-  ifelse(dateTime>=crep & crep.p24>dateTime, crep, 0)
	c3 <- ifelse(dateTime<crep & crep.m24<=dateTime, crep.m24, 0)
	c4 <-  ifelse(dateTime>=crep.m48 & crep.m24>dateTime, crep.m48, 0)
	if(any(c1+c2+c3+c4==0)) stop("Error in evaluation of 'prev.crepuscule' function-- Talk to Devin <devin.johnson@noaa.gov> ;)\n")
	return(c1+c2+c3+c4+Epoch)
}
