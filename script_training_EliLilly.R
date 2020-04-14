# Vincent van Hees 2020
#
# GGIR workshop demo of g.shell.GGIR
#
# This script assumes:
# - that the root of repository ggir_workshop is your working directory.
# - that you have GGIR and it's dependencies installed.

library(GGIR)

# Unzip and move the demofile (35 MB unzipped / 11 MB zipped).
file_folder_name = "mydemostudy"
if (dir.exists(file_folder_name) == FALSE) {
  dir.create(file_folder_name)
  unzip("demofile_leftwrist.zip", exdir = ".")
  file.move("demofile_leftwrist.cwa",file_folder_name)
}
g.shell.GGIR(#=======================================
             # INPUT NEEDED:
             #-------------------------------
             # General parameters
             #-------------------------------
             mode=c(1:5), #What part of the analysis needs to be done (options: 1,2,3,4 and 5)
             datadir=file_folder_name,
             outputdir=".",
             overwrite = TRUE, #overwrite previous milestone data?
             do.report=c(2,4,5), #for what parts does and report need to be generated? (option: 2, 4 and 5)
             do.imp=TRUE, # Do imputation? (recommended)
             idloc=2, #id location (1 = file header, 2 = filename)
             print.filename=TRUE,
             storefolderstructure = TRUE,
             do.parallel = F,
             desiredtz = "Europe/Amsterdam",
             #-------------------------------
             # Part 1 parameters:
             #-------------------------------
             # Key functions: reading file, auto-calibration, and extracting features
             windowsizes = c(5,900,3600), #Epoch length, non-wear detection resolution, non-wear detection evaluation window
             printsummary=TRUE,
             #-------------------------------
             # Part 2 parameters:
             #-------------------------------
             # Key functions: Non-wear detection, imputation, and basic descriptives
             strategy = 1, #Strategy (see tutorial for explanation)
             ndayswindow=7, #only relevant when strategy = 3
             hrs.del.start = 0, # Only relevant when strategy = 2. How many HOURS need to be ignored at the START of the measurement?
             hrs.del.end = 0, # Only relevant when strategy = 2. How many HOURS need to be ignored at the END of the measurement?
             maxdur = 6, # How many DAYS of measurement do you maximumally expect?
             includedaycrit = 16, # number of minimum valid hours in a day to attempt physical activity analysis
             M5L5res = 10, #resolution in minutes of M5 and L5 calculation
             winhr = c(5,10), # size of M5 and L5 (5 hours by default)
             qlevels = c(c(1380/1440),c(1410/1440)), #quantiles to calculate, set value at c() if you do not want quantiles
             qwindow=c(0,12,24), #window over which to calculate quantiles
             ilevels = c(seq(0,400,by=50),8000), #acceleration values (metric ENMO) from which a frequency distribution needs to be derived, set value at c() if you do not want quantiles
             mvpathreshold =c(100), #MVPA (moderate and vigorous physical activity threshold
             bout.metric = 4,
             closedbout=FALSE,
             #-------------------------------
             # Part 3 parameters:
             #-------------------------------
             # Key functions: Sleep detection
             timethreshold= 5, #10
             anglethreshold=5,
             ignorenonwear = TRUE, # if TRUE non-wear is not detected as sleep (if FALSE then it will work with imputed data)
             do.part3.pdf = TRUE,
             #-------------------------------
             # Part 4 parameters:
             #-------------------------------
             # Key functions: Integrating sleep log (if available) with sleep detection, storing day and person specific summaries of sleep
             excludefirstlast = FALSE, # Exclude first and last night for sleep analysis?
             includenightcrit = 16, # number of minimum valid hours in a day to attempt sleep analysis
             def.noc.sleep = 1,
             outliers.only = FALSE,
             do.visual = TRUE,
             # If sleep log is available:
             # loglocation = c(), # full directory and name of the log (if available, otherwise leave value as c() )
             # criterror = 4,
             # relyonsleeplog = FALSE,
             # sleeplogidnum = TRUE, # Is the participant in the sleep log stored as a number (TRUE) or as a character (FALSE)
             # colid=1, #colomn in which the participant id or filename is stored
             # coln1=2, #column number for first day
             # nnights = 9, #number of nights in the sleep log
             # -------------------------------
             # Part 5 parameters:
             # -------------------------------
             # Key functions: Merging physical activity with sleep analyses
             excludefirstlast.part5=FALSE,
             threshold.lig = c(40), #threshold(s) for inactivity (can be more than one number)
             threshold.mod = c(100), #threshold(s) for moderate activity (can be more than one number)
             threshold.vig = c(400), #threshold(s) for vigorous activity (can be more than one number)
             boutcriter = 0.8,
             boutcriter.in = 0.8, #fraction of an inactivity bout that needs to be below the threshold (needs to be 1 number)
             boutcriter.lig = 0.8, #fraction of an light activity bout that needs to be between the thresholds (needs to be 1 number)
             boutcriter.mvpa = 0.8, #fraction of an light activity bout that needs to be above the threshold (needs to be 1 number)
             boutdur.in = c(5,10,30), # duration of bouts to be calculated
             boutdur.lig = c(5,10), # duration of bouts to be calculated
             boutdur.mvpa = c(5,10), # duration of bouts to be calculated
             timewindow = c("WW","MM"), #,
             #-----------------------------------
             # Report generation
             #-------------------------------
             # Key functions: Generating reports based on meta-data
             visualreport=TRUE,
             dofirstpage = TRUE, #first page of pdf-report with simple summary histograms
             viewingwindow=1) #viewingwindow of visual report: 1 centres at day and 2 centers at night
