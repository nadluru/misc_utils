# misc_utils
## reorienting nifti images
[c3d](https://sourceforge.net/projects/c3d/)
```bash
c3d t1w.nii -orient LSP -origin-voxel 50% -o t1w_reoriented_itksnap.nii
```
The `-orient` input to the command could be obtained by visually inspecting an image in ITK-SNAP and running the Reorient Image tool. `-origin-voxel 50%` centers the image.
## dwi palm guide with an example
[dwi ~ loneliness in (midus)](https://github.com/nadluru/misc_utils/wiki/DWI-PALM-example-guide)
