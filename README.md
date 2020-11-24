# dm-report-template
 This repository include the report template and Matlab codes used to generate plots requied in the DMQC report for core Argo parameters.
 
 ## LaTex template
 The report template has been created based on the LaTeX software. This template is **WMOnum_DMQCreport_YYYYMMDD.tex**. 
 The gudelines how to install and use the LaTex software can be found in **LaTeX_DMQC_report_template_guidelines.pdf**.
 
 There is also available an online version of this template, using the online Overleaf LaTeX editor, which can be found here  https://www.overleaf.com/project/5f92ebe45b388e00015257c8
 
 ## .pdf version of template
 The .pdf version of DMQC report template can be found in **WMOnum_DMQCreport_YYYYMMDD.pdf**.
 
 ## Matlab codes
 The Matlab codes are included in folder **Matlab_codes_plots**. The example data and plots used to generate report are in **Example_float**.
 

 ### check_raw_data.m
 This code is generating: 
 * Argo float data plotted against the CTD referenced data
 * time series of potential temperature and salinity data of Argo float
 
 #### How to use?
The input and output directories in this fucntion are set to read an example data from folder **Example_float**. 
To use this function for other floats you need to change the directories in the code.

* the code is using the input data from float source .m file, whichc is an entry to run the OWC software (This matrix can be generated using the create_float_source.m located in https://github.com/euroargodev/dm_floats repository).

* set the directory of the CDT reference data in additional codes: plotwmoboxt.m, plotwmoboxts.m, plotwmoboxsal.m.

* run the code by using the WMO float number

         >> check_raw_data(float_name), e.g. check_raw_data(3901520)       
  
### surf_pres.m
 This code is generating plot with the correction applied the sea surface pressure data. This plot is used for the floats (e.g. APEX) where the pressure sensor is not auto-corrected to zero while at the sea surface, hance the pressure data in was corrected during processing in delayed mode.
 
 #### How to use?
The input and output directories in this fucntion are set to read an example data from folder **Example_float**. 
To use this function for other floats you need to change the directories in the code.

* the code is using the input data from surf_pres<WMO> .m file. This file need to be generated internally by organisations.

* run the code by using the WMO float number

         >> surf_pres(float_name), e.g. surf_pres(3901520)


 
 
 
 
