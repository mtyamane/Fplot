# Fplot
**runme_Fplot.m** plots harvest rate estimations which result from running the State-Space Integral Projection model described in 
White et al., Ecological Applications (2016) Fitting state-space integral projection models to time series data. All code was written in MATLAB 2019a.

This implementation was originally written for plotting results from the Santa Barbara Channel Islands, using data collected by the [Partnership for Interdisciplinary Studies of Coastal Oceans](http://www.piscoweb.org/kelp-forest-study) (PISCO)

## Installation Instructions ##
Clone or download .zip of **Fplot**

Modify format of results file to match the example results file **SSIPM_Results_noHeaders.csv**, which may include adding a column to order sites of each region laterally, **from west to east** (1-N)

Modify **FplotData.m** if different formatting of the plots are desired (marker colors, font sizes, figure dimensions, etc.)

## Running the Program ##
```
runme_Fplot('Species', 'Type')
```
where, **'Species'** is a character array of the PISCO code for the species and **'Type'** is a character array of the site(s) to plot

Species and Types used in this implementation are defined in **runme_Fplot.m**

**runme_Fplot.m** calls:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FplotData.m** to create savenames, set plot parameters (colors, axis labels, figure dimensions, etc.)
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**read_F_results.m** to read in a .csv file containing results from running the harvest estimation
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**plot_F_results.m** to plot results, display legend and/or title or neither, and save figure as a .eps file

**Note:** Example results are in the **data** folder and example plots are in the **figures** folder

Example plot of Kelp Bass results at all sites studied (**Type = 'Full'**):

![Plot of Kelp Bass results at all sites](/figures/PCLA_Full_F_results_plot.png)

Example plot of Kelp Bass results at one site (**Type = 'SCI'**):

![Plot of Kelp Bass results from Santa Cruz Island](/figures/PCLA_SCI_F_results_plot.png)
