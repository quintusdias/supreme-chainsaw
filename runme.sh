#!/bin/bash

rm *.tif

# gdalwarp -geoloc -t_srs EPSG:4326  aster.vrt -ot Float32 -dstnodata -9999 test.tif
#
# 
gdalwarp -geoloc -t_srs EPSG:4326  aster.vrt -ot Float32 test.tif

# Don't bother setting no_data, it's too hard to do with floating point data.
gdal_translate -scale 0 35 0 0.35 test.tif test2.tif

# Mask out anything less than zero, set it to no_data.
gdal_calc.py -A test2.tif --outfile=test3.tif --calc="A*(A>=0)" --NoDataValue=-1
