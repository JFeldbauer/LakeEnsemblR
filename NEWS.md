## version 1.2.0

### Changes

 - added new model air2water
 - to be used the model requires the R package air2wateR which can be installed from github.com/aemon-j/air2wateR
 - as air2water uses its own calibration method it is at the moment not included in the 'cali_ensemble()' function

## version 1.1.9

### Changes

- fixed a bug in the LHC calibration where if a model would crash on the first run the headding of the ouput file would be wrong
- Add the number of rows in the hypsograph file to the calculated `max_layers` parameter in GLM, to avoid failure of Lagrangian algorithm

## version 1.1.8

### Changes

- To convert temperature observations to long-format, the `dcast` function within `run_ensemble` and `cali_ensemble` now uses `mean(..., na.rm = TRUE)` as aggregation function. Previously, this could cause problems in case of non-unique observations (a warning is thrown if these exist).
- added a check if the mean depth is below 1.5 meters as this could cause the `export_init_cond` function to crash for FLake as `calc_hmix` has a default value of 1.5 m for a minimum depth

## version 1.1.7

### Changes

Bug fixes:
- Warning message shows up when pre-v1.1 `mass-balance` argument is used, pointing towards a solution when the `outflows` section is missing.

## version 1.1.6

### Changes

Bug fixes:
- Fixed error in `analyse_ncdf` when ice is not present in the ncdf file and if not enough observational data.

## version 1.1.5

### Changes

Bug fixes:
- Fixed error in `export_flow` when using a start or stop date that was not included in the inflow or outflow file
- Fixed bug in `get_output` which would show wrong NA values in Simstrat temperature output due to water level change when including depths in observation files that were not included in the Simstrat output. 

## version 1.1.4

### Changes

Bug fixes:
- Fixed error in `export_extinction` that caused GOTM to crash because of formating of the datetime column

## version 1.1.3

### Changes

Bug fixes:
- Calculation of degrees East longitude in output netcdf file was corrected, with values 180-360 for locations on the Western Hemisphere

## version 1.1.2

### Changes

- it is now possible to add sensible and latent heat fluxes to the output netcdf file by adding q_sens and/or q_lat to the list of wanted output variables in the yaml config file

## version 1.1.1

### Changes

Bug fixes:
- fixed error in formatting of Simstrat flow where a flow of 0 would lead to NA in the Simstrat inflow forcing files

## version 1.1.0

### Changes

- Inflows and outflows are now separate inputs and can be different from each other
- Multiple inflows and outflows can be simulated. 
- Outflows can exit the lake at specified depths, or at the surface. 
- Water level ("w_level") is now a potential output of LakeEnsemblR. 
- "max_members" can be specified, which sets the number of members that the output-netcdf can have
- LakeEnsemblR now works with the latest version of Simstrat (v3.0.1), which included changes in some parameter names
- Model-specific template config files are removed from the LakeEnsemblR package and are instead retrieved from the model-specific packages

Bug fixes:
- get_yaml_multiple and input_yaml_multiple; works now if the first key is the highest level in the yaml file
- cali_ensemble for FLake; depths are now sorted
- Initial conditions Simstrat; Simstrat now always starts at the specified initial water lvl
- plot_heatmap now works in lakes where the water level changes

The setup of the LakeEnsemblR configuration file changed. More information can be found on: https://github.com/aemon-j/LakeEnsemblR/wiki/From-v1.0-to-v1.1


## version 1.0.5

### Changes

- added NEWS.md file
- Changed default branch name to "main". If you contribute to LakeEnsemblR and have a local clone of the repository please update your local branch name using:
```
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```
