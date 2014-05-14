

#' Methods for sun ephemerides calculations
#' 
#' Functions for calculating sunrise, sunset, and times of dawn and dusk, with
#' flexibility for the various formal definitions.  They use algorithms
#' provided by the National Oceanic & Atmospheric Administration (NOAA).
#' 
#' NOAA used the reference below to develop their Sunrise/Sunset
#' 
#' \url{http://www.srrb.noaa.gov/highlights/sunrise/sunrise.html} and Solar
#' Position
#' 
#' \url{http://www.srrb.noaa.gov/highlights/sunrise/azel.html} Calculators.
#' The algorithms include corrections for atmospheric refraction effects.
#' 
#' Input can consist of one location and at least one POSIXct times, or one
#' POSIXct time and at least one location.  \var{solarDep} is recycled as
#' needed.
#' 
#' Do not use the daylight savings time zone string for supplying
#' \var{dateTime}, as many OS will not be able to properly set it to standard
#' time when needed.
#' 
#' @name sun-methods
#' @aliases crepuscule sunriset solarnoon solarpos crepuscule-methods
#' crepuscule,SpatialPoints,POSIXct-method crepuscule,matrix,POSIXct-method
#' solarnoon-methods solarnoon,SpatialPoints,POSIXct-method
#' solarnoon,matrix,POSIXct-method solarpos-methods
#' solarpos,SpatialPoints,POSIXct-method solarpos,matrix,POSIXct-method
#' sunriset-methods sunriset,SpatialPoints,POSIXct-method
#' sunriset,matrix,POSIXct-method
#' @docType methods
#' @param crds a \code{SpatialPoints} or \code{matrix} object, containing x and
#' y coordinates (in that order).
#' @param dateTime a POSIXct object with the date and time associated to
#' calculate ephemerides for points given in crds.
#' @param solarDep numeric vector with the angle of the sun below the horizon
#' in degrees.
#' @param direction one of "dawn", "dusk", "sunrise", or "sunset", indicating
#' which ephemerides should be calculated.
#' @param POSIXct.out logical indicating whether POSIXct output should be
#' included.
#' @param proj4string string with valid projection string describing the
#' projection of data in \code{crds}.
#' @param \dots other arguments passed through.
#' @return \code{crepuscule}, \code{sunriset}, and \code{solarnoon} return a
#' numeric vector with the time of day at which the event occurs, expressed as
#' a fraction, if POSIXct.out is FALSE; otherwise they return a data frame with
#' both the fraction and the corresponding POSIXct date and time.
#' \code{solarpos} returns a matrix with the solar azimuth (in degrees from
#' North), and elevation.
#' @note NOAA notes that \dQuote{for latitudes greater than 72 degrees N and S,
#' calculations are accurate to within 10 minutes.  For latitudes less than +/-
#' 72 degrees accuracy is approximately one minute.}
#' @section Warning: Compared to NOAA's original Javascript code, the sunrise
#' and sunset estimates from this translation may differ by +/- 1 minute, based
#' on tests using selected locations spanning the globe. This translation does
#' not include calculation of prior or next sunrises/sunsets for locations
#' above the Arctic Circle or below the Antarctic Circle.
#' @author Sebastian P. Luque \email{spluque@@gmail.com}, translated from Greg
#' Pelletier's \email{gpel461@@ecy.wa.gov} VBA code (available from
#' \url{http://www.ecy.wa.gov/programs/eap/models.html}), who in turn
#' translated it from original Javascript code by NOAA (see Details).  Roger
#' Bivand \email{roger.bivand@@nhh.no} adapted the code to work with \pkg{sp}
#' classes.
#' @references Meeus, J.  (1991) Astronomical Algorithms.  Willmann-Bell, Inc.
#' @keywords methods manip utilities
NULL



