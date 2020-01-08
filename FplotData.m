function plotData = FplotData(Species,Type)
% Creates a struct to control plot formatting parameters
%**************************************************************************
plotData.species = Species;
plotData.type = Type;

% full species name (how you want each species name to be displayed)
switch Species
    case 'PCLA'
        plotData.speciesName = 'Kelp Bass';
    case 'SATR'
        plotData.speciesName = 'Kelp Rockfish';
    case 'SMYS'
        plotData.speciesName = 'Blue Rockfish';
    case 'SPUL'
        plotData.speciesName = 'California Sheephead';
end

% island names
if strcmp(Type,'Full')
    plotData.islands = {'SMI','SRI','SCI','ANA'};
    plotData.islandNames = {'San Miguel Island','Santa Rosa Island',...
        'Santa Cruz Island','Anacapa Island'};
else
    plotData.islands = {Type};
    plotData.islandNames = cell(1,1);
end

%--------------------------------------------------------------------------
% Colors for reference sites and marine reserves
%--------------------------------------------------------------------------
plotData.refColor = 'b'; % reference sites
plotData.resColor = 'r'; % reserve sites

%--------------------------------------------------------------------------
% Font sizes
%--------------------------------------------------------------------------
plotData.titleSize = 14;
plotData.xLabelSize = 12;
plotData.yLabelSize = 12;
plotData.siteLabelSize = 8;

%--------------------------------------------------------------------------
% Figure dimensions
%--------------------------------------------------------------------------
numIslands = length(plotData.islands);
height = 10*numIslands; % height determined by num of plots on the figure

% dimensions for plot: [ horizPos vertPos width height ] in cm
% Typically journals like figs that are 1 column wide (usually ~9 cm), or
% 1.5 cols wide (~12 cm), or 2 cols wide (~18 cm).
plotData.dimensions = [0 0 18 height];

%--------------------------------------------------------------------------
% Legend location
%--------------------------------------------------------------------------
plotData.legendLocation = 'northeast'; % given in ordinal direction

%--------------------------------------------------------------------------
% Savenames
%--------------------------------------------------------------------------
plotData.results_filename = strcat('data/',Species,'_',Type,...
    '_F_results_data.mat');
plotData.results_savename = strcat('data/',Species,'_',Type,...
    '_F_results_plotData.mat');
plotData.plot_savename = strcat('figures/',Species,'_',Type,...
    '_F_results_plot.mat');
plotData.savename = strcat('data/',Species,'_',Type,...
    '_August2019_plotData.mat');

save(plotData.savename,'plotData') % save the plot data
