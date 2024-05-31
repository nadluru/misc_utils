# convert the design and contrast matrices to be compatible with palm
# palm expects .mat and .con
parallel -k '
parallel --bar --rpl '\''{p} s:.txt::'\'' -I // Text2Vest // {p}.{2} ::: /study/midus3/processed_data/loneliness_DWI/model_contrast_matrices/*_{1}.txt
' ::: model contrast :::+ mat con

# generating condor dag file for submitting palm jobs (#120)
# dwi models (#4) x loneliness models (#10) x masks (#3)
# dwi: dti, noddi, dki, wmti
# loneliness (see the block above)
# masks: wm skeleton, amygdala, hippocampus
parallel --bar '
source condor_utilities/CondorFunctions.sh
export job={1}_{3/.}_{4/.}
export numCPUs=1
# export RAM="2 Gb" # this did not complete the jobs but the logs did not imply the reason.
export RAM="32 Gb" # this worked
export initialDir={5}/{3/.}/condor_logs;mkdir -p $initialDir
export executable=/study/midus3/processed_data/loneliness_DWI/palm_exec/palm/palm
export args=$(echo {2} -d {3} -t {=3 s:_model.mat:_contrast.con: =} -m {4} -o {5}/{3/.}/{1}_{3/.}_{4/.} -tfce2D -n 500 -accel gamma -T -save1-p -npc -corrmod)
CondorEcho' \
::: dti noddi dki wmti \
:::+ "$(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_{fa,md,rd}_loneliness.nii | sed "s:^:-i :" | tr "\n" " ")" "$(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/mtnoddi*_loneliness.nii | sed "s:^:-i :" |tr "\n" " ")" "$(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_qc_{mk,rk}_loneliness.nii | sed "s:^:-i :" | tr "\n" " ")" "$(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_qc_{awf,eas*,ias*}_loneliness.nii | sed "s:^:-i :" | tr "\n" " ")" \
::: /study/midus3/processed_data/loneliness_DWI/model_contrast_matrices/*_model.mat \
::: /study/midus3/processed_data/loneliness_DWI/template/m3/{average_fa_1mm_skeleton,hippo_mask_study,Amygdala_mask_study}.nii \
::: /study/midus3/processed_data/loneliness_DWI/palm \
> /study/midus3/processed_data/loneliness_DWI/loneliness_DWI_05162024.dag

condor_submit_dag /study/midus3/processed_data/loneliness_DWI/loneliness_DWI_05162024.dag

