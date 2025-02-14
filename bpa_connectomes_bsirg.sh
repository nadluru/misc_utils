# 02/07/2025 bpa - biological plausibility analysis of connectomes

# work with Monica Duran and BSIRG team

# orientation for the data folders
cd /study/mover01/
cd /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography
ls tckgen_angle_template/tck_files/individual_tck/angle_*/
cd /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain
ls angle_*/*_{AB,MD}.tck

# key whole brain tract files
ls /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_{4,15}/*_{AB,MD}.tck /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/tck_files/wholebrain/seeding_dynamic/20241019_seedingdynamic_template_rep1_MD.tck /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_{45,90}/*_{AB,MD}.tck

# assignments 
ls /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_4/assignments_20241126_angle4_template_rep1_MD_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_15/assignments_20241130_angle15_template_rep1_AB_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/connectome_files/seeding_dynamic/assignments_20250113_seedingdynamic_template_rep1_MD_noscaled.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_45/assignments_20241130_angle45_template_rep1_AB_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_90/assignments_20241126_angle90_template_rep1_MD_noscale.csv

# weights for streamlines which are summed for computing fbc
ls /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/angle_4/20241126_angle4_template_rep1_MD_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/20241130_angle15_template_rep1_AB_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/sift2_files/seeding_dynamic/20241019_seedingdynamic_template_rep1_MD_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/20241130_angle45_template_rep1_AB_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/angle_90/20241126_angle90_template_rep1_MD_sift.txt

# num_nodes = 68
# num_angles = 5
# total combinations = 68 x 67 / 2 x 5 = 11390
# tracts named
tracts=(/study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_4/20241126_angle4_template_rep1_MD.tck /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_15/20241130_angle15_template_rep1_AB.tck /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/tck_files/wholebrain/seeding_dynamic/20241019_seedingdynamic_template_rep1_MD.tck /study/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_45/20241130_angle45_template_rep1_AB.tck /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/wholebrain/angle_90/20241126_angle90_template_rep1_MD.tck)

# assignments named
assignments=(/study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_4/assignments_20241126_angle4_template_rep1_MD_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_15/assignments_20241130_angle15_template_rep1_AB_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/connectome_files/seeding_dynamic/assignments_20250113_seedingdynamic_template_rep1_MD_noscaled.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_45/assignments_20241130_angle45_template_rep1_AB_noscale.csv /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/connectome_files/angle_90/assignments_20241126_angle90_template_rep1_MD_noscale.csv)

# weights named
weights=(/study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/angle_4/20241126_angle4_template_rep1_MD_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/20241130_angle15_template_rep1_AB_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/seeding_template/sift2_files/seeding_dynamic/20241019_seedingdynamic_template_rep1_MD_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/20241130_angle45_template_rep1_AB_sift.txt /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/sift2_files/angle_90/20241126_angle90_template_rep1_MD_sift.txt)

# node pairs named
node1=($(parallel -k --header : echo {node1} {node2} ::: node1 $(seq 1 68) ::: node2 $(seq 1 68) | awk '$1 < $2' | awk '{print $1}'))
node2=($(parallel -k --header : echo {node1} {node2} ::: node1 $(seq 1 68) ::: node2 $(seq 1 68) | awk '$1 < $2' | awk '{print $2}'))


parallel --dry-run --header : connectome2tck {tracts} {assignments} /placeholder/tracks_{node1}_{node2}.tck -nodes {node1},{node2} -exclusive -files single -tck_weights_in {weights} -prefix_tck_weights_out /placeholder/weights_{node1}_{node2}.txt ::: tracts ${tracts[@]} :::+ assignments ${assignments[@]} :::+ weights ${weights[@]} ::: node1 ${node1[@]} :::+ node2 ${node2[@]}

# mapping exercise (worked!)
parallel -k --header : echo {first} {2} {3} {4} ::: first a b c :::+ second A B C ::: third 1 2 3 :::+ fourth 10 20 30

parallel --bar --header : '
export executable=connectome2tck
export args="{tracts} {assignments} /placeholder/tracks_{node1}_{node2}.tck -nodes {node1},{node2} -exclusive -files single -tck_weights_in {weights} -prefix_tck_weights_out /placeholder/weights_{node1}_{node2}.txt"
export numCPUs=2
export RAM="4 Gb"
export initialDir=/placeholder/for/condorlogs
export job={angles}_{node1}_{node2}
CondorEcho
' ::: angles 4 15 30 45 90 :::+ tracts ${tracts[@]} :::+ assignments ${assignments[@]} :::+ weights ${weights[@]} ::: node1 ${node1[@]} :::+ node2 ${node2[@]} > /scratch/adluru/bpa_date.dag

condor_submit_dag /scratch/adluru/bpa_date.dag

# to do 
# space calculations
# output paths
# output dag to your location and submit dag

# Monica adapted and ran the code and generated the pairwise fiber bundles.

# 02/14/2025 bpa: rendering the fiber bundles pairwise

# fod template/anatomical image
ls /study3/mover01/hartwell_mover01_noASDrelated/T1w_template/antsMultivariateTemplateConstruction/template0_hd-bet.nii.gz
# fiber bundles folder
Tracts out:
ls /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/individual_tck/angle_*/highthroughput_tck_extraction/

