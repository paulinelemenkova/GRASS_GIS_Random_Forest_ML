#!/bin/sh

# create new location from raster map (file must contain projection metadata):
# grass -c myraster.tif /home/user/grassdata/mynewlocation
grass
cd /Users/polinalemenkova/grassdata
grass -c LC09_L2SP_179073_20220419_20230421_02_T1_SR_B1.tif /Users/polinalemenkova/grassdata/Namibia

# 1. Import data
# listing the files

# g.mapset location=Namibia mapset=PERMANENT

# g.list rast
# importing the image subset with 7 Landsat bands and display the raster map
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B1.TIF output=L8_2015_01 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B2.TIF output=L8_2015_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B3.TIF output=L8_2015_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B4.TIF output=L8_2015_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B5.TIF output=L8_2015_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B6.TIF output=L8_2015_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20150709_20200909_02_T1_SR_B7.TIF output=L8_2015_07 extent=region resolution=region
#
g.list rast
# creating color composites
# false color
r.composite blue=L8_2015_07 green=L8_2015_05 red=L8_2015_03 output=L8_2015_753 --overwrite
d.mon wx0
d.rast L8_2015_753
d.out.file output=Mozambique_753 format=jpg --overwrite
# true color
r.composite blue=L8_2015_02 green=L8_2015_03 red=L8_2015_04 output=L8_2015_234 --overwrite
d.mon wx0
d.rast L8_2015_234
d.out.file output=Mozambique_234 format=jpg --overwrite
# false color: NIR band B05 in the red channel, red band B04 in the green channel and green band B03 in the blue channel
r.composite blue=L8_2015_03 green=L8_2015_04 red=L8_2015_05 output=L8_2015_345 --overwrite
d.mon wx0
d.rast L8_2015_345
d.out.file output=Mozambique_345 format=jpg --overwrite

# grouping data by i.group
# Set computational region to match the scene
g.region raster=L8_2015_01 -p
i.group group=L8_2015 subgroup=res_30m \
  input=L8_2015_01,L8_2015_02,L8_2015_03,L8_2015_04,L8_2015_05,L8_2015_06,L8_2015_07
#
# Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2015 subgroup=res_30m \
  signaturefile=cluster_L8_2015 \
  classes=10 reportfile=rep_clust_L8_2015.txt --overwrite

# Classification by i.maxlik module
#
i.maxlik group=L8_2015 subgroup=res_30m \
  signaturefile=cluster_L8_2015 \
  output=L8_2015_cluster_classes reject=L8_2015_cluster_reject --overwrite
#
# Mapping
d.mon wx0
g.region raster=L8_2015_cluster_classes -p
r.colors L8_2015_cluster_classes color=roygbiv -e
d.rast L8_2015_cluster_classes
d.legend raster=L8_2015_cluster_classes title="July 9 2015" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2015 format=jpg --overwrite
#
# 2018
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B1.TIF output=L8_2018_01 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B2.TIF output=L8_2018_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B3.TIF output=L8_2018_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B4.TIF output=L8_2018_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B5.TIF output=L8_2018_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B6.TIF output=L8_2018_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC08_L2SP_167074_20180919_20200830_02_T1_SR_B7.TIF output=L8_2018_07 extent=region resolution=region
g.list rast
#
# grouping data by i.group. Set computational region to match the scene
g.region raster=L8_2018_01 -p
i.group group=L8_2018 subgroup=res_30m \
  input=L8_2018_01,L8_2018_02,L8_2018_03,L8_2018_04,L8_2018_05,L8_2018_06,L8_2018_07
#
# Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2018 subgroup=res_30m \
  signaturefile=cluster_L8_2018 \
  classes=10 reportfile=rep_clust_L8_2018.txt --overwrite

# Classification by i.maxlik module
i.maxlik group=L8_2018 subgroup=res_30m \
  signaturefile=cluster_L8_2018 \
  output=L8_2018_cluster_classes reject=L8_2018_cluster_reject --overwrite

# Mapping
d.mon wx0
g.region raster=L8_2018_cluster_classes -p
r.colors L8_2018_cluster_classes color=roygbiv -e
d.rast L8_2018_cluster_classes
d.legend raster=L8_2018_cluster_classes title="19 September 2018" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2018 format=jpg --overwrite

# 2023
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B1.TIF output=L9_2023_01 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B2.TIF output=L9_2023_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B3.TIF output=L9_2023_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B4.TIF output=L9_2023_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B5.TIF output=L9_2023_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B6.TIF output=L9_2023_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Mozambique/LC09_L2SP_167074_20230824_20230826_02_T1_SR_B7.TIF output=L9_2023_07 extent=region resolution=region
g.list rast
#
# grouping data by i.group. Set computational region to match the scene
g.region raster=L9_2023_01 -p
i.group group=L9_2023 subgroup=res_30m \
  input=L9_2023_01,L9_2023_02,L9_2023_03,L9_2023_04,L9_2023_05,L9_2023_06,L9_2023_07
#
# Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L9_2023 subgroup=res_30m \
  signaturefile=cluster_L9_2023 \
  classes=10 reportfile=rep_clust_L9_2023.txt --overwrite

# Classification by i.maxlik module
i.maxlik group=L9_2023 subgroup=res_30m \
  signaturefile=cluster_L9_2023 \
  output=L9_2023_cluster_classes reject=L9_2023_cluster_reject --overwrite

# Mapping
d.mon wx0
g.region raster=L9_2023_cluster_classes -p
r.colors L9_2023_cluster_classes color=roygbiv -e
d.rast L9_2023_cluster_classes
d.legend raster=L9_2023_cluster_classes title="24 August 2023" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2023 format=jpg --overwrite

