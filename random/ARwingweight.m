AR_range = 10:1:30;

WingMass = 37.7*AR.^2 - 543.5.*AR + 7660;
plot(AR,WingMass);
AR = [18,16,14,12];
WingMass = [10105,8637,7441,6577];
p = polyfit(AR,WingMass,2)
plot(AR,WingMass)%,AR_range,polyval(p,AR_range))