# load the libraries ========
c('tidyverse', 'ggplot2', 'haven') |> 
  lapply(require, character.only = T)

# read the loneliness spss file ========
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
           '~UCLA_Lonely + C5PAGE', #3
           '~UCLA_Lonely + C5PAGE + Sex + Race + Education', #4
           '~UCLA_Lonely + Social_Network_Index', #5
           '~UCLA_Lonely + C5PAGE + Sex + Race + Education + Social_Network_Index', #6
           
           # interaction models
           '~UCLA_Lonely * C5PAGE', #7
           '~UCLA_Lonely * C5PAGE + Sex + Race + Education', #8
           '~UCLA_Lonely * C5PAGE + Social_Network_Index', #9
           '~UCLA_Lonely * C5PAGE + Sex + Race + Education + Social_Network_Index' #10
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
             0, 0, -1), #3
           # '~UCLA_Lonely + C5PAGE + Sex + Race + Education'
           c(0, 1, 0, 0, 0, 0,
             0, -1, 0, 0, 0, 0), #4
           # '~UCLA_Lonely + Social_Network_Index'
           c(0, 1, 0,
             0, -1, 0), #5
           # '~UCLA_Lonely + C5PAGE + Sex + Race + Education + Social_Network_Index'
           c(0, 1, 0, 0, 0, 0, 0,
             0, -1, 0, 0, 0, 0, 0), #6
           
           # interaction models
           # '~UCLA_Lonely * C5PAGE'
           c(0, 0, 0, 1,
             0, 0, 0, -1), #7
           # '~UCLA_Lonely * C5PAGE + Sex + Race + Education'
           c(0, 0, 0, 0, 0, 0, 1,
             0, 0, 0, 0, 0, 0, -1), #8
           # '~UCLA_Lonely * C5PAGE + Social_Network_Index'
           c(0, 0, 0, 0, 1,
             0, 0, 0, 0, -1), #9
           # '~UCLA_Lonely * C5PAGE + Sex + Race + Education + Social_Network_Index'
           c(0, 0, 0, 0, 0, 0, 0, 1,
             0, 0, 0, 0, 0, 0, 0, -1) #10
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
     )
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
       # creating the fslmerge -t .... command text
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

# data frame for cross-product with measures for npc_fisher based clusters =====
list(data.frame(dwi = c(rep('dti', 3), 
                        rep('dki', 2), 
                        rep('noddi', 3), 
                        rep('wmti', 4))) |> 
       group_by(dwi) |> 
       mutate(dwi_m = paste0('m', row_number()), 
              stat = 'npc_fisher')) |>
  map2('Y:/midus3/processed_data/loneliness_DWI/', ~ 
         ..2 |> # ..2 refers to the second argument passed to map2 which is the path above
         (\(.) # ..2 is from now on referred to using . for simplicity of presentation
                 # reading the dwi in clusters
                 read.csv(paste0(., 
                                 'cluster_dwi_comprehensive.csv'), 
                          na.strings = c('')) |> 
                   # inputting m1, m2, m3, m4 for npc_fisher rows
                   mutate(dwi_m = 
                            case_when(
                              str_detect(dwi_m_name, 'fa|csf|mk|awf') ~ 'm1',
                              str_detect(dwi_m_name, 'md|ndi|rk|eas_de_perp') ~ 'm2',
                              str_detect(dwi_m_name, 'rd|odi|eas_tort') ~ 'm3',
                              str_detect(dwi_m_name, 'ias_da') ~ 'm4')) |>
                   left_join(
                     # reading the cluster size info
                     read.csv(paste0(., 'clustersize_comprehensive.csv'), 
                              na.strings = c('')) |> 
                       (\(.)
                        ..1 |> # ..1 is the data frame created at the beginning the monad
                          right_join(
                            . |> 
                              filter(stat == 'npc_fisher') |> 
                              select(-dwi_m)) |>
                          bind_rows(. |> 
                                      filter(stat != 'npc_fisher'))
                        )()
                     ) |> 
                   left_join(
                     # reading the atlas query info
                     read.csv(paste0(., 'cluster_fslatlases_comprehensive.csv')) |> 
                       (\(.)
                        ..1 |> # ..1 is the data frame created at the beginning the monad
                          right_join(
                            . |> 
                              filter(stat == 'npc_fisher') |> 
                              select(-dwi_m)) |>
                          bind_rows(. |> filter(stat != 'npc_fisher'))
                        )() |> 
                       group_by(across(-c(regionname, probability))) |> 
                       arrange(probability |> desc()) |> 
                       filter(row_number() == 1)) |> 
                   # joining with the loneliness csv
                   left_join(
                     read_sav(paste0(., 
                                     'M3_P5_Loneliness_processed_reduced_diffusion.sav')) |> 
                       mutate(across(
                         # remove the mean from the appropriate columns
                         # here everything else except MIDUSID
                         -c(MIDUSID),
                         ~ . - mean(., na.rm = T))) |> 
                       mutate(id = paste0('S', 1:n()))
                     ) |> 
                   (\(.)
                    {
                      # writing the output without npc_fisher stats
                      . |> 
                        filter(stat != 'npc_fisher') |> 
                        write.csv(paste0(., 
                                         'palm_results_comprehensive_sans_npc_fisher.csv'), 
                                  row.names = F, 
                                  quote = F)
                      # writing the output with npc_fisher stats
                      . |> 
                        filter(stat == 'npc_fisher') |> 
                        write.csv(paste0(., 
                                         'palm_results_comprehensive_npc_fisher.csv'), 
                                  row.names = F, 
                                  quote = F)
                      }
                    )()
                 )()
  )