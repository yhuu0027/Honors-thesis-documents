# Honors-thesis-documents
Yueheng Hu's honors thesis coding documents

All the following code for this thesis is written in R and Stata.
This readme includes 3 sections:
1. Main .m files
2. Key functions
3. Data description and websites

The following auxiliary functions and files are called up by the main 
files:

Replication:
A_Figure1_IRF_oilprice_2006       
A_Figure2_historical_decomposition
A_Figure3_CumIRF_dividends_2006
A_Figure3_CumIRF_stockreturn_2006
A_Table1_FEVD_stockreturn_2006
A_Table2_FEVD_dividends_2006

Extension:
B_figure3_stock
B_Figure1_IRF_oilprice
B_Figure2_historical_decomposition
B_Figure3_dividends
B_Table1_FEVD_stockreturn
B_Table2_FEVD_dividends

Functions:
olsvarc.m       Computes least-squares VAR parameters estimates
irfvar.m        Computes VAR impulse responses by Cholesky decomposition
stage2irf.m     Computes impulse responses from distributed lag model 
dif.m           First-difference operator
vec.m           Vectorization operator


Data description:

World - Crude oil including lease condensate (Mb/d)
01/01/1973—01/05/2022
https://www.eia.gov/international/data/world/petroleum-and-other-liquids/monthly-petroleum-and-other-liquids-production

Oil Price:
U.S. Crude Oil Imported Acquisition Cost by Refiners (Dollars per Barrel)
https://www.eia.gov/dnav/pet/pet_pri_rac2_dcu_nus_m.htm
Date source:
1974-January 1976: 
Federal Energy Administration (FEA), Form FEA-96, "Monthly Cost Allocation Report."
February 1976-June 1978: 
FEA, Form FEA-P110-M-1, "Refiners' Monthly Cost Allocation Report."
July 1978-December 1980: 
Form ERA-49, "Domestic Crude Oil Entitlements Program Refiners' Monthly Report.

Kilian’s index
https://www.dallasfed.org/research/igrea
Updated index of global real economic activity in industrial commodity markets, as proposed in Kilian (2009), with the correction discussed in Kilian (2019). 
This business-cycle index is expressed in percent deviations from trend. It is derived from a panel of dollar-denominated global bulk dry cargo shipping rates and may be viewed as a proxy for the volume of shipping in global industrial commodity markets. For further discussion of the advantages of this index compared with measures of global real GDP or global industrial production see Kilian and Zhou (2018). This index is updated monthly.


Stock market variable:
S&P500:
http://www.econ.yale.edu/~shiller/data.htm.
The data and CAPE Ratio on this spreadsheet were developed by Robert J. Shiller using various public sources.  Neither Robert J. Shiller nor any affiliates or consultants, are registered investment advisers and do not guarantee the accuracy or completeness of the CAPE Ratio here, or any data or methodology either included therein or upon which it is based.  Individual investment decisions are best made with the help of a professional investment adviser
