
function check_raw_data(float_name)
% These codes include plots of raw data of Argo floats and comparison of
% Argo float data with CTD reference data.

%Input:
%     float_name   WMO number of float e.g. 3901520



% Kamila Walicka, BODC, 24/11/2020

%% 

addpath('.\additional_codes') 

%% Plots of Argo data plotted againts CTD reference data.

%load source data from Argo float
load(['..\Example_float\data\float_source\',num2str(float_name),'.mat'])

check_thetasal(num2str(float_name),LAT,LONG,PRES,PTMP,SAL)
check_psal(num2str(float_name),LAT,LONG,PRES,SAL)
check_ptheta(num2str(float_name),LAT,LONG,PRES,PTMP)

%% Plots of Argo reference data time series
%
DATES_vec=(repmat(PROFILE_NO,size(PRES,1),1));
sz=100;

% Figure 1 Potential temperature
figure;
subplot(2,1,1);
scatter(DATES_vec(:),PRES(:),sz,PTMP(:),'s','filled') ;
hold on
colormap(jet(15));%colormap(jet(30))
cm=colorbar;

[C,h]=contour(DATES_vec,PRES,PTMP,'color','k','LineWidth',1);
clabel(C,h,'fontsize',8);
set(gca,'YDir','reverse') ;
ylabel(cm,{'Potential Temperature (degC)'}) ;
box on
ylim([-50,(max(max(PRES))+100)]) 
%xlim([DATES(1)-0.018,DATES(end)+0.018]);
xlabel('Profile Number');
ylabel({'Pressure (dbar)'});
title(['Float ',num2str(float_name),' Potential Temperature'])
set(gca,'Fontsize',10)
set(gcf,'Units','centimeters','PaperPosition',[0 0 18 20])                       
print(['..\Example_float\PTMP_raw',num2str(float_name)],'-depsc')

% Figure 2 practical Salinity
figure;
subplot(2,1,1);
scatter(DATES_vec(:),PRES(:),sz,SAL(:),'s','filled') ;
hold on
colormap(jet(15));%colormap(jet(30))
c=colorbar;

[A,b]=contour(DATES_vec,PRES,SAL,'color','k','LineWidth',1);
clabel(A,b,'Fontsize',8);
set(gca,'YDir','reverse') ;
box on

ylabel(c,'Salinity (PSS-78)');
xlabel('Profile Number')
ylabel('Pressure (dbar)')
ylim([-50,(max(max(PRES))+100)]) ;
%xlim([DATES(1)-0.018,DATES(end)+0.018]);
title(['Float ',num2str(float_name),' Salinity (PSS-78)'])
set(gca,'Fontsize',10)
set(gcf,'Units','centimeters','PaperPosition',[0 0 18 20])    

print(['..\Example_float\SAL_raw',num2str(float_name)],'-depsc');

clear all;close all
