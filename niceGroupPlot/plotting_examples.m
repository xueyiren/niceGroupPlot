% Written by Rebecca Lawson, May 2016.
% Edited by Rebecca Lawson, Aug 2018.
% This code relies on additional functions (included in the 'EssentialCode'
% folder - please add to path. See the Background notes in niceGroupPlot.m for
% more information. This code is not supported, but has been
% tested on Matlab 2018a.

%% niceGroupPlot Function info
% - Required Inputs -
% data - a 1x2 cell array that contains the data for the two groups of ppts.  
%        data{1} holds the data to be plotted for group 1 and should be a
%        1xn double, where the length of n is equal to the number of
%        participants in group 1 x the number of conditions.
%        e.g. if you have 20 ppts in each group and 3 conditions then data {1} 
%        would be a cell array that contains a 60 x 1 double. data{2} is the
%        same for group 2, but may be a different length if the two groups
%        contained different numbers of ppts.
% cond - a 1x2 cell aray that contains the condition labels for each entry in 
%        the data cell array (e.g. 1, 2, 3 etc) for each entry in data.
%        Should handle 1 to n conditions. 

% > See the example 'data' and 'cond' variables to see how to set up these
%   inputs for yourself.

% - optional inputs -
% 'dotsize' - a number from 0.001 to n, indicating how large to make the dots
%             in the boxplot. If you're plotting thousands of datapoints make 
%             the dotsize smaller (e.g. 1). Set to a really small value 
%             (e.g. 0.001 if you don't want to see the raw data at all.
% 'col1' -    the colour to plot group 1 in. An integer from 1 to 8. Indexes
%             the rows in the 'color brewer' colourmap (set on line 97 below) 
%             Default = 1 (pink). Check out colourmap.tif in the main script 
%             folder to see the colour options.
% 'col2' -    the colour to plot group 2 in. An integer from 1 to 8. Indexes
%             the rows in the 'color brewer' colourmap. Choose a different 
%             colour from group 1. Default = 2 (green)
% 'gplab' -   a cell array with the names of your two groups (e.g. {'ASD', 'NT'}.
%             Defaults to to 'group 1' and 'group 2'.
% 'condlab' - a cell array with the names of your conditions (e.g. {'Pre', 'Post'}.
%             Should have as many entries as there are unique elements of 'cond'. 
%             i.e. if you have three conditions, please supply three
%             condition labels. Defaults to 'cond 1 - n' if no labels are
%             supplied.
% 'transp' -  The transparency applied to all the colour patches in the
%             plot. An integer from 0 (no colour) to 1 (full colour).
%             Defaults to 1.
% 'whatplot'- 1 = both splitViolin AND notBoxPlot,2 = just splitViolin, 
%             3 = just notBoxPlot. Defaults to 1. 
% 'fitline' - Do you want to add a linear trend line across the conditions
%             for each group? Set to '1' for yes and 0 leave blank for 'no'.
%             Defaults to 0. Only an option where 
%             'whatplot' = 1 or 3 (i.e. where there is a boxplot)

%% load example data
load ('example_data');
%% open a figure
figure('rend','painters','pos',[10 10 1200 1200])

%% Take just conditions 1:2 from example data (i.e. 2 conditions instead of 4)
data{1}=data{1,1}(1:500);
data{2}=data{1,2}(1:500);
cond{1}=cond{1,1}(1:500);
cond{2}=cond{1,2}(1:500);
%% Plot the scatter box only ('whatplot', 3)
subplot(3,3,1)
niceGroupPlot(data,cond, 'dotsize',0.5, 'whatplot', 3);
title('scatter box only');
%% Plot the split violins only ('whatplot', 2)
subplot(3,3,2)
niceGroupPlot(data,cond,'whatplot', 2);
title('split violin only');
%% Plot both together ('whatplot', 1)
% Could  be considered overkill, but you may wish to see the raw data, 
% mean,sd,sem and also the density of the datapoints on one plot.
% Personally I think this is too busy, but each to their own.
subplot(3,3,3)
niceGroupPlot(data,cond, 'dotsize',0.5, 'whatplot', 1);
title('both')

%% load the data again
load ('example_data');

%% Change the plot colours ('col1', 4 and 'col2', 6) and set ('dotsize', 0.1).
subplot(3,3,4)
niceGroupPlot(data,cond, 'dotsize',1, 'col1', 4, 'col2', 6, 'whatplot', 3);
title('change colours and dot size')

%% Pass custom group and condition labels to the function to plot
subplot(3,3,5)
niceGroupPlot(data,cond, 'whatplot',2 , 'col1', 3, 'col2', 5, 'gplab', ...
    {'patients', 'controls'}, 'condlab', {'high', 'med', 'low'}, ...
      'transp', 0.3);
title('change labels and transparency');

%% Remove the dots from the scatter box ('dotsize',0.001) and change colours 
subplot(3,3,6)
niceGroupPlot(data,cond, 'dotsize',0.001,'col1', 7, 'col2', 5, 'fitline',1);
title('remove dots & fit line')

%% Scatter Box plot and fit line (recreates the plots in 
%  Lawson et al, (2017) Nature Neuroscience).
subplot(3,3,7)
niceGroupPlot(data,cond, 'dotsize',1,'col1', 2, 'col2', 3, ...
    'gplab', {'ASD', 'NT'}, 'condlab', {'E', 'N', 'UE'}, ...
    'whatplot', 3, 'fitline', 1);
title('scatter box & fit line');
%% Take just condition 1 from the example data
% and only the first 25 data points to emulate a small sample size.
data{1}=data{1,1}(1:25);
data{2}=data{1,2}(1:25);
cond{1}=cond{1,1}(1:25);
cond{2}=cond{1,2}(1:25);
%% Plot just condition 1, edit the labels, change the colours, transparency and dot size. 
subplot(3,3,8)
niceGroupPlot(data,cond, 'dotsize',4,'col1', 1, 'col2', 6, ...
    'gplab', {'men', 'women'}, 'condlab', {'empathy score'}, ...
    'transp', 0.7, 'whatplot', 3);
title('one condition, small n, large dots')
%% Same as plot above but change the plot type to add in the distribution. 
subplot(3,3,9)
niceGroupPlot(data,cond, 'dotsize',3,'col1', 1, 'col2', 6, ...
    'gplab', {'men', 'women'}, 'condlab', {'empathy score'}, ...
    'transp', 0.5, 'whatplot', 1);
title('add distribution')
