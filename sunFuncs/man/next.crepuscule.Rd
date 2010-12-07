\name{next.crepuscule}
\alias{next.crepuscule}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculates the next (or previous) crepuscule time 
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
next.crepuscule(crds, dateTime, solarDep, direction, proj4string = CRS("+proj=longlat +datum=WGS84"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{crds}{
%%     ~~Describe \code{crds} here~~
}
  \item{dateTime}{
%%     ~~Describe \code{dateTime} here~~
}
  \item{solarDep}{
%%     ~~Describe \code{solarDep} here~~
}
  \item{direction}{
%%     ~~Describe \code{direction} here~~
}
  \item{proj4string}{
%%     ~~Describe \code{proj4string} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(crds, dateTime, solarDep, direction, proj4string=CRS("+proj=longlat +datum=WGS84")){
	tzone <- attr(as.POSIXlt(dateTime), "tzone")
	#if(direction=="dusk") dateTime <- dateTime-86400
	dt <- as.POSIXct(paste(as.Date(dateTime),"00:00:00"), tz=tzone) 
	dt <- dt - 86400*(direction=="dusk") + 86400*(direction=="dawn")
	Epoch <- as.POSIXct(strptime("1970-01-01 00:00:00", "\%Y-\%m-\%d \%H:\%M:\%S",tz=tzone),tz=tzone)
	crep <- crepuscule(crds=crds, dateTime=dt, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time
	crep24 <- crepuscule(crds=crds, dateTime=dt+86400, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time
	crep48 <- crepuscule(crds=crds, dateTime=dt+172800, solarDep=solarDep, direction=direction, POSIXct.out=TRUE, proj4string=proj4string)$time
	c1 <- ifelse(crep>dateTime, crep, 0)
	c2 <-  ifelse(dateTime>crep & crep24>dateTime, crep24, 0)
	c3 <-  ifelse(dateTime>crep24 & crep48>dateTime, crep48, 0)
	return(c1+c2+c3+Epoch)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
