# Test GPU-enabled topsApp.py

## Running the test
1. Start up a GPU instance (e.g. p2.xlarge) and log into it.
1. Clone this repo and cd to it:
   ```
   git clone https://github.com/aria-jpl/test_gpu_topsapp.git
   cd test_gpu_topsapp
   ```
1. Generate the input SLC zip files that were split due to GitHub LFS file size limit:
   ```
   cat S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip.?? > S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip
   cat S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip.?? > S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip
   ```
1. Pull the hysds/isce2:latest-cuda docker image:
   ```
   docker pull hysds/isce2:latest-cuda
   ```
   *Note*: This docker image was built from a fork (https://github.com/pymonger/isce2/tree/develop)
   of the official isce2 repo (https://github.com/isce-framework/isce2). The fork was updated to 
   compile on centos 7 using CUDA version 10.2.
1. Start up docker container and mount in this directory:
   ```
   docker run --rm -ti -u $ID:$(id -g) --gpus=all \
     -v $(pwd):/tmp/test_gpu_topsapp \
     -w /tmp/test_gpu_topsapp hysds/isce2:latest-cuda
   ```
1. In a separate terminal on the same instance, run the following
   command to monitor the GPU usage on the instance:
   ```
   watch nvidia-smi
   ```
1. Run the test:
   ```
   ./run_test.sh
   ```
1. The output files will be generated in the same directory `topsApp.py` was ran:
   ```
   ls -al
   ```

## Example
- Screen output of `./run_test.sh` up to the initial GPU usage, the `topo` step, should look something like this:
   ```
   This is the Open Source version of ISCE.
   Some of the workflows depend on a separate licensed package.
   To obtain the licensed package, please make a request for ISCE
   through the website: https://download.jpl.nasa.gov/ops/request/index.cfm.
   Alternatively, if you are a member, or can become a member of WinSAR
   you may be able to obtain access to a version of the licensed sofware at
   https://winsar.unavco.org/software/isce
   2020-06-10 16:34:19,977 - isce.insar - INFO - ISCE VERSION = 2.3, RELEASE_SVN_REVISION = 2531,RELEASE_DATE = 20190112, CURRENT_SVN_REVISION = 2531
   ISCE VERSION = 2.3, RELEASE_SVN_REVISION = 2531,RELEASE_DATE = 20190112, CURRENT_SVN_REVISION = 2531
   
   /opt/isce2/isce/applications/topsApp.py:751: DeprecationWarning: The 'warn' method is deprecated, use 'warning' instead
     "are different from those in InsarProc. Using names given"+
   2020-06-10 16:34:20,054 - isce.insar - WARNING - Some filenames in insarApp.geocode_list configuration are different from those in InsarProc. Using names given to insarApp.
   insarApp.geocode_list = ['merged/phsig.cor', 'merged/filt_topophase.unw', 'merged/los.rdr', 'merged/topophase.flat', 'merged/filt_topophase.flat', 'merged/filt_topophase_2stage.unw', 'merged/topophase.cor', 'merged/filt_topophase.unw.conncomp']
   InsarProc.geocode_list = ['merged/phsig.cor', 'merged/topophase.cor', 'merged/filt_topophase.unw', 'merged/los.rdr', 'merged/topophase.flat', 'merged/filt_topophase.flat', 'merged/filt_topophase_2stage.unw']
   Step processing
   Running step startup
   None
   The currently supported sensors are:  ['SENTINEL1']
   Dumping the application's pickle object _insar to file  PICKLE/startup
   The remaining steps are (in order):  ['preprocess', 'computeBaselines', 'verifyDEM', 'topo', 'subsetoverlaps', 'coarseoffsets', 'coarseresamp', 'overlapifg', 'prepesd', 'esd', 'rangecoreg', 'fineoffsets', 'fineresamp', 'ion', 'burstifg', 'mergebursts', 'filter', 'unwrap', 'unwrap2stage', 'geocode', 'denseoffsets', 'filteroffsets', 'geocodeoffsets']
   Running step preprocess
   Input XML files:  ['/vsizip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.SAFE/annotation/s1b-iw2-slc-vv-20191124t135905-20191124t135930-019070-023fd5-005.xml']
   Input TIFF files:  ['/vsizip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.SAFE/measurement/s1b-iw2-slc-vv-20191124t135905-20191124t135930-019070-023fd5-005.tiff']
   Manifest files:  ['/vsizip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip/S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.SAFE/manifest.safe']
   MANS:  S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.SAFE/manifest.safe
   Setting IPF version to :  003.10
   Extracting orbit from Orbit File:  S1B_OPER_AUX_RESORB_OPOD_20191124T153150_V20191124T114113_20191124T145843.EOF
   Updating burst number from 1 to 1
   Updating burst number from 2 to 2
   Updating burst number from 3 to 3
   Updating burst number from 4 to 4
   Updating burst number from 5 to 5
   Updating burst number from 6 to 6
   Updating burst number from 7 to 7
   Updating burst number from 8 to 8
   Updating burst number from 9 to 9
   Input XML files:  ['/vsizip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.SAFE/annotation/s1b-iw2-slc-vv-20191112t135905-20191112t135930-018895-023a35-005.xml']
   Input TIFF files:  ['/vsizip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.SAFE/measurement/s1b-iw2-slc-vv-20191112t135905-20191112t135930-018895-023a35-005.tiff']
   Manifest files:  ['/vsizip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip/S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.SAFE/manifest.safe']
   MANS:  S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.SAFE/manifest.safe
   Setting IPF version to :  003.10
   Extracting orbit from Orbit File:  S1B_OPER_AUX_RESORB_OPOD_20191112T153915_V20191112T114113_20191112T145843.EOF
   Updating burst number from 1 to 1
   Updating burst number from 2 to 2
   Updating burst number from 3 to 3
   Updating burst number from 4 to 4
   Updating burst number from 5 to 5
   Updating burst number from 6 to 6
   Updating burst number from 7 to 7
   Updating burst number from 8 to 8
   Updating burst number from 9 to 9
   2020-06-10 16:34:41,614 - isce.topsinsar.runPreprocessor - INFO - 
   ####################################################################################################
       runPreprocessor
   ----------------------------------------------------------------------------------------------------
   common.Input list of swaths to process:  = [2]
   master.burstLength_2 = 1507
   master.burstWidth_2 = 24923
   master.numberOfBursts_2 = 9
   master.sensor.ascendingnodetime = 2019-11-24 13:20:03.070621
   master.sensor.family = topsswathslc
   master.sensor.folder = None
   master.sensor.imagingmode = TOPS
   master.sensor.mission = S1B
   master.sensor.name = topsswathslc_name
   master.sensor.numberofbursts = 9
   master.sensor.processingfacility = DLR-Oberpfaffenhofen, Germany
   master.sensor.processingsoftwareversion = 003.10
   master.sensor.processingsystem = Sentinel-1 IPF
   master.sensor.spacecraftname = Sentinel-1
   slave.burstLength_2 = 1507
   slave.burstWidth_2 = 24923
   slave.numberOfBursts_2 = 9
   slave.sensor.ascendingnodetime = 2019-11-12 13:20:03.356189
   slave.sensor.family = topsswathslc
   slave.sensor.folder = None
   slave.sensor.imagingmode = TOPS
   slave.sensor.mission = S1B
   slave.sensor.name = topsswathslc_name
   slave.sensor.numberofbursts = 9
   slave.sensor.processingfacility = DLR-Oberpfaffenhofen, Germany
   slave.sensor.processingsoftwareversion = 003.10
   slave.sensor.processingsystem = Sentinel-1 IPF
   slave.sensor.spacecraftname = Sentinel-1
   ####################################################################################################
   Dumping the application's pickle object _insar to file  PICKLE/preprocess
   The remaining steps are (in order):  ['computeBaselines', 'verifyDEM', 'topo', 'subsetoverlaps', 'coarseoffsets', 'coarseresamp', 'overlapifg', 'prepesd', 'esd', 'rangecoreg', 'fineoffsets', 'fineresamp', 'ion', 'burstifg', 'mergebursts', 'filter', 'unwrap', 'unwrap2stage', 'geocode', 'denseoffsets', 'filteroffsets', 'geocodeoffsets']
   Running step computeBaselines
   Estimated burst offset:  0
   Polynomial Order: 0 - by - 0 
   0	
   Polynomial Order: 0 - by - 0 
   0	
   2020-06-10 16:34:42,968 - isce.topsinsar.runPreprocessor - INFO - 
   ####################################################################################################
       runComputeBaseline
   ----------------------------------------------------------------------------------------------------
   baseline.IW-2 Bpar at midrange for first common burst = 11.276253839668085
   baseline.IW-2 Bpar at midrange for last common burst = 11.123423131101463
   baseline.IW-2 Bperp at midrange for first common burst = -8.915351633813241
   baseline.IW-2 Bperp at midrange for last common burst = -9.343182942817323
   baseline.IW-2 First common burst in master = 0
   baseline.IW-2 First common burst in slave = 0
   baseline.IW-2 Last common burst in master = 9
   baseline.IW-2 Last common burst in slave = 9
   baseline.IW-2 Number of bursts in master = 9
   baseline.IW-2 Number of bursts in slave = 9
   baseline.IW-2 Number of common bursts = 9
   ####################################################################################################
   Dumping the application's pickle object _insar to file  PICKLE/computeBaselines
   The remaining steps are (in order):  ['verifyDEM', 'topo', 'subsetoverlaps', 'coarseoffsets', 'coarseresamp', 'overlapifg', 'prepesd', 'esd', 'rangecoreg', 'fineoffsets', 'fineresamp', 'ion', 'burstifg', 'mergebursts', 'filter', 'unwrap', 'unwrap2stage', 'geocode', 'denseoffsets', 'filteroffsets', 'geocodeoffsets']
   Running step verifyDEM
   Dumping the application's pickle object _insar to file  PICKLE/verifyDEM
   The remaining steps are (in order):  ['topo', 'subsetoverlaps', 'coarseoffsets', 'coarseresamp', 'overlapifg', 'prepesd', 'esd', 'rangecoreg', 'fineoffsets', 'fineresamp', 'ion', 'burstifg', 'mergebursts', 'filter', 'unwrap', 'unwrap2stage', 'geocode', 'denseoffsets', 'filteroffsets', 'geocodeoffsets']
   Running step topo
   Polynomial Order: 0 - by - 0 
   0	
   C pointer already created. Finalize and recreate if image dimensions changed.
   Polynomial Order: 0 - by - 1 
   846318	2.32956	
   C pointer already created. Finalize and recreate if image dimensions changed.
   API open (WR): geom_master/lat.rdr
   API open (WR): geom_master/lon.rdr
   API open (WR): geom_master/los.rdr
   API open (WR): geom_master/hgt.rdr
   GDAL open (R): demLat_N36_N39_Lon_W120_W118.dem.wgs84.vrt
   Initializing Biquintic interpolator...
   Max threads used: 4
   DEM parameters:
   Dimensions: 7200 10800
   Top Left: -120 39
   Spacing: 0.000277778 -0.000277778
   Lon: -120 -118
   Lat: 36.0003 39
   
   Estimated DEM bounds needed for global height range:
   Lon: -119.948 -118.277
   Lat: 36.3506 38.3089
   
   Actual DEM bounds used:
   Dimensions: 6017 7052
   Top Left: -119.948 38.3092
   Spacing: 0.000277778 -0.000277778
   Lon: -119.948 -118.277
   Lat: 36.3506 38.3092
   Lines: 2487 9538
   Pixels: 188 6204
   Max DEM height: 4385
   Primary iterations: 25
   Secondary iterations: 10
   Distance threshold: 0.05
   
   
   Copying Orbit and DEM data to compatible arrays...
   Calculating relevant GPU parameters...
   NOTE: GPU will process image in 3 blocks of 4012 lines (with 207 lines in a final partial block)
   
   
     ------------------ INITIALIZING GPU TOPO ------------------
   
       Loading slantrange and doppler data...
       Allocating host and general GPU memory...
       Copying general memory to GPU...
       Allocating block memory (99991076 pixels per image)...
       (NOTE: There will be 28 'empty' threads per image block).
       Starting GPU Topo for block 0...
        GPU finished block 0 in 17.515279 s.
       Copying memory back to host...
       GPU finished block 0 (with memory copies) in 19.785382 s.
       Cleaning device memory and returning to main Topo function...
     Writing block 0 out (asynchronously) to image files...
       Loading slantrange and doppler data...
       Allocating host and general GPU memory...
       Copying general memory to GPU...
       Allocating block memory (99991076 pixels per image)...
       (NOTE: There will be 28 'empty' threads per image block).
       Starting GPU Topo for block 1...
        GPU finished block 1 in 18.875502 s.
       Copying memory back to host...
       GPU finished block 1 (with memory copies) in 21.192100 s.
       Cleaning device memory and returning to main Topo function...
     Waiting for previous block-write to finish...
     Writing block 1 out (asynchronously) to image files...
       Loading slantrange and doppler data...
       Allocating host and general GPU memory...
       Copying general memory to GPU...
       Allocating block memory (99991076 pixels per image)...
       (NOTE: There will be 28 'empty' threads per image block).
       Starting GPU Topo for block 2...
       GPU finished block 2 in 16.782918 s.
       Copying memory back to host...
       GPU finished block 2 (with memory copies) in 19.047820 s.
       Cleaning device memory and returning to main Topo function...
     Waiting for previous block-write to finish...
     Writing block 2 out (asynchronously) to image files...
       Loading slantrange and doppler data...
       Allocating host and general GPU memory...
       Copying general memory to GPU...
       Allocating block memory (5159061 pixels per image)...
       (NOTE: There will be 75 'empty' threads per image block).
       Starting GPU Topo for remaining lines...
       GPU finished remaining lines in 0.767315 s.
       Copying memory back to host...
       GPU finished remaining lines (with memory copies) in 1.028314 s.
       Cleaning device memory and returning to main Topo function...
     Waiting for previous block-write to finish...
     Writing remaining 207 lines out (asynchronously) to image files...
     Finished writing to files!
   
     ------------------ EXITING GPU TOPO ------------------
   
   Finished!
   ...
   ```
- Screen output of `watch nvidia-smi` during the `topo` step should look something like this:
   ```
   Every 2.0s: nvidia-smi                                 Wed Jun 10 16:35:44 2020
   
   Wed Jun 10 16:35:44 2020
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 440.33.01    Driver Version: 440.33.01    CUDA Version: 10.2     |
   |-------------------------------+----------------------+----------------------+
   | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |===============================+======================+======================|
   |   0  Tesla K80           Off  | 00000000:00:1E.0 Off |                    0 |
   | N/A   62C    P0   145W / 149W |   7101MiB / 11441MiB |    100%      Default |
   +-------------------------------+----------------------+----------------------+
   
   +-----------------------------------------------------------------------------+
   | Processes:                                                       GPU Memory |
   |  GPU       PID   Type   Process name                             Usage      |
   |=============================================================================|
   |    0     23572      C   python3                                     7089MiB |
   +-----------------------------------------------------------------------------+
   ```
- Screen output of `./run_test.sh` at the GPU usage of the `fineoffsets` step should look something like this:
   ```
   The remaining steps are (in order):  ['fineoffsets', 'fineresamp', 'ion', 'burstifg', 'mergebursts', 'filter', 'unwrap', 'unwrap2stage', 'geocode', 'denseoffsets', 'filteroffsets', 'geocodeoffsets']
   Running step fineoffsets
   2020-06-10 16:50:00,077 - isce.topsinsar.fineoffsets - INFO - IW2 - Burst 0 of master matched with Burst 0 of slave
   GDAL open (R): geom_master/IW2/lat_01.rdr.vrt
   GDAL open (R): geom_master/IW2/lon_01.rdr.vrt
   GDAL open (R): geom_master/IW2/hgt_01.rdr.vrt
   2020-06-10 16:50:00,098 - isce.topsinsar.fineoffsets - INFO - Additional time offset applied in geo2rdr: 2.153986467468422e-06 secs
   2020-06-10 16:50:00,098 - isce.topsinsar.fineoffsets - INFO - Additional range offset applied in geo2rdr: 0.10291236263748232 m
   API open (WR): fine_offsets/IW2/range_01.off
   API open (WR): fine_offsets/IW2/azimuth_01.off
   Geo2rdr executing on 4 threads...
   Starting Acquisition time: 50345.415009
   Stop Acquisition time: 50348.510677
   Azimuth line spacing in secs: 0.002056
   Near Range in m: 846318.292869
   Far  Range in m: 904375.639892
   Range sample spacing in m: 2.329562
   Radar Image Length: 1507
   Radar Image Width: 24923
   Reading DEM...
   Geocoded Lines:   1507
   Geocoded Samples: 24923
   Dopplers: 0.000000 0.000000
   
   Copying Orbit and Poly1d data to compatible arrays...
   Calculating relevant GPU parameters...
   NOTE: GPU will process image in 1 runs of 1507 lines
   
   
     ------------------ INITIALIZING GPU GEO2RDR ------------------
   
       Loading relevant geometry product data...
       Allocating memory...
       Done.
       Copying data to GPU...
       (NOTE: There will be 79 'empty' threads).
       Starting GPU Geo2rdr for run 0...
       GPU finished run 0 in 2.615183 s.
       Copying memory back to host...
       GPU finished run 0 (with memory copies) in 3.174820 s.
       Cleaning device memory and returning to main Geo2rdr function...
     Writing run 0 out asynchronously to image files...
     Finished writing to files!
   
     ------------------ EXITING GPU GEO2RDR ------------------
   
   Finished!
   Elapsed time = 6.905782 seconds
   ```
- Screen output of `watch nvidia-smi` during the `fineoffsets` step should look something like this:
   ```
   Every 2.0s: nvidia-smi                                 Wed Jun 10 16:50:24 2020
   
   Wed Jun 10 16:50:24 2020
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 440.33.01    Driver Version: 440.33.01    CUDA Version: 10.2     |
   |-------------------------------+----------------------+----------------------+
   | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |===============================+======================+======================|
   |   0  Tesla K80           Off  | 00000000:00:1E.0 Off |                    0 |
   | N/A   50C    P0   146W / 149W |   2079MiB / 11441MiB |    100%      Default |
   +-------------------------------+----------------------+----------------------+
   
   +-----------------------------------------------------------------------------+
   | Processes:                                                       GPU Memory |
   |  GPU       PID   Type   Process name                             Usage      |
   |=============================================================================|
   |    0     23572      C   python3                                     2068MiB |
   +-----------------------------------------------------------------------------+
   ```
- Output files:
   ```
   ls -al
   total 18643200
   drwxr-xr-x 12 ops  ops        4096 Jun 10 17:19 .
   drwxrwxrwt  1 root root         30 Jun 10 16:33 ..
   drwxr-xr-x  3 ops  ops          22 Jun 10 17:06 coarse_coreg
   drwxr-xr-x  3 ops  ops          22 Jun 10 17:11 coarse_interferogram
   drwxr-xr-x  3 ops  ops          22 Jun 10 17:05 coarse_offsets
   -rw-r--r--  1 ops  ops   155520000 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem
   -rw-r--r--  1 ops  ops         529 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem.vrt
   -rw-r--r--  1 ops  ops   155520000 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem.wgs84
   -rw-r--r--  1 ops  ops         535 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem.wgs84.vrt
   -rw-r--r--  1 ops  ops        4493 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem.wgs84.xml
   -rw-r--r--  1 ops  ops        4283 Jun 10 16:25 demLat_N36_N39_Lon_W120_W118.dem.xml
   drwxr-xr-x  2 ops  ops        8192 Jun 10 17:19 ESD
   drwxr-xr-x  3 ops  ops          17 Jun 10 17:19 fine_offsets
   drwxr-xr-x  4 ops  ops         245 Jun 10 17:05 geom_master
   drwxr-xr-x  9 ops  ops         196 Jun 10 17:23 .git
   -rw-r-----  1 ops  ops         135 Jun 10 16:26 .gitattributes
   -rw-r--r--  1 ops  ops       57749 Jun 10 17:20 isce.log
   drwxr-xr-x  4 ops  ops          48 Jun 10 17:05 master
   drwxr-xr-x  2 ops  ops        4096 Jun 10 17:20 PICKLE
   -rw-r--r--  1 ops  ops       20550 Jun 10 16:58 README.md
   -rw-r--r--  1 ops  ops      361740 Jun 10 17:20 run_test.log
   -rwxr-xr-x  1 ops  ops         451 Jun 10 16:59 run_test.sh
   -rw-r--r--  1 ops  ops  4723397597 Jun 10 16:30 S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip
   -rw-r--r--  1 ops  ops  2147483648 Jun 10 16:25 S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip.00
   -rw-r--r--  1 ops  ops  2147483648 Jun 10 16:25 S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip.01
   -rw-r--r--  1 ops  ops   428430301 Jun 10 16:25 S1B_IW_SLC__1SDV_20191112T135904_20191112T135932_018895_023A35_DE2D.zip.02
   -rw-r--r--  1 ops  ops  4665577254 Jun 10 16:30 S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip
   -rw-r--r--  1 ops  ops  2147483648 Jun 10 16:25 S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip.00
   -rw-r--r--  1 ops  ops  2147483648 Jun 10 16:25 S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip.01
   -rw-r--r--  1 ops  ops   370609958 Jun 10 16:25 S1B_IW_SLC__1SDV_20191124T135904_20191124T135932_019070_023FD5_1504.zip.02
   -rw-r--r--  1 ops  ops      559478 Jun 10 16:25 S1B_OPER_AUX_RESORB_OPOD_20191112T153915_V20191112T114113_20191112T145843.EOF
   -rw-r--r--  1 ops  ops      559479 Jun 10 16:25 S1B_OPER_AUX_RESORB_OPOD_20191124T153150_V20191124T114113_20191124T145843.EOF
   drwxr-xr-x  3 ops  ops          32 Jun 10 17:04 slave
   -rw-r--r--  1 ops  ops        2219 Jun 10 16:24 topsApp.xml
   -rw-r--r--  1 ops  ops           0 Jun 10 17:03 topsinsar.log
   -rw-r--r--  1 ops  ops        7228 Jun 10 17:20 topsProc.xml
   ```
