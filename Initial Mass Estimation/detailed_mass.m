%% Following Civil Jet Aircraft Design, L.R.Jenkinson, pg 132 - 144
%  Tom Gilbert
%  All SI units

close all; clear all; clc;

%% Wing group - pg 134
% Wing mass estimate
% Values
MTOM = 61100;
NULT = 3.75; % from pg 134
SREF = 122.6; %http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
ARW = (34.1^2)/SREF; %http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
TRW = 0.24; % https://booksite.elsevier.com/9780340741528/appendices/data-a/table-1/table.htm
TCW = 0.15; % preliminary investigation (Raymer)
WSWEEP = 25; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/

M_W = 274.32; % guess
M_F = 12000; %0.19 of inital mass
M_PAY = 190 * 105; % passenger capacity * mass per passenger
M_OE = 29544; % 61103.818616 - 1.1610e+04 - (190*105), initial mass - 0.19 fuel frac - payload
M_eng = 5845/2; % cell F15 on Richard's "Estimated propulsion data"
B_IE = 11.51; %http://www.fly-car.de/local/media/formulare/airbusindustries.pdf pg 3
B_OE = 0;
B = 34.1; %http://www.fly-car.de/local/media/formulare/airbusindustries.pdf pg 3

% Inertia Relief
R = M_W + M_F + ((2*M_eng*B_IE)/(0.4*B)) + ((2*M_eng*B_OE)/(0.4*B));

% Wing mass calculation
M_W_new = 0.021265 * (MTOM * NULT)^0.4843 * SREF^0.7819 * ARW^0.993 * ...
    (1 + TRW)^0.4 * (((1 - (R/MTOM))^0.4) / (WSWEEP * TCW^0.4));

fprintf("Wing mass is %f kg \n", M_W_new)

%% Tail group - pg 135
% Mass can be reduced by 20% if using composite over aluminium
S_H = 12; % Guess
S_V = 12; % Guess
k_H = 25; % pg 135 Civil Jet Aircraft Design
k_V = 28; % pg 135 Civil Jet Aircraft Design

M_H = S_H * k_H;
M_V = S_V * k_V;

M_T = M_H + M_V;

fprintf("Tail mass is %f kg \n", M_T)

%% Body fuselage mass - pg 136
L_F = 37.57; % http://www.fly-car.de/local/media/formulare/airbusindustries.pdf
D_F = 4; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
V_D = 230; % guess - hard to tell what units they want?

M_B = (0.039 * (L_F * 2 * D_F * V_D^0.5)^1.5) *1.08;

fprintf("Fuselage mass is %f kg \n", M_B)

%% Nacelle mass
T = 115000*2; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
M_N = 6.8*(T/1000);

fprintf("Nacelle mass is %f kg \n", M_N)

%% Landing gear mass
M_UC = 0.0445 * MTOM;

fprintf("Landing gear mass is %f kg \n", M_UC)

%% Surface controls
M_SC = 0.4 * MTOM^0.684;

fprintf("Surface controls mass is %f kg \n", M_SC)