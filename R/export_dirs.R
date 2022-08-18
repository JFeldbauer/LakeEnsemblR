#'Creates directories for each model
#'
#'Creates directories with file setups for each model, based on the master LakeEnsemblR config file
#'
#'@param config_file name of the master LakeEnsemblR config file
#'@param model vector; model to export configuration file.
#'  Options include c("GOTM", "GLM", "Simstrat", "FLake", "MyLake", "air2water")
#'@param folder folder
#'@keywords methods
#'@examples
#'
#'
#'@export

export_dirs <- function(config_file, model = c("GOTM", "GLM", "Simstrat", "FLake", "MyLake", "air2water"),
                          folder = "."){
  # Set working directory
  oldwd <- getwd()
  setwd(folder)
  
  # this way if the function exits for any reason, success or failure, these are reset:
  on.exit({
    setwd(oldwd)
  })
  
  # check model input
  model <- check_models(model)
  
##---------------FLake-------------
  if("FLake" %in% model){
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("FLake/output")){
      dir.create("FLake/output", recursive = TRUE)
    }
    
    # Read the FLake config file from config_file, and write it to the FLake directory
    temp_fil <- get_yaml_value(config_file, "config_files", "FLake")
    if(!file.exists(temp_fil)){
      get_template("FLake_config", folder = folder, filename = temp_fil)
    }
  }
  
##---------------GLM-------------
  if("GLM" %in% model){
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("GLM/output")){
      dir.create("GLM/output", recursive = TRUE)
    }
    
    # Read the GLM config file from config_file, and write it to the GLM directory
    temp_fil <- get_yaml_value(config_file, "config_files", "GLM")
    
    if(!file.exists(temp_fil)){
      get_template("GLM_config", folder = folder, filename = temp_fil)
    }
  }
  
##---------------GOTM-------------
  if("GOTM" %in% model){
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("GOTM/output")){
      dir.create("GOTM/output", recursive = TRUE)
    }
    
    # Read the GOTM config file from config_file, and write it to the GOTM directory
    temp_fil <- get_yaml_value(config_file, "config_files", "GOTM")
    if(!file.exists(temp_fil)){
      get_template("GOTM_config", folder = folder, filename = temp_fil)
    }
  }
  
##---------------Simstrat-------------
  if("Simstrat" %in% model){
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("Simstrat/output")){
      dir.create("Simstrat/output", recursive = TRUE)
    }
    
    # Read the Simstrat config file from config_file, and write it to the Simstrat directory
    temp_fil <- get_yaml_value(config_file, "config_files", "Simstrat")
    if(!file.exists(temp_fil)){
      get_template("Simstrat_config", folder = folder, filename = temp_fil)
    }
  }
  
##---------------MyLake-------------
  if("MyLake" %in% model){
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("MyLake")){
      dir.create("MyLake")
    }
    
    # Load config file MyLake
    temp_fil <- get_yaml_value(config_file, "config_files", "MyLake")
    if(!file.exists(temp_fil)){
      get_template("MyLake_config", folder = folder, filename = temp_fil)
      
      # Load template config file from extdata
      load(file.path(folder, temp_fil))
    }
  }
  
  ##---------------air2water-------------
  if("air2water" %in% model){
    lakename <- get_yaml_value(config_file, "location", "name")
    # Create directory and output directory, if they do not yet exist
    if(!dir.exists("air2water")){
      dir.create("air2water")
    }
    # create subfolder for forcings
    if(!dir.exists(file.path("air2water", lakename))){
      dir.create(file.path("air2water", lakename))
    }
    
    # Load config file
    temp_fil <- get_yaml_value(config_file, "config_files", "air2water")
    if(!file.exists(temp_fil)){
      get_template("air2water_config", folder = folder, filename = temp_fil)
    }
    file.copy(file.path(system.file("extdata", package = "air2wateR"), "PSO.txt"),
              file.path(folder, "air2water"), overwrite = FALSE)
    # change lake name in the input file
    a2w_config <- readLines(temp_fil)
    a2w_config[2] <- gsub("Superior", lakename, a2w_config[2])
    con <- file(temp_fil, encoding = "ASCII")
    writeLines(a2w_config, con)
    close(con)
  
    message("export_dirs complete!")
  }
}
