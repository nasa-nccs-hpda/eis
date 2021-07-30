READme for running EIS SMCE zarr conversion software on a container

1) Log onto Discover
>> ssh discover.nccs.nasa.gov

2)  Navigate to your nobackup directory
>> cd $NOBACKUP
>> mkdir containers
>> cd $NOBACKUP/containers

3) copy container, zc.cfg, and eis_smce_zarr_conv_1.0.2.sbatch files 
>> cp /discover/nobackup/sstrong/containers/eis-dev-1.0.2.sif .
>> cp /discover/nobackup/sstrong/eis_delivery/*.* .

4) Edit the zc.cfg. Change the output_dir path (shown below) to your desired output location:
>> vi zc.cfg (or editor of choice)
cache       = /gpfsm/dnb43/projects/p151/zarr
time_format = %Y%m%d%H%M
batch_size  = 1000
merge_dim   = time
bucket      = eis-dh-hydro
input_dir   = /discover/nobackup/projects/eis_freshwater
output_dir  = /discover/nobackup/<username>/output/zarr
input_dset  = lahmers/RUN/1km_DOMAIN_DAens20_MCD15A2H.006_2019Flood/OUTPUT/SURFACEMODEL/**/LIS_HIST*.nc
output_dset = LIS/DA_1km/MODIS_Flood_2019/SURFACEMODEL/LIS_HIST.d01

5) Edit the eis_smce_zarr_conv_1.0.2.sbatch script. 
#Modify the directory paths to your local path accordingly
singularity exec -B /discover/nobackup/bmcandr1:/discover/nobackup/bmcandr1,/discover/nobackup/projects/eis_freshwater/lahmers:/discover/nobackup/projects/eis_freshwater/lahmers /discover/nobackup/bmcandr1/containers/eis-dev-1.0.2.sif python /usr/local/eis_smce/workflows/zarr_conversion.py /discover/nobackup/bmcandr1/containers/zc.cfg

6) Run the batch script

>> sbatch --nodes=1 --time=12:00:00 eis_smce_zarr_conv_1.0.2.sbatch

7) Output
zarr.err
zarr.out

8) Results

sstrong@discover33:/discover/nobackup/sstrong/containers/output/zarr/LIS/DA_1km/MODIS_Flood_2019/SURFACEMODEL/LIS_HIST.d01.zarr> l
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


