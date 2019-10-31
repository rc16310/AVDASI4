%% root moment
b = 45.4; % span
W_fus = 25000*9.81; % fuselage weight
N = 2.5; % load factor
lambda = 0.45; % taper ratio

M0 = N*W_fus*(b/12)*((1+2*lambda)/(1+lambda)) % in N/m

m = M0-(N*3007*9.81*8)
