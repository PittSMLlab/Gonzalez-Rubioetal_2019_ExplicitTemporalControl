function FiguresTemporalSS(Study,param,binWidth,Color,removeBias, afterTrialP, earlyValues,lateValues)
% This figure is to show the kinetic timecourses for baseline and adaptation of the temporal feedback group and the control group, as well as the steady state bar plot 

%Initialize some of the variables for the plot

adaptDataList = {Study.StepTimeStudyControl.adaptData, Study.StepTimeStudy.adaptData};
groups={'Control', 'Temporal Feedback'};

conds={'TM base', 'adaptation'};
epoch={'TMsteady'};

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
    colorOrder=[p_red;  p_orange];
elseif Color==2
    colorOrder=[[62 38 168]./255;  [0 0.5 0]];
elseif Color==3
    colorOrder=[[0 0.447 0.741];  [0.85 0.325 0.098]];
elseif Color==4
    colorOrder=[[62 38 168]./255;  [44 195 167]./255];
elseif Color==5
    colorOrder=[p_red; p_orange];
elseif Color==6
    colorOrder=[[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]];
end

%% Timecourse plots

subers=[1:col*row];
subers=(reshape(subers,[col, row]))';

sub=subers(1, 1:4);

plotAvgTimeCourseSingleSTS(adaptDataList,param,conds,binWidth,trialMarkerFlag,indivSubFlag,IndivSubList,colorOrder,0,removeBias,groups,0,ah, row, col, sub, afterTrialP, earlyValues, lateValues); hold on


%% Bar Plots

fh=gcf;

R=getResults(Study,param,{'StepTimeStudyControl','StepTimeStudy'},removeBias);

%Steady State
barGroupsSingleSTS(Study,R,{'StepTimeStudyControl','StepTimeStudy'},param,epoch,colorOrder, row, col, subers(end),1)

ah=findobj(fh,'Type','Axes');

set(gcf, 'render', 'painter')




