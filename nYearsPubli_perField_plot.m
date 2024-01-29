%% load and process data 

% Load the data from CSV file into a table
currentFile = dir(mfilename("fullpath"));
filename = [currentFile.folder, filesep, 'nYearsPubli_perField_summary.csv'];
dataTable = readtable(filename);

% Get time to publication per category (neuroscience using live animals or
% other) 



%% compute histograms and plot data 

figure();

% Data for publications in neuroscience using live animals during
% experiments
n_years_publi_neuro_live = dataTable.timeToFirstAuthorPub(dataTable.neuroField_liveAnimals & ~isnan(dataTable.timeToFirstAuthorPub));
% Calculate bin edges centered around each year
edges_neuro_live = (min(n_years_publi_neuro_live)):1:(max(n_years_publi_neuro_live));
% Compute histogram data
[neuro_live_counts, ~] = histcounts(n_years_publi_neuro_live, edges_neuro_live);
% Compute cumulative sum
neuro_live_cumulative = cumsum(neuro_live_counts);
% Normalize the cumulative sum
neuro_live_cumulative_normalized = neuro_live_cumulative / max(neuro_live_cumulative);
% Plot stairs
stairs(edges_neuro_live(1:end), [0, neuro_live_cumulative_normalized], 'Color', [0.8941, 0.1020, 0.1098]);
hold on;

% Data for publications in any other field
n_years_publi_other = dataTable.timeToFirstAuthorPub(dataTable.neuroField_liveAnimals == 0 & ~isnan(dataTable.timeToFirstAuthorPub));
% Calculate bin edges centered around each year
edges_no_live = (min(n_years_publi_other)):1:(max(n_years_publi_other));
% Compute histogram data
[no_live_counts, ~] = histcounts(n_years_publi_other, edges_no_live);
% Compute cumulative sum
no_live_cumulative = cumsum(no_live_counts);
% Normalize the cumulative sum
no_live_cumulative_normalized = no_live_cumulative / max(no_live_cumulative);
% Plot stairs
stairs(edges_no_live(1:end), [0, no_live_cumulative_normalized], 'Color', [0.2157, 0.4941, 0.7216]);

% add median line
line([0, nanmax(n_years_publi_neuro_live)], [0.5, 0.5], 'Color', [0, 0, 0])

% make plot prettier 
prettify_plot;
legend({['researchers in neuroscience' newline 'working with behaving animals'...
    newline 'n = ' num2str(numel(n_years_publi_neuro_live))],...
    ['other researchers' newline 'n = ' num2str(numel(n_years_publi_other))]})
xlabel(['number of years from start of PhD' newline 'to 1rst "first author" publication'])
ylabel('cumulative proportion')
%ylim([0, 0.55])

% save plot 
savefig(gcf, [currentFile.folder, filesep, 'nYearsPubli_perField_summary.csv'])

% average
nanmedian(n_years_publi_other)
nanmedian(n_years_publi_neuro_live)

%nanstd(n_years_publi_other)/sqrt(length(n_years_publi_other))
%nanstd(n_years_publi_neuro_live)/sqrt(length(n_years_publi_neuro_live))