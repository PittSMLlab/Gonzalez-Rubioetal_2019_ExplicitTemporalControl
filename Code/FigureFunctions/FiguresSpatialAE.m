function FiguresSpatialAE(Study,param,binWidth,Color,removeBias, afterTrialP, earlyValues,lateValues)
% This figure is to show the kinetic timecourses for baseline and adaptation of the spatial feedback group and the control group, as well as the steady state bar plot 

%Initialize some of the variables for the plot

adaptDataList = {Study.StepTimeStudyControl.adaptData,Study.AlphaFeedback.adaptData};
groups={'Control', 'Spatial Feedback'};

conds={'TM base', 'TM post'};
epoch={'InitialWash'};

indivSubFlag=[];
IndivSubList=[];

trialMarkerFlag=[0 0 0];
indivSubFlag=[];
IndivSubList=[];

%% Set up the physical Figure
axesFontSize=10;
labelFontSize=0;
titleFontSize=12;
row=1;
col=5;

[ah,figHandle]=optimizedSubPlot(row*col,row,col,'tb',axesFontSize,labelFontSize,titleFontSize);

%% Different options for color schemes

poster_colors;

if Color==1 
    colorOrder=[p_red; p_fade_green];
elseif Color==2
    colorOrder=[[62 38 168]./255;  [1 0 0]];
elseif Color==3
    colorOrder=[[0 0.447 0.741];  [0.929 0.694 0.125]];
elseif Color==4
    colorOrder=[[62 38 168]./255;  [255 178 102]./255];
elseif Color==5
    colorOrder=[p_red; [0 0.4470 0.7410]];
elseif Color==6
    colorOrder=[[0 0.4470 0.7410]; [0.9290 0.6940 0.1250]];
end


%% Timecourse plots

subers=[1:col*row];
subers=(reshape(subers,[col, row]))';

sub=subers(1, 1:4);

plotAvgTimeCourseSingleSTS(adaptDataList,param,conds,binWidth,trialMarkerFlag,indivSubFlag,IndivSubList,colorOrder,0,removeBias,groups,0,ah, row, col, sub, afterTrialP, earlyValues, lateValues); hold on


%% Bar Plots

fh=gcf;

R=getResults(Study,param,{'StepTimeStudyControl','AlphaFeedback'},removeBias);

%Steady State
barGroupsSingleSTS(Study,R,{'StepTimeStudyControl','AlphaFeedback'},param,epoch,colorOrder, row, col, subers(end),1)

ah=findobj(fh,'Type','Axes');

set(gcf, 'render', 'painter')



