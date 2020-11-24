function check_psal(float,LAT,LONG,PRES,SAL)

% check_psal(float)
% Uses float Wong-matrix to plot salinity with respect to depth
% Saves plot to PostScript file in local working directory
% Input parameters:
%
%    float       WMO number of Argo floats e.g. '3901520'
%    LAT         Latitude of Argo float
%    LONG        Longitude of Argo float
%    PRES        Pressure of Argo float
%    SAL         Practical salinity of Argo float

fileplot = ['../Example_float/' float '_check_psal.eps'];

% The following 6 lines should cope with determining (a good approximation to) 
% the mean longitude of a float when it crosses the Greenwich Meridian. 
meansin = mean(sind(LONG));
meancos = mean(cosd(LONG));
rlonmean = atan2(meansin,meancos)*180/pi
if(rlonmean<0) 
 rlonmean = rlonmean+360
end

rlatmean = mean(LAT)

plotwmoboxsal(rlatmean,rlonmean)


 plotwmoboxsal(rlatmean+10,rlonmean-10)
 plotwmoboxsal(rlatmean+10,rlonmean)
 plotwmoboxsal(rlatmean+10,rlonmean+10)
 plotwmoboxsal(rlatmean,rlonmean-10)
 plotwmoboxsal(rlatmean,rlonmean+10)
 plotwmoboxsal(rlatmean-10,rlonmean-10)
 plotwmoboxsal(rlatmean-10,rlonmean)
 plotwmoboxsal(rlatmean-10,rlonmean+10)

%plotwmoboxsal(-5,45)

% Plot float data as scatter

size1d = size(PRES,1)*size(PRES,2);
pres1d = reshape(PRES,size1d,1);
psal1d = reshape(SAL,size1d,1);
scatter(psal1d,pres1d,'g','.')

% First and last profiles coloured (black, blue)

lastprof = size(PRES,2);
scatter(SAL(:,1),PRES(:,1),'k','o')
scatter(SAL(:,lastprof),PRES(:,lastprof),'b','o')

% Title
xlabel('Salinty (Dimensionless)')
ylabel('Pressure (dBar)')
title({['Float ',float,': pressure vs salinity'],['(symbols = float profiles, curves = historical CTDs)']})
hold off;

set(gca,'Fontsize',10)
set(gcf,'Units','centimeters','PaperPosition',[0 0 18 20])

print('-depsc',fileplot);
