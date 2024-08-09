# whole brain
# axial
parallel --bar -j1 --plus '/Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL -s '\''
import gl^
import itertools^
gl.resetdefaults()^
gl.colorbarposition(0)^
gl.fullscreen(1)^
gl.scriptformvisible(0)^
gl.toolformvisible(0)^
gl.bmpzoom(2)^
gl.backcolor(0, 0, 0)^
gl.loadimage("mni152")^
gl.overlayload("{}")^
gl.minmax(1, 0, 1)^
gl.opacity(1, 70)^
gl.linecolor(0, 255, 0)^
gl.mosaic("A L+ V 0 H 0 " + ";".join(map(lambda g: " ".join(map(str, g)), itertools.zip_longest(*[iter(range(-35, 76, 6))]*5, fillvalue=""))) + " S X R 0")^
gl.savebmp("figures/{/..}.png")^
gl.quit()^'\''
' ::: /path/to/{dti_md_age_inter_hidiscage_gt_lodiscage_sig_in_MNI,dti_rd_age_inter_hidiscage_gt_lodiscage_sig_in_MNI,mtnoddi_mtcsf_age_inter_hidiscage_gt_lodiscage_sig_in_MNI,wmti_eas_de_perp_age_inter_hidiscage_gt_lodiscage_sig_in_MNI}.nii.gz \
/path/to/age_only/{dti_md_ageonly_inter_hidiscage_gt_lodiscage_sig_in_MNI,dti_rd_ageonly_inter_hidiscage_gt_lodiscage_sig_in_MNI,mtnoddi_mtcsf_ageonly_inter_hidiscage_gt_lodiscage_sig_in_MNI,mtnoddi_mtodi_ageonly_inter_lodiscage_gt_hidiscage_sig_in_MNI}.nii.gz

# hippocampal
# sagittal
parallel --bar -j1 --plus '/Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL -s '\''
import gl^
import itertools^
gl.resetdefaults()^
gl.colorbarposition(0)^
gl.fullscreen(1)^
gl.scriptformvisible(0)^
gl.toolformvisible(0)^
gl.bmpzoom(2)^
gl.backcolor(0, 0, 0)^
gl.loadimage("mni152")^
gl.overlayload("{}")^
gl.minmax(1, 0, 1)^
gl.opacity(1, 70)^
gl.linecolor(0, 255, 0)^
gl.mosaic("S L+ V 0 H 0 " + ";".join(map(lambda g: " ".join(map(str, g)), itertools.zip_longest(*[iter(range(-36, 38, 2))]*5, fillvalue=""))) + " A X R 0")^
gl.savebmp("/Users/adluru/Documents/midus/dwi_discrimination/hippo_figures/{/..}.png")^
gl.quit()^'\''
' ::: /path/to/wmti_eas_de_perp_age_inter_hidiscage_gt_lodiscage_sig_in_MNI.nii.gz /path/to/wmti_eas_de_perp_ageonly_inter_hidiscage_gt_lodiscage_sig_in_MNI.nii.gz /path/to/mtnoddi_mtodi_none_main_hidisc_gt_lodisc_sig_in_MNI.nii.gz