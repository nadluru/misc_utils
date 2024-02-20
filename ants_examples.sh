parallel antsRegistrationSyN.sh -d 3 -f $FSLDIR/data/standard/MNI152_T1_1mm_brain.nii.gz -m {} -o {/..}_to_mni_ ::: /path_to_t1_native_files/*t1w_masked.nii.gz
