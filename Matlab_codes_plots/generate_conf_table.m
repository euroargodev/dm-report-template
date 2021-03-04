
function generate_conf_table(config_file_path,calseries_file_path)
% These codes generate the latex code used to generate the configuration table included in the DMQC report.
% 

%Input:
%     config_file_path     : OW config file  path  e.g. '../Example_float/ow_config_sa_ctdv2.txt'
%     calseries_file_path  : OW calseries_WMONum.mat path e.g. '../Example_float/data/float_calib/calseries_3901520.mat'
% Cecile Cabanes, LOPS, 04/03/2021- the first release of code
%% 

addpath('./additional_codes') 

% load_configuration
lo_system_configuration = load_configuration([config_file_path]);

config_table_name = strrep(config_file_path, '.txt','_table.tex');


fw1=fopen([config_table_name],'w');

fprintf(fw1,'%s\n', ['\begin{table}[h]']);
fprintf(fw1,'%s\n', ['$$']);
fprintf(fw1,'%s\n', ['\begin{tabular}{|l|l|}']);
fprintf(fw1,'%s\n', ['\hline']);
fprintf(fw1,'%s\n', ['\multicolumn{2}{|c|}{OWC CONFIGURATION PARAMETERS}  \\']);
fprintf(fw1,'%s\n', ['\hline']);
fprintf(fw1,'%s\n', ['\hline']);
fprintf(fw1,'%s\n', ['CONFIG\_MAX\_CASTS		& ' lo_system_configuration.CONFIG_MAX_CASTS '     	\\']);
fprintf(fw1,'%s\n', ['MAP\_USE\_PV			& ' lo_system_configuration.MAP_USE_PV '       	\\']);
fprintf(fw1,'%s\n', ['MAP\_USE\_SAF		        & ' lo_system_configuration.MAP_USE_SAF '        	\\']);
fprintf(fw1,'%s\n', ['MAPSCALE\_LONGITUDE\_LARGE	& ' lo_system_configuration.MAPSCALE_LONGITUDE_LARGE '     	\\']);
fprintf(fw1,'%s\n', ['MAPSCALE\_LONGITUDE\_SMALL	& ' lo_system_configuration.MAPSCALE_LONGITUDE_SMALL '        \\']);
fprintf(fw1,'%s\n', ['MAPSCALE\_LATITUDE\_LARGE 	& ' lo_system_configuration.MAPSCALE_LATITUDE_LARGE '           \\']);
fprintf(fw1,'%s\n', ['MAPSCALE\_LATITUDE\_SMALL 	& ' lo_system_configuration.MAPSCALE_LATITUDE_SMALL '      \\']);
if lo_system_configuration.MAP_USE_PV==1
fprintf(fw1,'%s\n', ['MAPSCALE\_PHI\_LARGE	 	& ' lo_system_configuration.MAPSCALE_PHI_LARGE '      \\']);
fprintf(fw1,'%s\n', ['MAPSCALE\_PHI\_SMALL	 	& ' lo_system_configuration.MAPSCALE_PHI_SMALL '    \\']);
end
if isfield(lo_system_configuration,'MAPSCALE_AGE')
fprintf(fw1,'%s\n', ['MAPSCALE\_AGE		 	& ' lo_system_configuration.MAPSCALE_AGE '    \\']);
end
if isfield(lo_system_configuration,'MAPSCALE_AGE_SMALL')
fprintf(fw1,'%s\n', ['MAPSCALE\_AGE\_SMALL	& ' lo_system_configuration.MAPSCALE_AGE_SMALL '    \\']);
end
fprintf(fw1,'%s\n', ['MAPSCALE\_AGE\_LARGE		& ' lo_system_configuration.MAPSCALE_AGE_LARGE '    	\\']);
fprintf(fw1,'%s\n', ['MAP\_P\_EXCLUDE		 	& ' lo_system_configuration.MAP_P_EXCLUDE '      \\']);
fprintf(fw1,'%s\n', ['MAP\_P\_DELTA		 	& ' lo_system_configuration.MAP_P_DELTA '      \\']);
fprintf(fw1,'%s\n', ['CONFIG\_WMO\_BOXES       &' strrep(lo_system_configuration.CONFIG_WMO_BOXES,'_','\_') '   \\']);
fprintf(fw1,'%s\n', ['HISTORICAL\_CTD\_PREFIX  &' strrep(lo_system_configuration.HISTORICAL_CTD_PREFIX,'_','\_') '   \\']);
fprintf(fw1,'%s\n', ['HISTORICAL\_ARGO\_PREFIX  &' strrep(lo_system_configuration.HISTORICAL_ARGO_PREFIX,'_','\_')  '  \\ ']);
fprintf(fw1,'%s\n', ['\hline']);
disp('__________________________________________')
disp('CALSERIES FILE')
disp('__________________________________________')
disp(calseries_file_path)
fprintf(fw1,'%s\n', ['\multicolumn{2}{|c|}{CALSERIES PARAMETERS}  \\']);
file_calib= calseries_file_path;
calib.breaks='?';
calib.max_breaks='?';
calib.use_theta_lt='?';
calib.use_theta_gt='?';
calib.use_pres_lt='?';
calib.use_pres_gt='?';
calib.use_percent_gt='?';
calseries=[];
if exist(file_calib);
	calib=load(file_calib);
	calseries=calib.calseries;
    calib_profile_no=calib.calib_profile_no;
	thefield=fieldnames(calib);
	
	for kfields=1:length(thefield)
		if isempty(calib.(thefield{kfields}))
			calib.(thefield{kfields})='[ ]';
		else
			calib.(thefield{kfields})=num2str(calib.(thefield{kfields}));
		end
	end
