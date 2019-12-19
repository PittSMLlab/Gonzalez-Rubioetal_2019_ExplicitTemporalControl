function barGroupsSingleSTS(Study,results,groups,params,epochs,colorOrder,row, col, sub,indivFlag,dashFlag)
%Make a bar plot to compare groups for a given epoch and parameter
%   TO DO: make function be able to accept a group array that is different
%   thand the groups in the results matrix

%indivFlag=[];
mode=1;

if nargin<10 || isempty(indivFlag)
    indivFlag=[];
end 

if nargin<11 || isempty(dashFlag)
    dashFlag=1;
end 

if isempty(colorOrder)==1
poster_colors;
if length(groups)>3 %==3 I dont know about this
    colorOrder=[p_red;  p_orange;p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; [0 0 0]; p_red; p_orange; p_fade_green; p_fade_blue; p_plum];
elseif length(groups)==2
    colorOrder=[ p_orange; p_fade_green;p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow;  p_red; p_orange, p_grey, p_fade_green; p_fade_blue; p_plum];
end
end

%Set grey colors to use when individual subjects are plotted 
greyOrder=[0 0 0 ;1 1 1;0.5 0.5 0.5;0.2 0.2 0.2;0.9 0.9 0.9;0.1 0.1 0.1;0.8 0.8 0.8;0.3 0.3 0.3;0.7 0.7 0.7];

legendNAMES=[];
ngroups=length(groups);         
numPlots=length(epochs)*length(params);
numE=length(epochs);

dgroups=groups;

x=1;
for i=1:length(groups)
    
    for d=1:length(dgroups)
        
        if strcmp(groups{i},dgroups{d})
            indx(x)=d;
        end
        
    end
    x=x+1;
end


i=1;
for p=1:length(params)
     ReallyWhereStats=find(cellfun(@(x) strcmp(x, params{1}), fieldnames(results.(epochs{1}).indiv),'uniformoutput',1));
    limy=[];
   for t=1:numE
       subplot(row, col, sub)
       hold on
       for b=1:ngroups
           legendNAMES=[legendNAMES  groups{b}  Study.(groups{b}).ID];
           nSubs=length(Study.(groups{b}).ID);
           
           ind=b;
           switch mode
               case 1
                   
                   if indivFlag
                       
                       %bar(b,results.(epochs{t}).avg(b,ReallyWhereStats),'facecolor',greyOrder(ind,:));
                       bar(b,results.(epochs{t}).avg(indx(b),ReallyWhereStats),'facecolor',colorOrder(ind,:));
                                              %bar(b,results.(epochs{t}).avg(indx(b),ReallyWhereStats),'facecolor',colorOrder(ind,:));
                                              for s=1:nSubs
                                                  %                            aux=results.(epochs{t}).indiv.(params{ReallyWhereStats});
                                                  auxALL=results.(epochs{t}).indiv.(params{1});
                                                  aux=auxALL(auxALL(:,1)==indx(b),2);
                                                  plot(b-0.175,aux(s),'.','MarkerSize', 15, 'Color',[150 150 150]./255)
                       
                                              end
                   else
                       bar(b,results.(epochs{t}).avg(indx(b),ReallyWhereStats),'facecolor',colorOrder(ind,:));
                   end
%                    bar(b,results.(epochs{t}).avg(indx(b),ReallyWhereStats),'facecolor',colorOrder(ind,:));
               case 2
                   
                   
           end
           
       end
       switch mode
           case 1
               errorbar(results.(epochs{t}).avg(indx,ReallyWhereStats),results.(epochs{t}).se(indx,ReallyWhereStats),'.','LineWidth',2,'Color','k')
           case 2
               errorbar(results.(epochs{t}).avg(indx,ReallyWhereStats),results.(epochs{t}).se(indx,ReallyWhereStats),'LineWidth',2,'Color','k')
       end
       
        
       %%
       if length(groups)==3
           set(gca,'Xtick',1:ngroups,'XTickLabel',{'C', 'TFB', 'SFB'},'fontSize',9);%Orignoal
       end
       
%        axis tight
       limy=[limy get(gca,'Ylim')];
       limy(find(abs(limy)==1))=[];
       %ylabel(params{p}())
       ylabel([epochs{t} ': ' params{p}()])
       offsettersP=(limy(end)*.05);
      offsetters=(limy(end-1)*.05);
       
      if ~isfield(results.(epochs{t}), 'p') %~exist('results.(epochs{t}).p') %&& isempty(results.(epochs{t}).p)
          title(epochs{t})
      else
          if results.(epochs{t}).p(ReallyWhereStats)<0.001
              title(['p < 0.001']); %General
          else
              title(['p = ' num2str(results.(epochs{t}).p(ReallyWhereStats), '%0.3f')])
          end
      end
      i=i+1;

              %% PLOT POST HOC       
              if isfield(results.(epochs{t}), 'postHoc')  % Show the pst hoc
                  for ph=1:size(results.(epochs{t}).postHoc{ReallyWhereStats}, 1)
                      if isnan(results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 1)) || isnan(results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 2))
                          break
                      elseif abs(limy(end-1))>=abs(limy(end))
                          line([results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 1) results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 2)], [limy(end-1)+offsetters limy(end-1)+offsetters], 'Color', 'k')
                          limy(end-1)=limy(end-1)+offsetters;
                          if ph==size(results.(epochs{t}).postHoc{ReallyWhereStats}, 1)
                              ylim([limy(end-1)+2.*offsetters limy(end)])
                          else
                              limy(end-1)=limy(end-1)+offsetters;
                          end
                      elseif abs(limy(end-1))<abs(limy(end))
                          line([results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 1) results.(epochs{t}).postHoc{ReallyWhereStats}(ph, 2)], [limy(end)+offsettersP limy(end)+offsettersP], 'Color', 'k')
                          if ph==size(results.(epochs{t}).postHoc{ReallyWhereStats}, 1)
                              ylim([ limy(end-1) limy(end)+2.*offsettersP])
                          else
                              limy(end)=limy(end)+offsettersP;
                          end
                      end
                  end
              end
       
       
  
   end
   set(gcf,'Renderer','painters');

end

end


