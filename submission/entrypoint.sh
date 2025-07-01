#!/bin/bash

echo "Data available in paths :"
echo " - ROOT INPUT"
ls -lha /input
echo " - IMAGE INPUT"
ls -lha /input/images/dwi-4d-brain-mri
echo "Preparing working environment"
mkdir -p /workdir/data
ln -s /input/dwi-4d-acquisition-metadata.json /workdir/data/.
ln -s /input/images/dwi-4d-brain-mri/*.mha /workdir/data/.
echo "Launching nextflow with extra configuration : $@"
DIPY_HOME=/tmp/.dipy SCILPY_HOME=/tmp/.scilpy NXF_DISABLE_CHECK_LATEST=true NXF_OFFLINE=true nextflow run /beyond_fa_challenge \
    --input /workdir \
    --output /output $@ -resume
cat .nextflow.log
echo "Done !"
