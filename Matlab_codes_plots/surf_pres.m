% plotting sea surface pressure corrections

function surf_pres(float_name)

%Input:
%     float_name   WMO number of float e.g. 3901520


load(['../Example_float/surf_pres_',num2str(float_name),'.mat'])
%%
figure;
set(gcf,'defaultaxesfontsize',12)
ss(1)=subplot(2,1,1); hold on;
plot(profnum,surfpres,'r+');
plot(profnum,pres_cor,'gx');
plot(app_corr_profnum,app_corr,'bo');
set(gca,'YLim',[-20,20]);
xlabel('Profile number'); ylabel('Surface Pressure dbar')
title([{'Raw surface pressure measured before descent (+0 dbar offset) for float',num2str(float_name),'pressure correction in green'}]);

ss(2)=subplot(2,1,2); hold on; 
semilogy(profnum,surfpres,'r+');
semilogy(profnum,pres_cor,'gx');
semilogy(app_corr_profnum,app_corr,'bo');
xlabel('Profile number'); ylabel('Surface Pressure dbar')
set(gcf,'papertype','usletter','paperunits','inches','paperorientation','portrait','paperposition',[.25,.5,8,10]);

print(['..\Example_float\surf_pres_',num2str(float_name)],'-depsc');