# Mapping rejection probability
d.mon wx1
g.region raster=L8_2015_cluster_classes -p
r.colors L8_2015_cluster_reject color=bcyr -e
d.rast L8_2015_cluster_reject
d.legend raster=L8_2015_cluster_reject title="July 9 2015" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2015_reject format=jpg --overwrite
# 2018
d.mon wx1
g.region raster=L8_2018_cluster_classes -p
r.colors L8_2018_cluster_reject color=bcyr -e
d.rast L8_2018_cluster_reject
d.legend raster=L8_2018_cluster_reject title="19 September 2018" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2018_reject format=jpg --overwrite
# 2023
d.mon wx1
g.region raster=L9_2023_cluster_classes -p
r.colors L9_2023_cluster_reject color=bcyr -e
d.rast L9_2023_cluster_reject
d.legend raster=L9_2023_cluster_reject title="24 August 2023" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Mozambique_2023_reject format=jpg --overwrite


# MACHINE LEARNING
# 2015
g.region raster=L8_2015_01 -p
# First, we are going to generate some training pixels from an older (1996) land cover classification:
r.random input=L8_2015_cluster_classes seed=100 npoints=1000 raster=L8_2015_classes_roi --overwrite
# Next, we create the imagery group with all Landsat-8 OLI/TIRS 7 (2000) bands:
i.group group=L8_2015 input=L8_2015_01,L8_2015_02,L8_2015_03,L8_2015_04,L8_2015_05,L8_2015_06,L8_2015_07 --overwrite
# Then use these training pixels to perform a classification on recent Landsat - 2022 image:
# train a random forest classification model using r.learn.train
r.learn.train group=L8_2015 training_map=L8_2015_classes_roi model_name=RandomForestClassifier n_estimators=500 save_model=rf_model.gz --overwrite
# perform prediction using r.learn.predict
r.learn.predict group=L8_2015 load_model=rf_model.gz output=rf_classification --overwrite
# check raster categories - they are automatically applied to the classification output
r.category rf_classification
# copy color scheme from landclass training map to result
r.colors rf_classification raster=L8_2015_classes_roi
# display
d.mon wx1
r.colors rf_classification color=plasma -e
d.rast rf_classification
d.legend raster=rf_classification title="Random Forest: 2015" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=RF_Mozambique_2015 format=jpg --overwrite

# 2018
g.region raster=L8_2018_01 -p
# Generate some training pixels from a previously done land cover classification:
r.random input=L8_2015_cluster_classes seed=100 npoints=1000 raster=L8_2018_classes_roi --overwrite
# Next, we create the imagery group with all Landsat-8 OLI/TIRS 7 (2000) bands:
i.group group=L8_2018 input=L8_2018_01,L8_2018_02,L8_2018_03,L8_2018_04,L8_2018_05,L8_2018_06,L8_2018_07 --overwrite
#  Then use these training pixels to perform a classification on the target Landsat image and train a random forest classification model using r.learn.train
r.learn.train group=L8_2018 training_map=L8_2018_classes_roi model_name=RandomForestClassifier n_estimators=500 save_model=rf_model.gz --overwrite
# perform prediction using r.learn.predict
r.learn.predict group=L8_2018 load_model=rf_model.gz output=rf_classification --overwrite
# check raster categories - they are automatically applied to the classification output
r.category rf_classification
# copy color scheme from landclass training map to result
r.colors rf_classification raster=L8_2018_classes_roi
# display
d.mon wx1
r.colors rf_classification color=plasma -e
d.rast rf_classification
d.legend raster=rf_classification title="Random Forest: 2018" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=RF_Mozambique_2018 format=jpg --overwrite

# 2023
g.region raster=L9_2023_01 -p
# Generate some training pixels from a previously done land cover classification:
r.random input=L8_2015_cluster_classes seed=100 npoints=1000 raster=training_pixels --overwrite
# Next, we create the imagery group with all Landsat-8 OLI/TIRS 7 (2000) bands:
i.group group=L9_2023 input=L9_2023_01,L9_2023_02,L9_2023_03,L9_2023_04,L9_2023_05,L9_2023_06,L9_2023_07 --overwrite
#  Then use these training pixels to perform a classification on the target Landsat image and train a random forest classification model using r.learn.train
r.learn.train group=L9_2023 training_map=training_pixels model_name=RandomForestClassifier n_estimators=500 save_model=rf_model.gz --overwrite
# perform prediction using r.learn.predict
r.learn.predict group=L9_2023 load_model=rf_model.gz output=rf_classification --overwrite
# check raster categories - they are automatically applied to the classification output
r.category rf_classification
# copy color scheme from landclass training map to result
r.colors rf_classification raster=L9_2023_classes_roi
# display
d.mon wx1
r.colors rf_classification color=plasma -e
d.rast rf_classification
d.legend raster=rf_classification title="Random Forest: 2023" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=RF_Mozambique_2023 format=jpg --overwrite


# Then we use these training pixels to perform a classification on recent Landsat-8 2022 image:
#r.learn.ml group=L8_2022 trainingmap=L8_2015_classes_roi output=rf_classification \
  classifier=RandomForestClassifier n_estimators=500
r.learn.ml group=L8_2022 trainingmap=cluster_L8_2015 output=rf_classification \
  classifier=RandomForestClassifier n_estimators=500
    
  
# copy category labels from landclass training map to result
r.category rf_classification raster=L8_2015_classes_roi
# copy color scheme from landclass training map to result
r.colors rf_classification raster=landclass96_roi
r.category rf_classification