end
calseries_0='';
calseries_1='';
b=unique(calseries);
f0=find(calseries==0);
if isempty(f0)==0
	calseries_0=[num2str(f0)];
end
index_cal=calib_profile_no(~calseries==0);
calseries=calseries(~calseries==0);
for kcal=2:length(calseries)-1
	if calseries(kcal)~=calseries(kcal-1)
		calseries_1=[calseries_1 num2str(index_cal(kcal)) '  '];
	end
end
    
fprintf(fw1,'%s\n', ['\hline']); 
fprintf(fw1,'%s\n', '\hline');
fprintf(fw1,'%s\n', ['breaks         & ' calib.breaks   ' \\']);
fprintf(fw1,'%s\n', ['max\_breaks       & ' calib.max_breaks ' \\']);
fprintf(fw1,'%s\n', [' use\_theta\_lt    & ' calib.use_theta_lt ' \\']);
fprintf(fw1,'%s\n', [' use\_theta\_gt    & ' calib.use_theta_gt ' \\']);
fprintf(fw1,'%s\n', [' use\_pres\_lt    & ' calib.use_pres_lt ' \\']);
fprintf(fw1,'%s\n', [' use\_pres\_gt    & ' calib.use_pres_gt ' \\']);
fprintf(fw1,'%s\n', ['use\_percent\_gt    & ' calib.use_percent_gt '\\']);
if isempty(calseries_0)==0
fprintf(fw1,'%s\n', ['Profiles excluded from the analyse    & ' calseries_0  '\\']);
else
fprintf(fw1,'%s\n', ['Profiles excluded from the analyse    & - \\']);
end
if isempty(calseries_1)==0
fprintf(fw1,'%s\n', ['Time series cutted at profiles    & ' calseries_1  '\\']);
else
fprintf(fw1,'%s\n', ['Time series cutted at profiles    & - \\']);
end

fprintf(fw1,'%s\n', '\hline');
fprintf(fw1,'%s\n', '\end{tabular}');
       
fprintf(fw1,'%s\n', ['$$']);

fprintf(fw1,'%s\n', ['\caption{Parameters of the OWC method }']);
fprintf(fw1,'%s\n', ['\label{tab3}']);
fprintf(fw1,'%s\n', ['\end{table}']);

fclose(fw1);
disp(' ')
disp(['>>>>>>> are converted to latex table ' config_table_name])