# misc_utils
## reorienting nifti images
[c3d](https://sourceforge.net/projects/c3d/)
```bash
c3d t1w.nii -orient LSP -origin-voxel 50% -o t1w_reoriented_itksnap.nii
```
The `-orient` input to the command could be obtained by visually inspecting an image in ITK-SNAP and running the Reorient Image tool. `-origin-voxel 50%` centers the image.
## dwi palm guide with an example
[dwi ~ loneliness in (midus)](https://github.com/nadluru/misc_utils/wiki/DWI-PALM-example-guide)
## updating the file time stamps for the files within a /path to be current
```bash
find /path | parallel --progress touch {}
```
## extracting intracranial volumes from freesurfer outputs
```bash
export SUBJECTS_DIR=/path/to/toplevel/freesurfer/output
cd $SUBJECTS_DIR
parallel 'echo {},$(mri_segstats --subject {} --etiv-only | grep -i etiv | sed "s:.*= ::;s: .*::;1d")' ::: subject_id_prefix* | sed '1s:^:id,icv(mm^3)\n:' > /path/to/csv/output/fs_icv.csv
```
## extracting tissue volumes from freesurfer outputs
```bash
awk '{print FILENAME ", " $0}' /path/to/toplevel/freesurfer/output/*/stats/brainvol.stats | grep -iE 'brainsegnotvent|subcortgray|cortex|whitematter' | sed -E 's:.*output/(.*)/stats.*:\1,&:' | awk -F, '{print $1","$5","$6}' | sed 's:, :,:g;1s:^:id,global,volume(mm^3)\n:' > /path/to/csv/output/fs_tissue_volumes.csv
```
## citation
Please cite the following if you use the wonderful GNU parallel by Ole Tang in your work. You can look for official recommendation by running `parallel --citation`.

Tange, Ole. (2025). GNU Parallel is a general parallelizer to run multiple serial command line programs in parallel without changing them. [DOI](https://doi.org/10.5281/zenodo.14715132)
