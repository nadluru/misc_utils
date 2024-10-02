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
gl.savebmp("/path/to/hippo_figures/{/..}.png")^
gl.quit()^'\''
' ::: /path/to/wmti_eas_de_perp_age_inter_hidiscage_gt_lodiscage_sig_in_MNI.nii.gz /path/to/wmti_eas_de_perp_ageonly_inter_hidiscage_gt_lodiscage_sig_in_MNI.nii.gz /path/to/mtnoddi_mtodi_none_main_hidisc_gt_lodisc_sig_in_MNI.nii.gz

# 1-p files
# whole brain
# axial
parallel --bar -j1 --plus '/Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL -s '\''import gl^
import itertools^
gl.resetdefaults()^
gl.fullscreen(1)^
gl.scriptformvisible(0)^
gl.toolformvisible(0)^
gl.bmpzoom(2)^
gl.backcolor(0, 0, 0)^
gl.loadimage("mni152")^
gl.overlayload("{}")^
gl.minmax(1, 0.95, 1)^
gl.opacity(1, 70)^
gl.colorname(1, "1red")^
gl.linecolor(0, 255, 0)^
gl.mosaic("A L+ V 0 H 0 " + ";".join(map(lambda g: " ".join(map(str, g)), itertools.zip_longest(*[iter(range(-35, 76, 6))]*5, fillvalue=""))) + " S X R 0")^
gl.savebmp("{..}.png")^
gl.quit()^'\''
' ::: ~/path/to/1-p_files/*.nii.gz

# whole brain axial (thr 1-p linear interp)
parallel --bar -j1 --plus '/Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL -s '\''import gl^
import itertools^
gl.resetdefaults()^
#gl.colorbarposition(0)^
gl.fullscreen(1)^
gl.scriptformvisible(0)^
gl.toolformvisible(0)^
gl.bmpzoom(2)^
gl.backcolor(0, 0, 0)^
gl.loadimage("mni152")^
gl.overlayload("{}")^
gl.minmax(1, 0.9, 1)^
gl.opacity(1, 70)^
gl.colorname(1, "1red")^
gl.linecolor(0, 255, 0)^
gl.mosaic("A L+ V 0 H 0 " + ";".join(map(lambda g: " ".join(map(str, g)), itertools.zip_longest(*[iter(range(-35, 76, 2))]*7, fillvalue=""))) + " S X R 0")^
gl.savebmp("{..}.png")^
gl.quit()^'\''
' ::: dwi_discrimination/mni_clusters_1_p_linear/whole_brain/*.nii.gz

# hippo sagittal (thr 1-p linear interp)
parallel --bar -j1 --plus '/Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL -s '\''import gl^
import itertools^
gl.resetdefaults()^
gl.fullscreen(1)^
gl.scriptformvisible(0)^
gl.toolformvisible(0)^
gl.bmpzoom(2)^
gl.backcolor(0, 0, 0)^
gl.loadimage("mni152")^
gl.overlayload("{}")^
gl.minmax(1, 0.9, 1)^
gl.opacity(1, 70)^
gl.colorname(1, "1red")^
gl.linecolor(0, 255, 0)^
gl.mosaic("S L+ V 0 H 0 " + ";".join(map(lambda g: " ".join(map(str, g)), itertools.zip_longest(*[iter(range(-56, 54, 2))]*7, fillvalue=""))) + " C X R 0")^
gl.savebmp("{..}.png")^
gl.quit()^'\''
' ::: dwi_discrimination/mni_clusters_1_p_linear/hippo/*.nii.gz

# combining with scatter plots
# fig 1a, 1b, 1c, 1d
# 2996x3510
identify dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_age_inter_dti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png

magick \( dwi_discrimination/mni_clusters_1_p_linear/manuscript/Fig1a-md-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(A)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_age_inter_dti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append \) \
\( dwi_discrimination/mni_clusters_1_p_linear/manuscript/Fig1c-rd-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(C)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(D)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_age_inter_dti_tfce_tstat_fwep_m3_c2_thr_in_MNI.png +append \) \
-append fig1.png

# fig 2a, 2b, 2c, 2d
magick \( dwi_discrimination/mni_clusters_1_p_linear/manuscript/Fig2a-csf-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(A)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_age_inter_mtnoddi_tfce_tstat_fwep_m3_c2_thr_in_MNI.png +append \) \
\( dwi_discrimination/mni_clusters_1_p_linear/manuscript/Fig2c-deperp-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(C)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(D)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_age_inter_wmti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append \) \
-append dwi_discrimination/mni_clusters_1_p_linear/fig2.png

# fig. 3
# 1536x982
identify dwi_discrimination/mni_clusters_1_p_linear/hippo/m3_lifebin_age_inter_wmti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png
magick dwi_discrimination/mni_clusters_1_p_linear/manuscript/Fig3a-deperp-hippo-life-1.jpeg -resize x982 +repage -gravity southwest -pointsize 80 -fill black -annotate +0+0 '(A)' -gravity southeast -pointsize 80 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/hippo/m3_lifebin_age_inter_wmti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append dwi_discrimination/mni_clusters_1_p_linear/fig3.png


# supplement fig 1a, 1b, 1c, 1d
magick \( dwi_discrimination/mni_clusters_1_p_linear/manuscript/SuppFig1a-md-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(A)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_ageonly_inter_dti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append \) \
\( dwi_discrimination/mni_clusters_1_p_linear/manuscript/SuppFig1c-rd-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(C)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(D)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_ageonly_inter_dti_tfce_tstat_fwep_m3_c2_thr_in_MNI.png +append \) \
-append dwi_discrimination/mni_clusters_1_p_linear/supp_fig1.png

# supplement fig 2a, 2b, 2c, 2d
magick \( dwi_discrimination/mni_clusters_1_p_linear/manuscript/SuppFig2a-csf-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(A)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_ageonly_inter_dti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append \) \
\( dwi_discrimination/mni_clusters_1_p_linear/manuscript/SuppFig2c-odi-wm-life-1.jpeg -resize x3510 +repage -gravity NorthWest -pointsize 200 -fill black -annotate +0+0 '(C)' -gravity NorthEast -pointsize 200 -fill black -annotate +0+0 '(D)' dwi_discrimination/mni_clusters_1_p_linear/whole_brain/m3_lifebin_ageonly_inter_dti_tfce_tstat_fwep_m3_c2_thr_in_MNI.png +append \) \
-append dwi_discrimination/mni_clusters_1_p_linear/supp_fig2.png

# supplement fig. 3a, 3b
magick dwi_discrimination/mni_clusters_1_p_linear/manuscript/SuppFig3a-deperp-hippo-life-1.jpeg -resize x982 +repage -gravity southwest -pointsize 80 -fill black -annotate +0+0 '(A)' -gravity southeast -pointsize 80 -fill black -annotate +0+0 '(B)' dwi_discrimination/mni_clusters_1_p_linear/hippo/m3_lifebin_ageonly_inter_wmti_tfce_tstat_fwep_m2_c2_thr_in_MNI.png +append supp_fig3_ab_only.png
