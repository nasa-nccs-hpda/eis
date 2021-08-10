READme for running EIS Zarr conversion software on a container

1) Log onto Discover
>> ssh discover.nccs.nasa.gov

2) Change to your directory and directory list out the new container
>> /discover/nobackup/projects/eis_freshwater/bmcandr/datamove/containers> l eis_zarr.sif
-rwxr-xr-x 1 sstrong s2443 4076212224 Aug 10 13:07 eis_zarr.sif*

3) Copy the "zc.cfg_chunks" to "zc.cfg". *Note the old zc.cfg is deprecated for new container and also note the quoted strings. Change t
he output_dir path (shown below) to your desired output location:
>> cp zc.cfg_chunks zc.cfg
>> vi zc.cfg (or editor of choice)
cache       = "/gpfsm/dnb43/projects/p151/zarr"
time_format = "%Y%m%d%H%M"
batch_size  = 1000
merge_dim   = "time"
bucket      = "eis-dh-hydro"
input_dir   = "/discover/nobackup/projects/eis_freshwater"
output_dir  = "/discover/nobackup/sstrong/containers/output/zarr_chunk"
input_dset  = "lahmers/RUN/1km_DOMAIN_DAens20_MCD15A2H.006_2019Flood/OUTPUT/SURFACEMODEL/**/LIS_HIST*.nc"
output_dset = "LIS/DA_1km/MODIS_Flood_2019/SURFACEMODEL/LIS_HIST.d01"
cat_name    = "LIS.1km_DOMAIN_DAens20_MCD15A2H.006_2019Flood.SURFACEMODEL"
chunks      =  { "time": 25, "north_south": 100, "east_west": 100 }

4) Edit the eis_zarr.sbatch script. Make sure you are pointing to eis_zarr.sif and proper zc.cfg. 
#Modify the directory paths to your local path accordingly
#Change the directory paths to config file accordingly.
singularity exec -B /discover/nobackup/sstrong:/discover/nobackup/sstrong,/discover/nobackup/projects/eis_freshwater/lahmers:/discover/n
obackup/projects/eis_freshwater/lahmers /discover/nobackup/projects/eis_freshwater/bmcandr/datamove/containers/eis_zarr.sif python /usr/
local/eis_smce/workflows/zarr_conversion.py /discover/nobackup/projects/eis_freshwater/bmcandr/datamove/containers/zc.cfg

5) Run the batch script

>> sbatch --nodes=1 --time=12:00:00 eis_zarr.sbatch

6) Output
zarr.err
zarr.out

7) Results

sstrong@discover33:/discover/nobackup/sstrong/containers/output/zarr_chunk/LIS/DA_1km/MODIS_Flood_2019/SURFACEMODEL/LIS_HIST.d01.zarr> l
total 1536
drwx------ 27 sstrong k3000 32768 May 19 11:52 ./
drwx------  3 sstrong k3000   512 May 19 11:52 ../
drwx------  2 sstrong k3000 32768 May 19 11:55 Albedo_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 CanopInt_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 ECanop_tavg/
drwx------  2 sstrong k3000   512 May 19 11:55 _eis_source_path/
drwx------  2 sstrong k3000 32768 May 19 11:55 ESoil_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 GPP_tavg/
drwx------  2 sstrong k3000   512 May 19 11:55 _history/
drwx------  2 sstrong k3000 32768 May 19 11:55 LAI_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 lat/
drwx------  2 sstrong k3000 32768 May 19 11:55 lon/
drwx------  2 sstrong k3000 32768 May 19 11:55 NEE_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Qg_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Qh_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Qle_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Qsb_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Qs_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 RadT_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 Snowcover_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 SnowDepth_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 SoilMoist_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 SWE_tavg/
drwx------  2 sstrong k3000   512 May 19 11:55 time/
drwx------  2 sstrong k3000 32768 May 19 11:55 TotalPrecip_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 TVeg_tavg/
drwx------  2 sstrong k3000 32768 May 19 11:55 TWS_tavg/
-rw-------  1 sstrong k3000   655 May 19 11:52 .zattrs
-rw-------  1 sstrong k3000    24 May 19 11:52 .zgroup
-rw-------  1 sstrong k3000 26752 May 19 11:52 .zmetadata
