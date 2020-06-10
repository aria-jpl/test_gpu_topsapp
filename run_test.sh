#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)

# source ISCE2 environment
source /opt/isce2/isce_env.sh

# export ISCE2 applications path
PATH=/opt/isce2/isce/applications:$PATH

# clean out previous run
rm -rf ESD PICKLE coarse_* fine_* geom_* isce.log master merged slave topsProc.xml topsinsar.log

# exercise GPUtopozero and GPUgeo2rdr by running through to fineoffsets
topsApp.py --steps --end=fineoffsets