echo "4 42
5 43
8 32
9 33
1 23
2 23
10 15
11 14
12 15
13 14
14 20
15 19
46 58
47 57
3 58
3 57
32 57
33 58
8 57
9 58
50 56
51 55
4 60
5 59
46 60
47 59
23 56
23 55
46 59
47 60
57 60
58 59
10 62
11 61
32 62
33 61
36 68
37 67
50 62
51 61
27 64
28 63" | datamash transpose -t ' '

# examples
mkdir -p /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_file_pngs/angle_{4,15,30,45,90}
anatomical_scan=/study3/mover01/hartwell_mover01_noASDrelated/T1w_template/antsMultivariateTemplateConstruction/template0_hd-bet.nii.gz
mrview -load $anatomical_scan -fullscreen -tractography.load /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/individual_tck/angle_30/highthroughput_tck_extraction/tracks_4_42.tck -tractography.slab -1 -capture.folder /study3/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_file_pngs/angle_30 -capture.prefix angle30_node4_node42.png -capture.grab -mode 1 -noannotations -exit # on inca need to figure out libgsl library install etc.

# trying it on andromeda/windows locally.
anatomical_scan=/y/mover01/hartwell_mover01_noASDrelated/T1w_template/antsMultivariateTemplateConstruction/template0_hd-bet.nii.gz
mrview -load $anatomical_scan -mode 2 -noannotations -fullscreen -tractography.load /y/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/individual_tck/angle_30/highthroughput_tck_extraction/tracks_4_42.tck -tractography.slab -1 -capture.folder /y/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_file_pngs/angle_30 -capture.prefix template_angle30_node4_node42.png -capture.grab -exit

# pattern
anatomical_scan=/y/mover01/hartwell_mover01_noASDrelated/T1w_template/antsMultivariateTemplateConstruction/template0_hd-bet.nii.gz
parallel --dry-run --header : mrview -load $anatomical_scan -mode 2 -noannotations -fullscreen -tractography.load /y/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_files/individual_tck/angle_30/highthroughput_tck_extraction/tracks_{node1}_{node2}.tck -tractography.slab -1 -capture.folder /y/mover01/processed-data/derivatives/qmri-neuropipe/studytemplate/dwi/tractography/tckgen_angle_template/tck_file_pngs/angle_{angles} -capture.prefix template_angle{angles}_node{node1}_node{node2}.png -capture.grab -exit ::: angles 4 15 30 45 90 ::: node1 4 5 8 9 1 2 10 11 12 13 14 15 46 47 3 3 32 33 8 9 50 51 4 5 46 47 23 23 46 47 57 58 10 11 32 33 36 37 50 51 27 28 :::+ node2 42 43 32 33 23 23 15 14 15 14 20 19 58 57 58 57 57 58 57 58 56 55 60 59 60 59 56 55 59 60 60 59 62 61 62 61 68 67 62 61 64 63

# angles: 4 15 30 45 90
# File names: tracks_node1_node2.tck (ex: tracks_56_61.tck)

# next steps
# install parallel on mac using homebrew
# update the paths
# do a dry-run copy one output and run an example and then batch.
# if you need to run one at a time just pass -j 1
