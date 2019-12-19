function results = getResults(Study,params,groups,removeBiasFlag)

nParams=length(params);

if nargin<3 || isempty(groups)
    groups=fields(Study);  %default
end
nGroups=length(groups);


if nargin<4 || isempty(removeBiasFlag)
    removeBiasFlag=0;
end


% Initialize outcome measures to compute
outcomeMeasures =...
    {'TMsteady',...
    'InitialWash',...
    'InitialAdap',...
    'TMbase',...
    'DeltaAdapt',...
    'Familiarization',...
    'LateWash',...
    };

for i =1:length(outcomeMeasures)
    results.(outcomeMeasures{i}).avg=NaN(nGroups,nParams);
    results.(outcomeMeasures{i}).se=NaN(nGroups,nParams);
end


for g=1:nGroups
    
    % get number of subjects in group
    nSubs=length(Study.(groups{g}).ID);
    
    % clear/initialize measures
    for i=1:length(outcomeMeasures)
        eval([outcomeMeasures{i} '=NaN(nSubs,nParams);'])
    end
    
    AdaptExtent=[];
    
    for s=1:nSubs
        % load subject
        adaptData=Study.(groups{g}).adaptData{s};
        
        % remove bad strides
        if removeBiasFlag==1
            adaptData=adaptData.removeBias;
        end
        adaptData=adaptData.removeBadStrides;
                
        for p=1:length(params)
                        
            % Late TM Base
            if nansum(cellfun(@(x) strcmp(x, 'TM base'), adaptData.metaData.conditionName))==1
                TMbaseData=adaptData.getParamInCond(params{p},'TM base');
                if isempty(TMbaseData)
                    TMbaseData=adaptData.getParamInCond(params{p},{'slow base','fast base'});
                end
                TMbase(s,p)=nanmean(TMbaseData(end-45:end-6,:)); 
            end
            
            %Late Familiarization
            if nansum(cellfun(@(x) strcmp(x, 'familiarization'), adaptData.metaData.conditionName))==1
                famData=adaptData.getParamInCond(params{p},'familiarization');
                Familiarization(s,p)=nanmean(famData(end-45:end-6,:)); 
            end            

            % Compute TM post
            if nansum(cellfun(@(x) strcmp(x, 'TM post'), adaptData.metaData.conditionName))==1
                tmafterData=adaptData.getParamInCond(params{p},'TM post');
                InitialWash(s,p)=nanmean(tmafterData(2:31,:)); 
                LateWash(s,p)=nanmean(tmafterData((end-45):(end-6),:));
            end
            
            % compute Washout
            if nansum(cellfun(@(x) strcmp(x, 'Washout'), adaptData.metaData.conditionName))==1
                washoutData=adaptData.getParamInCond(params{p},'Washout');
                InitialWash(s,p)=nanmean(washoutData(2:31,:)); 
                LateWash(s,p)=nanmean(washoutData((end-45):(end-6),:));
            end
            
            % compute EarlyAdaptation
            if nansum(cellfun(@(x) strcmp(x, 'adaptation'), adaptData.metaData.conditionName))==1
                adaptationData=adaptData.getParamInCond(params{p},'adaptation');
                InitialAdap(s,p)=nanmean(adaptationData(2:6,:));
            end
            
            % compute TM steady state
            
            adapt2Data=[];
            if nansum(cellfun(@(x) strcmp(x, 're-adaptation'), lower(adaptData.metaData.conditionName)))==1
                adapt2Data=adaptData.getParamInCond(params{p},'re-adaptation');
            elseif isempty(adapt2Data)
                adapt2Data=adaptData.getParamInCond(params{p},{'adaptation'});
            end            
                    
            TMsteady(s,p)= nanmean(adapt2Data(end-45:(end-6),:)); 
             
        end
        
    end

for j=1:length(outcomeMeasures)
    eval(['results.(outcomeMeasures{j}).avg(g,:)=nanmean(' outcomeMeasures{j} ',1);']);
    eval(['results.(outcomeMeasures{j}).se(g,:)=nanstd(' outcomeMeasures{j} './sqrt(nSubs));']);
end

if g==1 
    
        for p=1:nParams
            for m = 1:length(outcomeMeasures)
                eval(['results.(outcomeMeasures{m}).indiv.(params{p}) = [g*ones(nSubs,1) ' (outcomeMeasures{m}) '(:,p)];'])
            end
        end
    
else
        for p=1:nParams
            for m = 1:length(outcomeMeasures)
                eval(['results.(outcomeMeasures{m}).indiv.(params{p})(end+1:end+nSubs,1:2) = [g*ones(nSubs,1) ' outcomeMeasures{m} '(:,p)];'])
            end
        end

end
end

end



