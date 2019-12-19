function [header1,Matrix1] = MatricesStataSTS(Study, params, removeBias) %,pairedttestFlag

if nargin<1 || isempty(Study)
    error('No Study Data Object');
end

if nargin<2 || isempty(params)
    params={'Sout','Tout'};
end

if nargin<3 || isempty(removeBias)
   removeBias=0;    
end

if removeBias==0
    epochs={'TM base', 'TMsteady', 'InitialWash'};
elseif removeBias==1
    epochs={'TMsteady', 'InitialWash'};
end

groups={'StepTimeStudyControl','StepTimeStudy','AlphaFeedback'};

%Get Results

R=getResults(Study, params,groups, removeBias);

Spatial=find(R.TMsteady.indiv.(params{1})(:, 1)==3);
Temporal=find(R.TMsteady.indiv.(params{1})(:, 1)==2);
Control=find(R.TMsteady.indiv.(params{1})(:, 1)==1);

% For the ANOVAS and comparisons between groups

Subject=[];
Epoch=[];
subnum=0;
ID=[];
grp=[];
Group=[];

for e=1:length(epochs)
    for g=1:length(groups)
        
        grp(g)=length(find(R.(epochs{1}).indiv.(params{1})(:, 1)==g));
        Subject=[Subject 1:grp(g)];
        Group=[Group g*ones(1,grp(g))];
        
        subnum=subnum+grp(g);
    end
    
    Epoch=[Epoch e*ones(1,sum(grp))];
    ID=[ID 1:subnum];
    subnum=0;
end

Subject=Subject';
ID=ID';
Epoch=Epoch';
Group=Group';

tabla={'Subject','ID','Group', 'Epoch'};

for p=1:length(params)
    
    eval([(params{p}) '=[];'])
    
    for e=1:length(epochs)
        
       eval([(params{p}) '=[' (params{p}) ';R.(epochs{e}).indiv.(params{p})(:, 2)];'])
        
    end
    
    
    tabla{length(tabla)+1}=(params{p});
        
end

data=[];
labels={};
i=1;

for p=1:length(params)
    data=[data, eval(params{p})];
    
    i=i+1;
end

data=[Subject,ID,Group,Epoch,data];
Matrix1=table(data, 'VariableNames', {'ANOVAs'});
header1=tabla;




close all

end




