%% Following Civil Jet Aircraft Design, L.R.Jenkinson, pg 132 - 144
%  Tom Gilbert
%  All SI units

close all; clear all; clc;

%% Payload Group
pssngr_cpcty = 190;    %number of passengers
unt_pssngr_mss = 105;  %mass per passenger
M_PAY = pssngr_cpcty * unt_pssngr_mss;

%% Wing group - Jenkinson - pg 134
% Wing mass estimate
% Values
MTOM = 61100;
NULT = 3.75; % from pg 134
SREF = 122.6; %http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
ARW = [9]; %http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
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
V_D = 230; % guess - hard to tell what units they want?

% Inertia Relief
R = M_W + M_F + ((2*M_eng*B_IE)/(0.4*B)) + ((2*M_eng*B_OE)/(0.4*B));

% Wing mass calculation
M_W_new = 0.021265 * (MTOM * NULT)^0.4843 * SREF^0.7819 * ARW^0.993 * ...
    (1 + TRW)^0.4 * (((1 - (R/MTOM))^0.4) / (WSWEEP * TCW^0.4));

fprintf("Jenkinson's wing mass is %f kg \n", M_W_new)


%% Wing group -  Howe - Pg 157 to 158
C_1 = 0.009;

M_W_HOWE = C_1 .* (ARW.^0.5 .* SREF .* sec((pi/180).*WSWEEP) .* ((1+2.*TRW)/(3+3.*TRW)) ...
    .* (MTOM/SREF) .* (1.65 .* 3.5).^0.3 .* (V_D/TCW).^0.5).^0.9;

fprintf("Howe's wing mass is %f kg \n", M_W_HOWE)

%% Tail group - Jenkinson - pg 135
% Mass can be reduced by 20% if using composite over aluminium
S_H = 12; % Guess
S_V = 12; % Guess
k_H = 25; % pg 135 Civil Jet Aircraft Design
k_V = 28; % pg 135 Civil Jet Aircraft Design

M_H = S_H * k_H;
M_V = S_V * k_V;

M_T = M_H + M_V;

fprintf("Tail mass is %f kg \n", M_T)

%% Body fuselage mass - Jenkinson - pg 136
L_F = 37.57; % http://www.fly-car.de/local/media/formulare/airbusindustries.pdf
D_F = 4; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/

M_B = (0.039 * (L_F * 2 * D_F * V_D^0.5)^1.5) *1.08;

fprintf("Jenkinson's fuselage mass is %f kg \n", M_B)

%% Body fuselage mass - Howe - pg 153
C_2 = 0.83;
p = 0.752 - 0.3;

M_B_HOWE = C_2 * p * (9.75 + (5.84 * B)) * ((2*L_F)/(2 * D_F) - 1.5) * (2 * D_F)^2;
fprintf("Howe's fuselage mass is %f kg \n", M_B_HOWE)

%% Nacelle mass - Jenkinson
T = 115000*2; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
M_N = 6.8*(T/1000);

fprintf("Nacelle mass is %f kg \n", M_N)

%% Landing gear mass - Jenkinson
M_UC = 0.0445 * MTOM;

fprintf("Landing gear mass is %f kg \n", M_UC)

%% Surface controls - Jenkinson
M_SC = 0.4 * MTOM^0.684;

fprintf("Surface controls mass is %f kg \n", M_SC)

%% Total propulsion group mass - Jenkinsons - Pg 139


%% Total mass - Jenkinson
M_TOTAL_JENKS = M_W_HOWE + M_B + M_N + M_UC + M_SC + M_PAY;
fprintf("Total mass for Jenkinson's (adjusted Howe wing) is %f kg \n", M_TOTAL_JENKS)

%% Total mass - Jenkinson
M_TOTAL_HOWE = M_W_HOWE + M_B_HOWE + M_N + M_UC + M_SC; %+ M_PAY;
fprintf("Total mass for Howe's (using remainder Jenkinson's) is %f kg \n", M_TOTAL_HOWE)

%% Plotting
cl = (M_TOTAL_HOWE.*9.81)./((0.5*0.4671*(230^2)*122));
cd = (cl.^2)./(pi*ARW);
SFC = 0.6;

range =  (V_D/9.81) * 1/SFC  * (cl./cd) * log(M_TOTAL_HOWE/(M_TOTAL_HOWE*0.8));

plot(ARW,range)
xlabel('AR')
ylabel('rnage')