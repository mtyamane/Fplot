function plot_F_results(plotData_savename)
% Plots the results from file containing SSIPM results
%**************************************************************************
load(plotData_savename,'plotData');
load(plotData.results_savename,'P_str','R_str','plotData');

figure(1) % open figure 1 window
clf % clear figure of existing contents

plotTitle = true; % to false if you don't want species name at top
plotLegend = true; % to false if you don't want a legend on the plots
saveplots = true; % to false if you don't want to save the plots

plot_savename = plotData.plot_savename(1:end-4); % trim '.mat'
F_results_plotname = strcat(plot_savename,'.eps');  % for eps
% F_results_plotname = strcat(plot_savename,'.png');  % for png

%--------------------------------------------------------------------------
% Sets dimensions of the figure, according to dimensions from plotData
%--------------------------------------------------------------------------
set(gcf,'units','cent','position',plotData.dimensions) 

%--------------------------------------------------------------------------
% Plots the data by island
%--------------------------------------------------------------------------
numIslands = length(plotData.islands);
for i = 1:numIslands
    subplot(numIslands,1,i)
    hold on
    if i == 1 % to make the title above the top plot
        if plotTitle
            title(strcat('\fontsize{',num2str(plotData.titleSize),'}',...
                plotData.speciesName));
        end
    end
    
    %----------------------------------------------------------------------
    % Replaces '0' with reference color and '1' with reserve color
    %----------------------------------------------------------------------
    boolReserve = ismember(P_str.reserve(:),1);
    boolReference = ismember(P_str.reserve(:),0);
    
    siteColor = blanks(length(P_str.reserve));
    siteColor(boolReserve) = plotData.resColor;
    siteColor(boolReference) = plotData.refColor;
    
    %----------------------------------------------------------------------
    % Prepares variables for plotting
    %----------------------------------------------------------------------
    % convert to be accessible for plot
    order = str2double(P_str.order);
    Fmean = [R_str.Fmean];
    % Fmode = [R_str.Fmode];
    % Fmedian = [R_str.Fmedian];
    Fstd = [R_str.Fstd];

    % find number of relevant sites for this island
    numSites = nnz(strcmp(P_str.island,plotData.islands{i}));
    
    ylimNum = 0.81;          % y-axis limit
    %----------------------------------------------------------------------
    % Plots each point with errorbars
    %----------------------------------------------------------------------
    for j = 1:length(R_str.Fmode)
        if strcmp(P_str.island(1,j),plotData.islands(i))
            % plots mean
            scatter(order(j), Fmean(j),40,'o','MarkerFaceColor',...
                siteColor(j),'MarkerEdgeColor',siteColor(j));
            hold on
            
            % errorbar of std dev
            errorbar(order(j), Fmean(j),Fstd(j),siteColor(j),'CapSize',10);
            hold on
            
            % Set y-axis accounting for error bar length
            if Fmean(j)+Fstd(j) > ylimNum
                ylimNum = Fmean(j) + Fstd(j) + 0.05;
                if ylimNum > 1
                    ylimNum = ylimNum - 0.05 + .2;
                end
                if ylimNum > 5
                    ylimNum = ylimNum - 0.05 + 1;
                end
                if ylimNum > 20
                    ylimNum = ylimNum - 0.05 + 5;
                end
            end
        end
    end
    
    %----------------------------------------------------------------------
    % Axis dimensions
    %----------------------------------------------------------------------
    xlimNum = numSites + 1; % x-axis limit
    xlim([0 xlimNum]);      % range of x
    ylim([0 ylimNum]);      % range of y
    
    %----------------------------------------------------------------------
    % Axis labels
    %----------------------------------------------------------------------
    xtickNum = 0:xlimNum;
    xtickNam = cell([1, length(xtickNum)]); % preallocates array
    xtickNam{1,1} = 'W';
    
    for j = 1:length(P_str.site)
        if strcmp(P_str.island(1,j),plotData.islands(i))
            xtickNam{1,order(j)+1} = P_str.site{1,j};
        end
    end
    
    xtickNam{1,xlimNum+1} = 'E';
    xtickNam = cellfun(@(x) strrep(x,'_',' '),xtickNam,...
        'UniformOutput',false);
    
    % Capitalize the first letter of each word
    xtickNam = cellfun(@(x) lower(x),xtickNam,'UniformOutput',false);
    idx = cellfun(@(x) regexp([' ' x],'(?<=\s+)\S','start')-1,...
        xtickNam,'UniformOutput',false);
    for j = 1:length(xtickNam)
        temp = xtickNam{1,j};
        tempIdx = cell2mat(idx(1,j));
        temp(tempIdx) = upper(temp(tempIdx));
        xtickNam{1,j} = temp;
    end
    
    %----------------------------------------------------------------------
    % Creates legend
    %----------------------------------------------------------------------
    if plotLegend
        h = zeros(2, 1); % preallocate legend vector
        h(1) = plot(NaN,NaN,'-or','markerfacecolor',plotData.resColor);
        h(2) = plot(NaN,NaN,'-ob','markerfacecolor',plotData.refColor);
        
        % create legend
        legend(h, 'Marine Reserve','Reference Site',...
            'Location',plotData.legendLocation)
        legend boxoff
    end
    
    %----------------------------------------------------------------------
    % Final labels and formatting
    %----------------------------------------------------------------------
    set(gca,'xtick', xtickNum,'xticklabel',xtickNam,...
        'TickLabelInterpreter','none','fontsize', plotData.siteLabelSize);
    ytickformat('%.1f');
    xlabel(gca, plotData.islandNames{i},'fontsize',plotData.xLabelSize);
    ylabel(gca,'F','fontsize',plotData.yLabelSize);
    
    set(gca,'box','on')
    
end % end loop over numIslands

if saveplots
    print(F_results_plotname,'-depsc2','-tiff')  % for eps
    % saveas(gcf, F_results_plotname)  % for png
end
