% Explicit Control of Step Time Study -- Publication Reproducibility

close all
clear 
clc 

load('StudyData.mat'); %You must be in the folder where the Study Data object is located

%Initialize some plotting parameters
binWidth=1;
Color=5; %This number has to be between 1 and 6, 5 is the colors used in the paper
removeBias=5;
earlyStrides=250;
lateStrides=50;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 2 and Figure 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


                %% Time course and Bar Plots in Left Panel A (Adaptation)

                %Spatial Motor Output

                interTrial=30;

                param={'Sout'};
                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);
                
                %% Time course and Bar Plots in Left Panel B (Recalibration/After-effects)

                %Spatial Motor Output

                interTrial=60;
                FiguresAfterEffects(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);


                %% Time course and Bar Plots in Right Panel A (Adaptation)

                %Temporal Motor Output

                param={'Tout'};
                interTrial=30;

                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias)


               
                %% Time course and Bar Plots in Right Panel B (Recalibration/After-effects)

                %Temporal Motor Output

                interTrial=60;

                param={'Tout'};
                FiguresAfterEffects(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 3 and Figure 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


                %% Time course and Bar Plots in Left Panel A (Adaptation)

                %Spatial Motor Output

                interTrial=30;

                param={'Serror'};
                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);
                
                %% Time course and Bar Plots in Left Panel B (Recalibration/After-effects)

                %Spatial Motor Output
                
                interTrial=60;
                
                param={'Serror'};
                FiguresAfterEffects(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);


                %% Time course and Bar Plots in Right Panel A (Adaptation)

                %Temporal Motor Output

                interTrial=30;
                
                param={'Terror'};
                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias)
               
                %% Time course and Bar Plots in Right Panel B (Recalibration/After-effects)

                %Temporal Motor Output

                interTrial=60;
                
                param={'Terror'};
                FiguresAfterEffects(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %% Time course and Bar Plots in Left Panels (Adaptation)

                %Spatial Motor Output

                interTrial=30;

                param={'Sgoal'};
                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias, interTrial, earlyStrides, lateStrides);


                %% Time course and Bar Plots in Right Panels (Adaptation)

                %Temporal Motor Output

                param={'Tgoal'};
                interTrial=30;

                FiguresSteadyState(StudyData, param,binWidth,Color,removeBias)
                

                
                
                
%% Generate Matrices to ease Stata Data file creation

clear
clc

load('StudyData.mat')
removeBias=1;
params={'Sout', 'Tout', 'Serror', 'Terror', 'Sgoal', 'Tgoal'};

% Matrices for Stata

[Labels1, M1]=MatricesStataSTS(StudyData, params,removeBias);

%%VOy a intentar crear el file como el de STATA, y cuanod esto este listo
%%puedo empezar a subir toda la info

