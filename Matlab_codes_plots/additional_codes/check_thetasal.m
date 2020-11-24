function check_thetasal(float,LAT,LONG,PRES,PTMP,SAL)

% check_thetasal(float)
% Uses float Wong-matrix to plot potential temperature with respect to
% salinity
% Saves plot to PostScript file in local working directory
% Input parameters:
%
%    float       WMO number of Argo floats e.g. '3901520'
%    LAT         Latitude of Argo float
%    LONG        Longitude of Argo float
%    PRES        Pressure of Argo float
%    PTMP        Potential temperature of Argo float
%    SAL         Practical salinity of Argo float

fileplot = ['../Example_float/' float '_check_thetasal.eps'];

mins=33;maxs=38;mint=-1.5;maxt=30; 
refden=0; % reference density  
% create a grid of temperatures and salinities to calculate density for
sv=[mins:((maxs-mins)/100):maxs];ptv=[mint:((maxt-mint)/100):maxt]; 
[X,Y]=meshgrid(sv,ptv); 
% sw_dens is in the 'seawater' routines. 
pden=sw_dens(X,Y,refden);
%gden_2d=gsw_rho(X,Y,p);
hold on; 
[c,l]=contour(X,Y,pden-1000,'k');
clabel(c,l,'fontsize',12,'color','k'); 
box on

% The following 6 lines should cope with determining (a good approximation to) 
% the mean longitude of a float when it crosses the Greenwich Meridian. 
meansin = mean(sind(LONG));
meancos = mean(cosd(LONG));
rlonmean = atan2(meansin,meancos)*180/pi
if(rlonmean<0) 
 rlonmean = rlonmean+360
end

rlatmean = mean(LAT)

plotwmoboxts(rlatmean,rlonmean)

 plotwmoboxts(rlatmean+10,rlonmean-10)
 plotwmoboxts(rlatmean+10,rlonmean)
 plotwmoboxts(rlatmean+10,rlonmean+10)
 plotwmoboxts(rlatmean,rlonmean-10)
 plotwmoboxts(rlatmean,rlonmean+10)
 plotwmoboxts(rlatmean-10,rlonmean-10)
 plotwmoboxts(rlatmean-10,rlonmean)
 plotwmoboxts(rlatmean-10,rlonmean+10)

%plotwmoboxts(-55,55)
%plotwmoboxts(-55,65)
%plotwmoboxts(-55,75)
%plotwmoboxts(-55,85)
%plotwmoboxts(-55,95)
%plotwmoboxts(-55,105)
%plotwmoboxts(-55,115)
%plotwmoboxts(-55,125)

% Plot float data as scatter

size1d = size(PRES,1)*size(PRES,2);
psal1d = reshape(SAL,size1d,1);
ptmp1d = reshape(PTMP,size1d,1);
scatter(psal1d,ptmp1d,'markerfacecolor',[.49 1 .63],'sizedata',15,'markeredgecolor','g')
%scatter(psal1d,ptmp1d,'g','.')
%size1d = size(PRES,1)*size(PRES,2);
%psal1d = reshape(SAL,size1d,1);
%ptmp1d = reshape(PTMP,size1d,1);
%scatter(psal1d,ptmp1d,'g','.')

minimum_pt = min(ptmp1d)

% First and last profiles coloured (black, blue)

lastprof = size(PRES,2);
scatter(SAL(:,1),PTMP(:,1),'markerfacecolor',[.49 1 .63],'sizedata',15,'markeredgecolor','k')
scatter(SAL(:,lastprof),PTMP(:,lastprof),'markerfacecolor',[.49 1 .63],'sizedata',15,'markeredgecolor','b')
%scatter(SAL(:,1),PTMP(:,1),'k','o')
%scatter(SAL(:,lastprof),PTMP(:,lastprof),'b','o')


% Title

title({['Float ',num2str(float),': theta vs salinity'],['(symbols = float profiles,% curves = historical CTDs)']});
hold off;
%set(gca,'xlim',[34.6 34.9],'ylim',[0 4])
xlabel('Salinity (Dimensionless)');
ylabel('Potential Temperature (\circC)');
set(gca,'Fontsize',10)
set(gcf,'Units','centimeters','PaperPosition',[0 0 18 20])

print('-depsc',fileplot);
