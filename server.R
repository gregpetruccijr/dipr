## DIPr Server
library(googlesheets)
library(dplyr)
library(stringr)
library(plotly)
library(ggplot2)

my_sheets <- gs_ls()

dipr_url = gs_url('https://docs.google.com/spreadsheets/d/14MIOBjTs-p8CS4ySFcyCCtu7b_dCaY7g5YKOe87tolE/edit?usp=sharing')

dipr_table = gs_read(dipr_url)

ag_sample_url = gs_url('https://docs.google.com/spreadsheets/d/1h9UEM6UYiSFgXFs8-oXmRDJiDXLFMaOWflOmubj-HYE/edit?usp=sharing')
ag_sample_complete = gs_read(ag_sample_url)

ag_sample_complete$intensity = factor(ag_sample_complete$intensity,levels = c('Sedentary','Light','Moderate','Vigorous'))

ag_sample_complete$filter = factor(ag_sample_complete$filter,levels = c('Norm','LFE'))

shinyServer(function(input,output) {
  
  observeEvent(input$epoch_select,{
    
    ag_sample_play = filter(ag_sample_complete, samp_freq == input$samp_freq_select, epoch == input$epoch_select, filter == input$filter_select)

    output$ag_sample_plot = renderPlot(ggplot(ag_sample_play, aes(x = intensity, y = minutes)) + 
                                         geom_col(fill = 'springgreen3') + geom_text(aes(label = minutes), size = 6) + theme_bw() + ylim(c(0,550)))
    })
  
  observeEvent(input$samp_freq_select,{
    ag_sample_play = filter(ag_sample_complete, samp_freq == input$samp_freq_select, epoch == input$epoch_select, filter == input$filter_select)
    
    output$ag_sample_plot = renderPlot(ggplot(ag_sample_play, aes(x = intensity, y = minutes)) + 
                                         geom_col(fill = 'springgreen3') + geom_text(aes(label = minutes), size = 6) + theme_bw() + ylim(c(0,550)))
  })
      
  observeEvent(input$filter_select,{
    ag_sample_play = filter(ag_sample_complete, samp_freq == input$samp_freq_select, epoch == input$epoch_select, filter == input$filter_select)
    
    output$ag_sample_plot = renderPlot(ggplot(ag_sample_play, aes(x = intensity, y = minutes)) + 
                                         geom_col(fill = 'springgreen3') + geom_text(aes(label = minutes), size = 6) + theme_bw() + ylim(c(0,550)))
  })
  
    observeEvent(input$runDIPR,{
      
    population = input$pop_select
    device = input$device_select
    wear = input$wear_select
    
    if(wear == 'hip'){
      new_dipr = dipr_table %>% filter(Population == population, Device == device, Wear_Location != 'wrist', Wear_Location != 'ankle') %>% select(-sed.crit,-light.crit,-mod.crit,-vig.crit)
      
      new_dipr = new_dipr %>% select(-Dom_NonDom)
      
      
    } else {
    
    new_dipr = dipr_table %>% filter(Population == population, Device == device, Wear_Location == wear) %>% select(-sed.crit,-light.crit,-mod.crit,-vig.crit)
    }
    
    
    output$dipr_display = renderTable({
      new_dipr
    })
    
  })  
  
})
