#!/bin/bash

# standard reorientation
ls raw_t1w_nifti.nii.gz | parallel --plus fslreorient2std -m {..}_stdorient.mat {} {..}_stdorient
# b1 bias correction
ls *stdorient.nii.gz | parallel --plus N4BiasFieldCorrection -d 3 -i {} -r -o {..}_bfc.nii.gz
# brain mask estimation
ls *_bfc.nii.gz | parallel --plus antsBrainExtraction.sh -d 3 -a {} -e $FSLDIR/MNI152_T1_1mm.nii.gz -m $FSLDIR/MNI152_T1_1mm_brain_mask.nii.gz -o {..}_ -k 1 -c 3x1x2x3
# applying the mask
ls *stdorient_bfc.nii.gz | parallel --plus fslmaths {} -mas {..}_BrainExtractionMask.nii.gz {..}_masked
