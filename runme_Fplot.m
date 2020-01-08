function runme_Fplot(Species,Type)
% Master file for plotting harvest rate results from running the IPM
% developed by White et al. (2016) (in a .csv file) to a .eps file
%
% Below are the species and sites used by this implementation of Fplot
%
% Species:
% SMYS (Sebastes mystinus, blue rockfish)
% SATR (Sebastes atrovirens, kelp rockfish)
% PCLA (Paralabrax clathratus, kelp bass)
% SPUL (Semicossyphus pulcher, California sheephead)
%
% Type:
% SMI (San Miguel Island)
% SRI (Santa Rosa Island)
% SCI (Santa Cruz Island)
% ANA (Anacapa Island)
% Full (results from all islands)
%
% NOTE: User will have to add a column with the order of each site from 1 -
% N, where N is the easternmost site for that species.
%**************************************************************************

% Set formatting specifications for the plots and create savenames
plotData = FplotData(Species,Type); % saves plot format info in a struct

% Read in results for the specified species and site(s), and create structs
% for results and plot-specific data
read_F_results(plotData.savename)

% Plot results and save to .eps files with savenames from FplotData
plot_F_results(plotData.savename)