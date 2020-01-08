function read_F_results(results_savename)
% Reads in results from file containing SSIPM results
%**************************************************************************
load(results_savename,'plotData'); % load in data needed for the plot

% Read in results, convert to array with results by species & site
if ~exist(plotData.results_filename,'file') % if the file doesn't exist
    Dir = 'data/';
    File = 'SSIPM_Results_noHeaders.csv'; % results w/ no headers
    % make sure all cells are filled!
    
    fid = fopen(strcat([Dir,File]));
    R = textscan(fid, strcat(['%s %s %s ',... % Classcode, Island, Site
        '%s %f %f %f %f ',...          % Order, Fmode, Fmean, Fmedian, Fstd
        '%f %f']),...              % Rfact, Reserve?
        'Delimiter',',','MultipleDelimsAsOne',true,'HeaderLines',0);
    fclose(fid);
    
    % Column names
    colNames = {'classcode','island','site', 'order',...
        'Fmode','Fmean','Fmedian','Fstd','Rfact','reserve?'};
    save(plotData.results_filename,'R','colNames')
else
    load(plotData.results_filename,'R','colNames')
end

speciesName = plotData.species;
islandNames = plotData.islandNames;

islands = plotData.islands;
siteNames = unique(R{strcmp(colNames,'site')});

classCol = R{strcmp(colNames,'classcode')};
islandCol = R{strcmp(colNames,'island')};
siteCol = R{strcmp(colNames,'site')};
orderCol = R{4};
FmodeCol = R{5};
FmeanCol = R{6};
FmedianCol = R{7};
FstdCol = R{8};
reserveCol = R{strcmp(colNames,'reserve?')};

xValues = 0; % initialize variable for # of values to plot
OKsp = strcmp(classCol,speciesName); % rows with this species

% finds number of x-values for preallocation
for y = 1:length(islandNames)
    OKislands = strcmp(islandCol,islands{y}); % rows with islands
    xValues = xValues + sum(and(OKislands, OKsp));
end

%--------------------------------------------------------------------------
% Preallocate all arrays in the plotData structs
%--------------------------------------------------------------------------
% plot-format-specific struct
P_str.island = cell(1,xValues);
P_str.site = cell(1,xValues);
P_str.order = cell(1,xValues);
P_str.reserve = ones(1,xValues)*0;

% result-specific struct
R_str.Fmode = ones(1,xValues)*0;
R_str.Fmean = ones(1,xValues)*0;
R_str.Fmedian = ones(1,xValues)*0;
R_str.Fstd = ones(1,xValues)*0;

%--------------------------------------------------------------------------
% Fill in the structs
%--------------------------------------------------------------------------
index = 1;
for g = 1:length(siteNames)
    for y = 1:length(islandNames)
        % this site & island was sampled
        OKgy = strcmp(siteCol,siteNames{g}) & strcmp(islandCol,islands{y});
        OKgysp = OKgy & OKsp; % with this species
        
        if (sum(OKgysp) == 1)
            % values for plot
            P_str.island(1,index) = cellstr(islands{y});
            P_str.site(1,index) = cellstr(siteNames{g});
            P_str.order(1,index) = orderCol(OKgysp);
            P_str.reserve(1,index) = reserveCol(OKgysp);
            
            R_str.Fmode(1,index) = FmodeCol(OKgysp);
            R_str.Fmean(1,index) = FmeanCol(OKgysp);
            R_str.Fmedian(1,index) = FmedianCol(OKgysp);
            R_str.Fstd(1,index) = FstdCol(OKgysp);

            index = index + 1;
        end

    end % end loop over sites
end % end loop over islands

% finds which islands were actually analyzed
plotData.islands = unique(P_str.island(:));
plotData.islandNames = cell(length(plotData.islands),1);

% how you want each island name displayed on the plot
for i = 1:length(plotData.islands)
    if strcmp(plotData.islands{i,1},'SMI')
        plotData.islandNames{i,1} = 'San Miguel Island';
    end
    if strcmp(plotData.islands{i,1},'SRI')
        plotData.islandNames{i,1} = 'Santa Rosa Island';
    end
    if strcmp(plotData.islands{i,1},'SCI')
        plotData.islandNames{i,1} = 'Santa Cruz Island';
    end
    if strcmp(plotData.islands{i,1},'ANA')
        plotData.islandNames{i,1} = 'Anacapa Island';
    end
end

save(plotData.results_savename,'R_str','P_str','plotData')