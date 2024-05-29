# (05/09;10;11;13;14/2024) dwi ~ loneliness =====================
# load the libraries
c('tidyverse', 'ggplot2', 'haven') |> 
  lapply(require, character.only = T)

# read the spss file
read_sav('Y:/midus3/processed_data/loneliness_DWI/data/M3_P5_Loneliness_processed_reduced_diffusion.sav') |> # View() # view the data at each step
  mutate(across(
    # remove the mean from the appropriate columns
    # here everything else except MIDUSID
    -c(MIDUSID),
    ~ . - mean(., na.rm = T))) |> # View()
  (\(.)
   {
     pmap(
       list(
         # specify the models
         list(
           # main effect models
           '~UCLA_Lonely', #1
           '~UCLA_Lonely + C5PAGE', #2
           '~UCLA_Lonely + C5PAGE', #2a
           '~UCLA_Lonely + C5PAGE + Sex + Race + Education', #3
           '~UCLA_Lonely + Social_Network_Index', #4
           '~UCLA_Lonely + C5PAGE + Sex + Race + Education + Social_Network_Index', #5
           
           # interaction models
           '~UCLA_Lonely * C5PAGE', #6
           '~UCLA_Lonely * C5PAGE + Sex + Race + Education', #7
           '~UCLA_Lonely * C5PAGE + Social_Network_Index', #8
           '~UCLA_Lonely * C5PAGE + Sex + Race + Education + Social_Network_Index' #9
         ),
         # specify the contrasts correspondingly
         list(
           # main effects
           # '~UCLA_Lonely'
           c(0, 1,
             0, -1), #1
           # '~UCLA_Lonely + C5PAGE'
           c(0, 1, 0,
             0, -1, 0), #2
           # '~UCLA_Lonely + C5PAGE'
           c(0, 0, 1,
             0, 0, -1), #2a
           # '~UCLA_Lonely + C5PAGE + Sex + Race + Education'
           c(0, 1, 0, 0, 0, 0,
             0, -1, 0, 0, 0, 0), #3
           # '~UCLA_Lonely + Social_Network_Index'
           c(0, 1, 0,
             0, -1, 0), #4
           # '~UCLA_Lonely + C5PAGE + Sex + Race + Education + Social_Network_Index'
           c(0, 1, 0, 0, 0, 0, 0,
             0, -1, 0, 0, 0, 0, 0), #5
           
           # interaction models
           # '~UCLA_Lonely * C5PAGE'
           c(0, 0, 0, 1,
             0, 0, 0, -1), #6
           # '~UCLA_Lonely * C5PAGE + Sex + Race + Education'
           c(0, 0, 0, 0, 0, 0, 1,
             0, 0, 0, 0, 0, 0, -1), #7
           # '~UCLA_Lonely * C5PAGE + Social_Network_Index'
           c(0, 0, 0, 0, 1,
             0, 0, 0, 0, -1), #8
           # '~UCLA_Lonely * C5PAGE + Sex + Race + Education + Social_Network_Index'
           c(0, 0, 0, 0, 0, 0, 0, 1,
             0, 0, 0, 0, 0, 0, 0, -1) #9
         ),
         seq(1, 10)
       ),
       function(m, c, i){
         pmap(
           list(
             # matrices
             list(
               model.matrix(as.formula(m), .),
               c |> matrix(nrow = 2,
                           byrow = T)
             ),
             # file names
             paste0('Y:/midus3/processed_data/loneliness_DWI/model_contrast_matrices/',
                    gsub('\\s*', '', substring(m, 2))) |>
               (\(.) gsub('\\*', 'X', .))() |> 
               (\(.)
                list(paste0(., '_i_', i, '_model.txt'),
                     paste0(., '_i_', i, '_contrast.txt'))
                # c |> str_c(collapse = '-'),
                # '.txt'))
               )()
           ),
           ~..1 |> 
             write.table(..2,
                         row.names = F,
                         col.names = F,
                         sep = '\t',
                         quote = F)
         )
       }
     ) # ; not necessary
     # writing the 4d files
     # dwi csv
     read.csv('Y:/midus3/processed_data/dmri_transformations/dki_tspoon.csv') |> 
       (\(.)
        list(.,
             read.csv('Y:/midus3/processed_data/dmri_transformations/dmri_updated.csv') |>
               filter(model != 'cdti',
                      !(measure %in% c('ad', 'ak', 'fe',
                                       'mtvfextra',
                                       'ias_da_perp',
                                       . |> pull(measure) |> 
                                         unique()
                      ))))
       )() |> bind_rows() |>
       # joining with the loneliness csv
       inner_join(., by = c('id' = 'MIDUSID')) |>
       group_by(model, measure) |>
       group_map(~paste0('/study/midus3/processed_data/loneliness_DWI/4dfiles/',
                         gsub(' ', '_', .y |> reduce(paste)), '_loneliness') |>
                   (\(.) paste('fslmerge -t', .))() |>
                   paste(.x |> pull(fn) |> reduce(paste))) |>
       # we can use this block when running from a place where fslmerge is available
       # walk(~system(.))
       walk(~write(.,
                   'Y:/midus3/processed_data/loneliness_DWI/4dfiles/run_me.sh',
                   append = T,
                   sep = '\n'))
  }
  )()
#  parallel --bar Text2Vest {} {.}.fslready ::: /study/midus3/processed_data/loneliness_DWI/model_contrast_matrices/*.txt
read.csv('Y:/midus3/processed_data/loneliness_DWI/palm/cluster_dwi_comprehensive.csv', na.strings = c('')) |> 
  left_join(
    read.csv('Y:/midus3/processed_data/loneliness_DWI/palm/clustersize_comprehensive.csv', na.strings = c(''))
  ) |> 
  left_join(
    read.csv('Y:/midus3/processed_data/loneliness_DWI/palm/cluster_fslatlases_comprehensive.csv')
  ) |> 
  left_join(
    read_sav('Y:/midus3/processed_data/loneliness_DWI/data/M3_P5_Loneliness_processed_reduced_diffusion.sav') |> # View() # view the data at each step
      mutate(across(
        # remove the mean from the appropriate columns
        # here everything else except MIDUSID
        -c(MIDUSID),
        ~ . - mean(., na.rm = T))) |> mutate(id = paste0('S', 1:n()))
  ) |> 
  write.csv(paste0('Y:/midus3/processed_data/loneliness_DWI/palm/palm_results_comprehensive.csv'), 
            row.names = F, quote = F)