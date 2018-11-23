close all, clear all, clc
cd('/Users/andrigun/Dropbox/glac_mass')
load('meafk.mat')
%%
close all
blue = [0 0 1];
green = [51/255 204/255 51/255];
red = [255/255 0 0];
txt_size = 24;
alpha = 0.05;
plot_with_trends = 0;
periods = 1999;

f = figure('Position', [50, 100, 2200, 1200]), hold on;
subplot(3,4,[1,2,3,5,6,7,9,10,11]),hold on;
    b1=plot([meafk.y(1),meafk.y(end)],[0,0],'k','LineWidth',1.5)
    b2=plot(meafk.y, meafk.bw,'-s','Color',blue,'MarkerSize',15,'MarkerEdgeColor',blue,'MarkerFaceColor',blue,'LineWidth',2)
    b3=plot(meafk.y, meafk.bs,'-s','Color',red,'MarkerSize',15,'MarkerEdgeColor',red,'MarkerFaceColor',red,'LineWidth',2)
    b4=plot(meafk.y, meafk.bn,'-s','Color',green,'MarkerSize',15,'MarkerEdgeColor',green,'MarkerFaceColor',green,'LineWidth',2)
    % Plot mean
    b5=plot([meafk.y(1),meafk.y(end)],[nanmean(meafk.bw),nanmean(meafk.bw)],'Color',blue,'LineWidth',1.2)
    b6=plot([meafk.y(1),meafk.y(end)],[nanmean(meafk.bs),nanmean(meafk.bs)],'Color',red,'LineWidth',1.2)
    b7=plot([meafk.y(1),meafk.y(end)],[nanmean(meafk.bn),nanmean(meafk.bn)],'Color',green,'LineWidth',1.2)
    % Plot fits
    % Winter
    if plot_with_trends == 1
    ifit = find(meafk.y(:) <= periods);
    mdl = fitlm(meafk.y(ifit),meafk.bw(ifit))
    b8 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',blue,'MarkerSize',15,'MarkerEdgeColor',blue,'MarkerFaceColor',blue,'LineWidth',1.5)
    [MK_bw1,p_value] = Mann_Kendall([meafk.bw(ifit)],alpha)
    %
    ifit = find(meafk.y(:) >= periods-1);
    mdl = fitlm(meafk.y(ifit),meafk.bw(ifit))
    b9 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',blue,'MarkerSize',15,'MarkerEdgeColor',blue,'MarkerFaceColor',blue,'LineWidth',1.5)
    [MK_bw2,p_value] = Mann_Kendall([meafk.bw(ifit)],alpha)
    % Summer
    ifit = find(meafk.y(:) <= periods);
    mdl = fitlm(meafk.y(ifit),meafk.bs(ifit))
    b10 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',red,'MarkerSize',15,'MarkerEdgeColor',red,'MarkerFaceColor',red,'LineWidth',1.5)
    [MK_bs1,p_value] = Mann_Kendall([meafk.bs(ifit)],alpha)
    %
    ifit = find(meafk.y(:) >= periods-1);
    mdl = fitlm(meafk.y(ifit),meafk.bs(ifit))
    b11 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',red,'MarkerSize',15,'MarkerEdgeColor',red,'MarkerFaceColor',red,'LineWidth',1.5)
    [MK_bs2,p_value] = Mann_Kendall([meafk.bs(ifit)],alpha)
    % Net
    ifit = find(meafk.y(:) <= periods);
    mdl = fitlm(meafk.y(ifit),meafk.bn(ifit))
    b12 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',green,'MarkerSize',15,'MarkerEdgeColor',green,'MarkerFaceColor',green,'LineWidth',1.5)
    [MK_bn1,p_value] = Mann_Kendall([meafk.bn(ifit)],alpha)
    %
    ifit = find(meafk.y(:) >= periods-1);
    mdl = fitlm(meafk.y(ifit),meafk.bn(ifit))
    b13 = plot(mdl.Variables.x1,mdl.Fitted,'--','Color',green,'MarkerSize',15,'MarkerEdgeColor',green,'MarkerFaceColor',green,'LineWidth',1.5)
    [MK_bn2,p_value] = Mann_Kendall([meafk.bn(ifit)],alpha)
        else
    end
    
    grid on
    xlim([1992 2018])
    grid on;
    xlabel('Year','FontSize',txt_size);
    ylabel('Specific mass balance (mH2O)','FontSize',txt_size);
    legend([b2 b3 b4],'Winter','Summer','Net')
    
	hText = text(0.02,1,'Vatnajökull','Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',36);
	hText = text(0.02,0.1,['b_w: ',num2str(nanmean(meafk.bw)),' (',num2str(std(meafk.bw)),') mH2O'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',28);
	hText = text(0.02,0.06,['b_n: ',num2str(nanmean(meafk.bn)),' (',num2str(std(meafk.bn)),') mH2O'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',28);
	hText = text(0.02,0.02,['b_s: ',num2str(nanmean(meafk.bs)),' (',num2str(std(meafk.bs)),') mH2O'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',28);


    
    set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
     'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'FontSize'    , txt_size,...
    'LineWidth'   , 1         );

    %
subplot(3,4,4);
    h=histfit(meafk.bw,6)%,'Orientation','horizontal')
    h(1).FaceColor = blue;
    h(2).Color = [.2 .2 .2];
    hText = text(0.02,0.8,'b_w','Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',36);

        set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
     'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'FontSize'    , txt_size,...
    'YTickLabel'  , [],...
    'LineWidth'   , 1         );


subplot(3,4,8);
    h=histfit(meafk.bn,6)%,'Orientation','horizontal','Normalization','pdf')
    h(1).FaceColor = green;
    h(2).Color = [.2 .2 .2];
    hText = text(0.02,0.8,'b_n','Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',36);

        set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
     'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'FontSize'    , txt_size,...
    'YTickLabel'  , [],...
    'LineWidth'   , 1         );

subplot(3,4,12);
    h=histfit(meafk.bs,6)%,'Orientation','horizontal')
    h(1).FaceColor = red;
    h(2).Color = [.2 .2 .2];
    hText = text(0.02,0.8,'b_s','Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',36);

        set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
     'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'FontSize'    , txt_size,...
    'YTickLabel'  , [],...
    'LineWidth'   , 1         );

    %print(f,['va_mass_balance'],'-dpng','-r0')