# tbss_fill the full set of 1-p value files: (tfce, vox) x (npc, tstat) x (fwep, mfwep,uncp)
parallel --bar '
mkdir -p {1//}/visualization
tbss_fill {1} 0.95 {2} {1//}/visualization/{1/.}_fill' ::: /study/midus3/processed_data/loneliness_DWI/palm/*/*{fwep,uncp}*.nii ::: /study/midus3/processed_data/dmri_transformations/sharp_averages/average_fa.nii.gz

# connectedcomp
parallel --dry-run --plus '
fslmaths {} -bin {..}_bin
connectedcomp {..}_bin {..}_bin_cc' ::: /study/midus3/processed_data/loneliness_DWI/palm/*/visualization/*fill.nii.gz

# #voxels in the clusters
parallel --bar -k --plus \
--rpl '{tokens} 
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(m[0-9]+)_.*(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,\8,\9:;
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,,\8:' '
fslstats -K {} {} -V -C | awk '\''{print $1}'\'' | \
parallel -j1 -k -I // --progress --seqreplace "/#/" "
num_clusters=$(fslstats {} -R | awk '\''{printf "%d", $2}'\'')
echo C\$(((/#/-1)%\$num_clusters+1)),//,{tokens}"' \
::: /study/midus3/processed_data/loneliness_DWI/palm/*/visualization/*cc.nii.gz | \
sed "1s:^:cluster,clustersize,dwi,loneliness,index,source_mask,cluster_approach,stat,ptype,dwi_m,contrast\n:" > /study/midus3/processed_data/loneliness_DWI/palm/clustersize_comprehensive.csv

# dwi in clusters in population template space
parallel -j24 --bar '
ls /study/midus3/processed_data/loneliness_DWI/palm/{5/.}/visualization/{1}*tstat*_{2}_*cc.nii.gz ls /study/midus3/processed_data/loneliness_DWI/palm/{5/.}/visualization/{1}*npc_fisher*cc.nii.gz | \
parallel -j1 -I %% -k --plus --progress \
--rpl '\''{tokens} 
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(m[0-9]+)_.*(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,\8,\9:;
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,,\8:'\'' '\'' 
fslstats -t -K %% {4} -P 50 | \
parallel -j1 -k -I // --progress --slotreplace "/%/" --seqreplace "/#/" " num_clusters=$(fslstats %% -R | cut -d" " -f2 | sed "s:\.0.*::")
echo S\$(((/#/-1)/\$num_clusters+1)),C\$(((/#/-1)%\$num_clusters+1)),//,{3},{tokens}" '\'' ' \
::: dti dti dti noddi noddi noddi dki dki wmti wmti wmti wmti \
:::+ m1 m2 m3 m1 m2 m3 m1 m2 m1 m2 m3 m4 \
:::+ fa md rd csf ndi odi mk rk awf eas_de_perp eas_tort ias_da \
:::+ $(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_{fa,md,rd}_loneliness.nii) $(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/mtnoddi*_loneliness.nii) $(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_qc_{mk,rk}_loneliness.nii) $(ls /study/midus3/processed_data/loneliness_DWI/4dfiles/dki_qc_{awf,eas*,ias*}_loneliness.nii) \
::: /study/midus3/processed_data/loneliness_DWI/model_contrast_matrices/*_model.mat | \
sed 's:" "::g;1s:^:id,cluster,median,dwi_m_name,dwi,loneliness,index,source_mask,cluster_approach,stat,ptype,dwi_m,contrast\n:' > /study/midus3/processed_data/loneliness_DWI/palm/cluster_dwi_comprehensive.csv

# save individual cluster images (C[0-9]+) from the conected component (cc) images
parallel --bar --plus 'seq -f "%02g" 1 $(fslstats {1} -R | awk '\''{print int($2)}'\'') | \
parallel -I // --bar "
fslmaths {} -thr // -uthr // {..}_C//"' \
::: /study/midus3/processed_data/loneliness_DWI/palm/*/visualization/*cc.nii.gz

# warpin cc_C[0-9]+ to mni with integer valued interpolation
find /study/midus3/processed_data/loneliness_DWI/palm/ -regex '.*/visualization/.*_cc_C[0-9]+\.nii\.gz' | \
parallel --progress --plus '
mkdir -p {//}/cc_C_mni_int
antsApplyTransforms -d 3 \
-i {} \
-r $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz \
-t [/study/midus3/processed_data/loneliness_DWI/template/transforms/m3/MNI_to_study0GenericAffine.mat,1] \
-t /study/midus3/processed_data/loneliness_DWI/template/transforms/m3/MNI_to_study1InverseWarp.nii.gz \
-n genericlabel \
-o {//}/cc_C_mni_int/{/..}_in_mni_int.nii.gz \
-v'

# warping cc files to mni with linear interpolation
parallel --bar --plus '
mkdir -p {//}/cc_mni
antsApplyTransforms -d 3 \
-i {} \
-r $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz \
-t [/study/midus3/processed_data/loneliness_DWI/template/transforms/m3/MNI_to_study0GenericAffine.mat,1] \
-t /study/midus3/processed_data/loneliness_DWI/template/transforms/m3/MNI_to_study1InverseWarp.nii.gz \
-n linear \
-o {//}/cc_mni/{/..}_in_mni.nii.gz \
-v' \
::: /study/midus3/processed_data/loneliness_DWI/palm/*/visualization/*cc.nii.gz

# atlasquery of cc_C[0-9]+_in_mni_int files
# dwi x loneliness -> clusters -> . x atlasquery
find /study/midus3/processed_data/loneliness_DWI/palm/ -regex '.*/visualization/cc_C_mni_int/.*_cc_C[0-9]+_in_mni_int\.nii\.gz' | \
parallel -k --plus --progress \
--rpl '{tokens} 
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(m[0-9]+)_.*(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,\8,\9:;
s:.*/(dti|dki|noddi|wmti)_(.*)_(i_[0-9]+)_model_(.*)_(vox|tfce).*_(tstat|npc_fisher).*_(fwep|mfwep|uncp).*_(c[0-9]+)_(.*):\1,\2,\3,\4,\5,\6,\7,,\8:' \
--rpl '{r} s: :-:g' '
atlasquery -a {2} -m {1} | \
sed -E '\''s:,:-:g;s/(.*)(:)([0-9].*)/\1,\3/g;s:^:{1tokens},{=1 s:.*cc_(.*)_in_mni.*:\1: =},{2r},:g'\''
' \
:::: - \
:::: <(atlasquery --dumpatlases | grep -iv Macaque) | \
sed '1s:^:dwi,loneliness,index,source_mask,cluster_approach,stat,ptype,dwi_m,contrast,cluster,atlasname,regionname,probability\n:;s:tbss_harmonized_::g' > /study/midus3/processed_data/loneliness_DWI/palm/cluster_fslatlases_comprehensive.csv

# might need to run on a system without x-forwarding
find /study/midus3/processed_data/loneliness_DWI/palm/ -regex '.*/visualization/cc_C_mni/.*_cc_C[0-9]+_in_mni\.nii\.gz \| .*/visualization/cc_mni/.*cc_in_mni\.nii\.gz' | \
parallel -k -j1 --plus --dry-run --rpl '{o} s:(.*visualization/).*:\1fsleyes:' '
mkdir -p {o}
visualize_tbss_clusters.sh {} {o}'
