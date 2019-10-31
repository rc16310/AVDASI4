%% Following Civil Jet Aircraft Design, L.R.Jenkinson, pg 129
%  Tom Gilbert
%  All SI units

close all; clear all;

%% Constants
g = 9.81;

%% Variable sourced from Airbus spec
passenger_capacity = 190;    %number of passengers
unit_passenger_mass = 105;  %mass per passenger


%% A320 Specs - http://www.flugzeuginfo.net/acdata_php/acdata_a320_en.php
M_a320_E = 37230;
M_a320_TO = 77000;

%% A320 economy passenger count - http://theflight.info/seat-map-airbus-a320-easyjet-best-seats-in-the-plane/
passenger_capacity_a320 = 186;

%% A320 fuel mass
M_a320_F = M_a320_TO - M_a320_E - (passenger_capacity_a320 * unit_passenger_mass);
A320EmptyOverMTOW = M_a320_E/M_a320_TO+0.1

%% Completely guessed values
range = 1000 * 1852;
LoverD = 15;
SFC = 0.6;
flight_velocity = 230;  

%% Fuel fraction

M_FoverM_TO = SFC * 1/LoverD * range/flight_velocity/60^2;

%range_est = flight_velocity/g * LoverD/SFC * log(massRatio)


%% Useful mass
M_UL = passenger_capacity * unit_passenger_mass * 1.1 ;

%% Maximum take-off weight
M_TO = M_UL / (1 - A320EmptyOverMTOW - M_FoverM_TO);

%% Output result
fprintf("The maximum take-off mass is %f kg\n", M_TO)
