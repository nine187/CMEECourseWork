######GIS Practical one ########

rm(list=ls())
graphics.off()

library(terra)
library(sf)
library(units)
library(geodata)
library(openxlsx)

sf_use_s2(FALSE)

pop_dens <- data.frame(
  n_km2 = c(260, 67, 151, 4500, 133),
  country = c('England', 'Scotland', 'Wales', 'London', 'Northern Ireland')
)
print(pop_dens)

# Create coordinates  for each country 
# - this creates a matrix of pairs of coordinates forming the edge of the polygon. 
# - note that they have to _close_: the first and last coordinate must be the same.
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

# Convert these coordinates into feature geometries
# - these are simple coordinate sets with no projection information
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# Combine geometries into a simple feature column
uk_eire_sfc <- st_sfc(wales, england, scotland, ireland, crs=4326)
plot(uk_eire_sfc, asp=1)

uk_eire_capitals <- data.frame(
  long = c (-0.1, -3.2, -3.2, -6.0, -6.25),
  lat = c(51.5, 51.5, 55.8, 54.6, 53.30),
  name = c ('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin')
)

#Indicate which fields in the data frame contain the coordinates
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long', 'lat'), crs=4326)
print(uk_eire_capitals)

st_pauls <- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25)

england_no_london <- st_difference(england, london)

lengths(scotland)
lengths(england_no_london)

wales <- st_difference(wales, england)

ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y = )))