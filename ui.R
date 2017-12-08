## DIPr UI

library(shiny)
library(ggplot2)
library(shinythemes)
# Insert Master dataset here
# data = read.csv('XXXX')

shinyUI(fluidPage(theme = shinytheme('flatly'),
  titlePanel('DIPr'),
    navlistPanel(widths = c(2,10),tabPanel('Home',mainPanel(h3('Device Initialization and Processing Recommender (DIPr)'),
h4('About DIPr'),
p('Methodological inconsistencies across studies for processing accelerometer data can result in different estimates of physical activity (cite or figure of different processing methods and different outcomes).
                For best practices in physical activity research, researchers should utilize methodologies that are similar to the primary study from which cutpoints or regressions were developed (cite sample freq Jairo).'),
                                           img(src = 'actigraphgt3x.jpg'),
                                           img(src = 'axivityax3.jpg'),
                                           img(src = 'GENEActiv.jpg'),
                                           br(),
                                           h4('Purpose'),
                                           p('The purpose of the Device Initialization and Processing recommender (DIPr) app is to serve as an informative resource for those unsure of what methods are available for processing their data and a soft guideline for processing physical activity data in accordance with original methods studies.'),
                                           h4('Disclaimers'),
                                           p('1) This app is meant to serve as a quick reference for researchers, however it is highly advised for individuals to refer back to the original paper. To facilitate ease of access, we have included the PubMed ID associated with each study for each result.'),
                                           p('2) A database literature search was conducted on November 4th, 2017. Any papers published after this date may not currently be included in the results. If you believe there are missing sources that should be included, feel free to let us know!'),
                                           p('3) Currently, the only devices included in this application are ActiGraph, Axivity, and GENEActiv. We hope to update our data respository with other devices in the future.')
                                           #p('4) Regardless of the device, raw acceleration cutpoints are also presented in all results due to comparability across devices using raw acceleration signals (cite hildebrand).')
                                           )),
                 tabPanel('Why Processing Matters',mainPanel(h3('The Effects of Various Processing Parameters'),
                                                             p('The figure belows displays estimates of time spent in sedentary behavior and light, moderate, and vigorous intensity PA from one participant. Use the select options below to observe how changes in sampling frequency, filter, or epoch can influence the results.'),
                                                             p('Note: Sample data used below was collected over a 10-hour period from one participant who wore two ActiGraph (AG) GT3X+ devices initialized at 30 Hz and 90 Hz. Both devices were secured to the same elastic belt, and placed over the right hip with the 30 Hz AG lateral to the 90 Hz AG. Devices were downloaded and processed in ActiLife (v6.13.3) using the Freedson et al. 1998 adult cut-points.'),
                                                             div(style="display: inline-block;vertical-align:top; width: 150px;",
                                                                 radioButtons(inputId = 'samp_freq_select', label = 'Sampling Frequency',
                                                                             choices = c('30 Hz' = 30,
                                                                                         '90 Hz' = 90))),
                                                             div(style="display: inline-block;vertical-align:top; width: 150px;",
                                                                 radioButtons(inputId = 'filter_select', label = 'Filter',
                                                                             choices = c('Normal' = 'Norm',
                                                                                         'Low-Frequency Extension' = 'LFE'))),
                                                             div(style="display: inline-block;vertical-align:top; width: 150px;",
                                                                 radioButtons(inputId = 'epoch_select', label = 'Epoch',
                                                                             choices = c('1 second' = 1,
                                                                                         '5 seconds' = 5,
                                                                                         '10 seconds' = 10,
                                                                                         '15 seconds' = 15,
                                                                                         '30 seconds' = 30,
                                                                                         '60 seconds' = 60))),
                                                             plotOutput('ag_sample_plot')
                                                             )),
                 tabPanel('DIPr',mainPanel(h1('DIPr Interface'),
                                            div(style="display: inline-block;vertical-align:top; width: 250px;",
                                                selectInput(inputId = 'pop_select', label = 'Age Group of Sample',
                                                       choices = c('Older adults' = 'older adult',
                                                                   'Adult' = 'adult',
                                                                   'Children (5-18 years)' = 'children',
                                                                   'Preschool (<5 years)' = 'preschool'))),
                                            div(style="display: inline-block;vertical-align:top; width: 150px;",
                                                selectInput(inputId = 'device_select', label = 'Device',
                                                       choices = c('ActiGraph' = 'ActiGraph',
                                                                   'GENEActiv' = 'GENEA',
                                                                   'Axivity' = 'Axivity'))),
                                           div(style="display: inline-block;vertical-align:top; width: 150px;",
                                               selectInput(inputId = 'wear_select', label = 'Wear Location',
                                                           choices = c('Waist/Hip' = 'hip',
                                                                       'Wrist' = 'wrist',
                                                                       'Ankle' = 'ankle'))),
                                           div(style = "display: inline-block;vertical_align:top; width: 150px;",
                                               actionButton('runDIPR',"Display Studies")),
                                           tableOutput("dipr_display")
                                           )),
                 #tabPanel('Methods/Sources'),
                 tabPanel('About Developers',mainPanel(img(src = 'Rob Headshot.jpg'),h2('Robert Marcotte, M.S.'),
                                                       p('Robert Marcotte is currently a doctoral candidate under Dr. John Sirard in the Kinesiology department at the University of Massachusetts Amherst. 
                                                         He obtained his MS in Exercise Physiology from the University of Tennessee Knoxville (advised by Dr. Scott Crouter) and his BS in Human Nutrition, Foods, and Exercise from Virginia Tech. 
                                                         His masters thesis project involved exploring the application of the ActiGraph GT9X gyroscope and magnetometer for the detection of turning events during walking and running.
                                                         '),
                                                       br(),
                                                       img(src = 'Jairo Headshot.jpg'), h2('Jairo Migueles, M.S.'),
                                                       p('Jairo Migueles is currently a Doctoral candidate in the Department of Physical Education and Sports at the University of Granada.'),
                                                       br(),
                                                       img(src = 'Greg Headshot.jpg'), h2('Gregory Petrucci, B.S.'),
                                                       p('Greg Petrucci is currently a masters candidate under Dr. John Sirard in the Kinesiology department at the University of Massachusetts Amherst.
                                                         He obtained his BS in Kinesiology from the University of Massachusetts Amherst and has been involved in numerous research projects')
                                                       ))
                          )
                 # br(),
                 # h4('ActionButton'),
                 # actionButton(name = 'per',label = 'Perform'),
                 # br(),
                 # br(),
                 # h4('Submitbutton'),
                 # submitButton("Submit"),
    
))
