%% load and process data 

% Load the data from CSV file into a table
mfilename('fullpath')
filename = './Downloads/Systems Neuroscience PhD paper publication time survey (Responses).csv';
dataTable = readtable(filename);

% Get time to publication per category (neuroscience using live animals or
% other) 



%% compute histograms and plot data 

figure();

% Data for publications in neuroscience using live animals during
% experiments
n_years_publi_neuro_live = n_years_publi(n_years_publi(:,2)==1,1);
% Calculate bin edges centered around each year
edges_neuro_live = (min(n_years_publi_neuro_live)-0.5):1:(max(n_years_publi_neuro_live)+0.5);
% Compute histogram data
[neuro_live_counts, ~] = histcounts(n_years_publi_neuro_live, edges_neuro_live);
% Normalize the histogram
neuro_live_counts_normalized = neuro_live_counts / (sum(neuro_live_counts) * mode(diff(edges_neuro_live)));
% Adjust counts for plot
neuro_live_counts_plot = [0, neuro_live_counts_normalized, 0];
% Plot stairs
stairs([edges_neuro_live, edges_neuro_live(end) + 1], neuro_live_counts_plot,...
    'Color', [0.8941, 0.1020, 0.1098], 'LineWidth',3);
hold on;

% Data for publications in any other field
n_years_publi_no_live = n_years_publi(n_years_publi(:,2)==0,1);
% Calculate bin edges centered around each year
edges_no_live = (min(n_years_publi_no_live)-0.5):1:(max(n_years_publi_no_live)+0.5);
% Compute histogram data
[no_live_counts, ~] = histcounts(n_years_publi_no_live, edges_no_live);
% Normalize the histogram
no_live_counts_normalized = no_live_counts / (sum(no_live_counts) * mode(diff(edges_no_live)));
% Adjust counts for plot
no_live_counts_plot = [0, no_live_counts_normalized, 0];
% Plot stairs
stairs([edges_no_live, edges_no_live(end) + 1], no_live_counts_plot, 'Color',...
    [0.2157, 0.4941, 0.7216], 'LineWidth',3);


% make plot prettier 
prettify_plot;
legend({['researchers in neuroscience' newline 'working with live animals'...
    newline 'n = ' num2str(numel(n_years_publi_neuro_live))],...
    ['other researchers' newline 'n = ' num2str(numel(n_years_publi_no_live))]})
xlabel(['number of years from start of PhD' newline 'to 1rst "first author" publication'])
ylabel('fraction of researchers')
ylim([0, 0.45])
