%% Omar's mass estimation
clear all; close all; clc;



%% Wing group - Jenkinson - pg 134
% Wing mass estimate
ARW = [8:12]; %http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
TRW = 0.24; % https://booksite.elsevier.com/9780340741528/appendices/data-a/table-1/table.htm
TCW = 0.15; % preliminary investigation (Raymer)
WSWEEP = 25; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
V_D = 230; % guess - hard to tell what units they want?
C_1 = 0.009;
MTOM = 1000000;
MTOM_old = 0;

while abs(MTOM - MTOM_old) > 0.0000001
MTOM_old = MTOM;
SREF = (2*9.81*MTOM)/(1.225*72.02^2*(2.5/1.1^2));

M_W = C_1 .* (ARW.^0.5 .* SREF .* sec((pi/180).*WSWEEP) .* ((1+2.*TRW)/(3+3.*TRW)) ...
    .* (MTOM/SREF) .* (1.65 .* 3.5).^0.3 .* (V_D/TCW).^0.5).^0.9;

%% Total mass
M_TOTAL = M_W + 67000;
MTOM = M_TOTAL;
end

fprintf("Area %f m^2 \n", SREF)
fprintf("Howe's wing mass is %f kg \n", M_W)
fprintf("Total mass is %f kg \n", MTOM)

plot(ARW, MTOM)