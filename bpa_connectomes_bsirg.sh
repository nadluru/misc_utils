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