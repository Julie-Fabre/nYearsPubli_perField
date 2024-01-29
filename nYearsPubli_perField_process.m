%% load full csv, extract and save relevant fields (remove any identifying information) 

% load full csv containing all data (saved locally) 
filename = '/home/julie/Downloads/Systems Neuroscience PhD paper publication time survey (Responses) - Sheet1.csv';
rawData_table = readtable(filename);

% extract fields 
summaryData_table = table();

summaryData_table.liveAnimals = strcmp(...,
    rawData_table.DidYourPhDWorkEntailRecordingPopulationsOfNeuronsInAwakeAnimals, ...
    {'Yes'});

summaryData_table.PhDField = rawData_table.InWhichFieldDidYouCompleteYourPhD_;

summaryData_table.PhDStart_year = rawData_table.WhatYearDidYouStartYourPhD_;

summaryData_table.FirstAuthorPub_year = rawData_table.WhatYearDidYouPublishYourFirst_first_author_Paper_;

% compute new fields
summaryData_table.neuroField_liveAnimals = ...
    summaryData_table.liveAnimals & strcmp(summaryData_table.PhDField, {'Neuroscience'});

summaryData_table.timeToFirstAuthorPub = summaryData_table.FirstAuthorPub_year - summaryData_table.PhDStart_year;

% save new csv (publically accessible) 
writetable(summaryData_table,'/home/julie/Dropbox/MATLAB/onPaths/nYearsToPubli_perField/nYearsPubli_perField_summary.csv')