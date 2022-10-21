// set memory for stata
clear all
set memory 200m
set more off

// Downloading useful user written packages
ssc install xtnptimevar
ssc install xls2dta

// Set my working directory 
cd "/Users/yuehenghu/Desktop/RP/Stata_RP"

// start a log file
log using "/Users/yuehenghu/Desktop/RP/Stata_RP/time-varying coefficient.log", replace

// import the data and convert to dta format
import excel "/Users/yuehenghu/Desktop/RP/Stata_RP/all_09151.xlsx", sheet("Sheet4") firstrow clear

//rename E co2_c //  CO2 emission, per capita
gen lCO2pp_c=log(CO2pp) // dependent variable. natural log of CO2 emission, per capita
rename lCO2pp_c lco2_c

//rename F gdp_c // explanatory variable. natural log of gdp
gen lGDPpp_c=log(GDPpp) // explanatory variable. natural log of gdp
rename lGDPpp_c lgdp_c

gen lGDPpp_c2=(lgdp_c)^2
rename lGDPpp_c2 lgdp_c2

gen techonology_c=Technology
gen fossil_fuel_prod_c=ffindex

tsset Number Year, yearly

describe 

// save the descriptive statistics
tabstat lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c, statistics(n mean sd min max range)
logout, save(mytable) 
logout, save(mytable) word


// Panel unit root test
// LLC: 
// without trend component, with FE only
xtunitroot llc lco2_c, demean lags(bic 5)
xtunitroot llc lgdp_c, demean lags(bic 5)
xtunitroot llc lgdp_c2, demean lags(bic 5)
xtunitroot llc fossil_fuel_prod_c, demean lags(bic 5)
xtunitroot llc techonology_c, demean lags(bic 5)
// with trend component, with FE only
xtunitroot llc lco2_c, trend demean lags(bic 5)
xtunitroot llc lgdp_c, trend demean lags(bic 5)
xtunitroot llc lgdp_c2, trend demean lags(bic 5)
xtunitroot llc fossil_fuel_prod_c, trend demean lags(bic 5)
xtunitroot llc techonology_c, trend demean lags(bic 5)

// IPS: 
// without trend component, with FE only
xtunitroot ips lco2_c, lags(bic 5) demean
xtunitroot ips lgdp_c, demean lags(bic 5)
xtunitroot ips lgdp_c2, demean lags(bic 5)
xtunitroot ips fossil_fuel_prod_c, demean lags(bic 5)
xtunitroot ips techonology_c, demean lags(bic 5)
// with trend component, with FE only
xtunitroot ips lco2_c, trend demean lags(bic 5)
xtunitroot ips lgdp_c, trend demean lags(bic 5)
xtunitroot ips lgdp_c2, trend demean lags(bic 5)
xtunitroot ips fossil_fuel_prod_c, trend demean lags(bic 5)
xtunitroot ips techonology_c, trend demean lags(bic 5)


// Panel cointegration (KAO) test:
xtcointtest kao lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c


// fit the time-varying model, 7 regions seperately
// local linear method.
// Kernel: Epanechnikov Kernel
// Bandwidth (bw): selected by a data driven rule of thumb bandwidth that corresponds to the Epanechnikov Kernel.


// Central China (C)
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="C", stub(coefsc) alle bootstrap bootoptions(reps(100) seed(28845080)  level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefsc_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="C", fe level(68)
// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// East China (E)
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="E", stub(coefse) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefse_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="E", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// North China
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="N", stub(coefse) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefse_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="N", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// Northeast
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NE", stub(coefse) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefse_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NE", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// Northwest (NW)
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NW", stub(coefse) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefse_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NW", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman


// South China (S)
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="S", stub(coefsw) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefsw_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="S", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// Southwest (SW)
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="SW", stub(coefsw) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
ereturn list
describe coefsw_*

// do the ols and see if the ols estimation result is in the confidence interval
xtreg lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="SW", fe level(68)

// cross sectional dependence test
xtcsd, pesaran abs
xtcsd, friedman



// The following part just aims to show that when switching the bandwidth to be the same as those selected by the R package, the estimated time-varying pattern turn to be more similar to those produced by R. We benefited the well-developed packages in R to implement model diagonostics, and benefit from the smooth curves produced by stata to study the general trend.

// C
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="C", stub(coefsc) bwidth(0.6004) alle bootstrap bootoptions(reps(100) seed(28845080)  level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefsc_*


// E
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="E", stub(coefse) bwidth(1) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefse_*


// N
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="N", stub(coefse) bwidth(0.3017) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefse_*


// NE
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NE", stub(coefse) bwidth(0.25) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefse_*


// NW
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="NW", stub(coefse) bwidth(0.6748) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefse_*


// S
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="S", stub(coefsw) bwidth(1) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefsw_*


// SW
xtnptimevar lco2_c lgdp_c lgdp_c2 fossil_fuel_prod_c techonology_c if Year<2017 & Region=="SW", stub(coefsw) bwidth(0.2728) alle bootstrap bootoptions(reps(100) seed(28845080) level(68)) matsize(800) forcereg title(trend function, lgdp, lgdp2, ff, tech) saving("/Users/yuehenghu/Desktop/RP/Stata_RP/mystatagraphs")
describe coefsw_*







