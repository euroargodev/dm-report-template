function wmobox(rlat,rlon)

% Determine which WMO box
% note: can't cope with wrap-around

if(rlon>180)
    rlon=rlon-360;
end

if(rlat>=0 & rlon>=0)
    wmo1 = int8(1);
elseif(rlat>=0 & rlon<0)
    wmo1 = int8(7);
elseif(rlat<0 & rlon>=0)
    wmo1 = int8(3);
else
    wmo1 = int8(5);
end
wmo2=int8(abs(rlat/10)-.5);
wmotemp=int8(abs(rlon/10)-.5);
wmo4 = mod(wmotemp,10);
wmo3 = (wmotemp-wmo4)/10;
wmobox = sprintf('%1.0f',wmo1,wmo2,wmo3,wmo4);
wmofile = ['L:/bodc2/vault/archive/argo/cls100061/historical_ctd/CTD_for_DMQC_2019V01/ctd_' wmobox '.mat'];

% Plot WMO box data

if(exist(wmofile))
    load(wmofile)
    plot(sal,pres)
    set(gca,'ydir','reverse','ylim',[0 2100])
    hold on
end
