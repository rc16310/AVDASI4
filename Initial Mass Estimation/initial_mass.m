%% Following Civil Jet Aircraft Design, L.R.Jenkinson, pg 129 - 132
%  Tom Gilbert
%  All SI units

close all; clear all; clc;

%% Constants
g = 9.81;

%% Variable sourced from Airbus spec
pssngr_cpcty = 190;    %number of passengers
unt_pssngr_mss = 105;  %mass per passenger
rnge = 1000 * 1852;

%% A320 Specs - http://www.flugzeuginfo.net/acdata_php/acdata_a320_en.php
M_a320_E = 37230;
M_a320_TO = 77000;

%% A320 economy passenger count - http://theflight.info/seat-map-airbus-a320-easyjet-best-seats-in-the-plane/
pssngr_cpcty_a320 = 186;

%% A320 fuel mass
M_a320_F = M_a320_TO - M_a320_E - (pssngr_cpcty_a320 * unt_pssngr_mss);

%% Completely guessed values
LovrD = 17;
SFC = 0.6;
flght_vlcty = 230; 

%% Fuel fraction
% From Civil Jet Aircraft Design, pg 131
M_FovrM_TO = SFC * (1/LovrD) * ((rnge/flght_vlcty)/60^2);

% Wei's fuel fraction
M_FovrM_TO = 0.19;

%% Useful mass
M_UL = pssngr_cpcty * unt_pssngr_mss;

%% Maximum take-off weight
M_TO = M_UL / (1- (M_a320_E/M_a320_TO) - M_FovrM_TO);

%% Output result
fprintf("The maximum take-off mass is %f kg\n", M_TO)
