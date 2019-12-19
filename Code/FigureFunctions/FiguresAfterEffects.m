function FiguresAfterEffects(StudyData, param, binWidth, Color, removeBias, afterTrialP, earlyValues,lateValues) 

%This function is used to plot the timecourses for Gonzalez-Rubio et al,
%2019 Adaptation and the respective bar plots. Remember the control group
%data is the same for both plots since it's our reference group.

%Making sure we have the necessary function inputs

if nargin<1 || isempty(param)
    error('You must have a Study Data Objects as an input');
end

if nargin<2 || isempty(param)
    param={'Sout'};
elseif length(param)>1
    param=param{1};
    warning ('More than one parameter was specified, the first one has been chosen');
end

if nargin<3 || isempty(binWidth)
    binWidth=1;
end

if nargin<4 || isempty(Color)
    Color=1;
elseif size(Color)==[1 1]
    if Color~=1 && Color ~=2 && Color ~=3 && Color~=4 && Color~=5 && Color~=6
        Color=1;
        warning('Color was not specified correctly, taking the default color scheme');
    end
elseif size(Color)==[3 3];
    colorOrder=Color;
end 
    
if nargin<5 || isempty(removeBias)
    removeBias=0;
end 

if nargin<6 || isempty(removeBias)
    afterTrialP=60;
end 

if nargin<7 || isempty(removeBias)
    earlyValues=250;
end 

if nargin<8 || isempty(removeBias)
    lateValues=50;
end 

%% Plot the Spatial Feedback group against the Control group

FiguresSpatialAE(StudyData, param, binWidth,Color,removeBias, afterTrialP, earlyValues,lateValues);

%% Plot the Temporal Feedback group against the Control group

FiguresTemporalAE(StudyData, param, binWidth,Color,removeBias, afterTrialP, earlyValues,lateValues);

end
