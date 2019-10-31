% input
x = 5089; %xWingLoading(262);

y = 0.05249; %Line3y(262);

% calcs
MTOW = 61209;
No_of_engines = MTOW*9.81/4.847e6/y;
Scaling = No_of_engines/2; 

Wing_area = MTOW*9.81/x; %[-]
AR = 17.5; %[-]
Wingspan = sqrt(Wing_area*AR); %[-]
Av_chord = sqrt(Wing_area/AR); %[-]
Taper_Ratio = 0.45; %[-]
Centerline_chord = 2*Wing_area/Wingspan/(1+Taper_Ratio); %[-]
Tip_chord = 2*Wing_area/Wingspan/(1+Taper_Ratio)*Taper_Ratio; %[-]


%%
 afdata = [%NACA 23012 Airfoil cl=0.30 T=12.0% P=15.0%
  1.000028  0.001260
  0.990059  0.002875
  0.980089  0.004473
  0.970119  0.006054
  0.960149  0.007619
  0.950178  0.009168
  0.940207  0.010701
  0.930236  0.012219
  0.920264  0.013721
  0.910292  0.015209
  0.900320  0.016682
  0.890347  0.018141
  0.880374  0.019585
  0.870401  0.021015
  0.860427  0.022431
  0.850453  0.023833
  0.840479  0.025222
  0.830504  0.026597
  0.820530  0.027959
  0.810555  0.029307
  0.800579  0.030642
  0.790603  0.031963
  0.780627  0.033271
  0.770651  0.034566
  0.760675  0.035848
  0.750698  0.037116
  0.740721  0.038371
  0.730743  0.039613
  0.720765  0.040841
  0.710787  0.042055
  0.700809  0.043255
  0.690830  0.044442
  0.680851  0.045614
  0.670872  0.046772
  0.660892  0.047916
  0.650912  0.049044
  0.640932  0.050158
  0.630951  0.051256
  0.620971  0.052339
  0.610989  0.053406
  0.601008  0.054456
  0.591025  0.055490
  0.581043  0.056507
  0.571060  0.057506
  0.561077  0.058487
  0.551093  0.059450
  0.541109  0.060394
  0.531125  0.061318
  0.521140  0.062223
  0.511155  0.063107
  0.501169  0.063969
  0.491183  0.064810
  0.481196  0.065628
  0.471208  0.066423
  0.461221  0.067194
  0.451232  0.067940
  0.441243  0.068660
  0.431254  0.069354
  0.421263  0.070020
  0.411273  0.070658
  0.401281  0.071266
  0.391289  0.071844
  0.381296  0.072390
  0.371303  0.072903
  0.361308  0.073383
  0.351313  0.073826
  0.341317  0.074233
  0.331321  0.074602
  0.321323  0.074930
  0.311325  0.075217
  0.301325  0.075461
  0.291325  0.075660
  0.281323  0.075812
  0.271320  0.075914
  0.261317  0.075964
  0.251312  0.075961
  0.241306  0.075900
  0.231298  0.075780
  0.221289  0.075597
  0.211279  0.075348
  0.201264  0.075029
  0.191182  0.074631
  0.181012  0.074136
  0.170755  0.073521
  0.160418  0.072763
  0.150005  0.071838
  0.139524  0.070720
  0.128984  0.069383
  0.118394  0.067796
  0.107766  0.065930
  0.097114  0.063750
  0.086457  0.061220
  0.075814  0.058297
  0.065212  0.054933
  0.054682  0.051069
  0.044265  0.046629
  0.034018  0.041507
  0.024021  0.035535
  0.014414  0.028404
  0.005504  0.019325
  0.000000  0.000000
  0.014496 -0.013541
  0.025586 -0.017450
  0.035979 -0.019995
  0.045982 -0.021930
  0.055735 -0.023534
  0.065318 -0.024942
  0.074788 -0.026230
  0.084186 -0.027440
  0.093543 -0.028600
  0.102886 -0.029727
  0.112234 -0.030831
  0.121606 -0.031915
  0.131016 -0.032984
  0.140476 -0.034035
  0.149995 -0.035065
  0.159582 -0.036070
  0.169245 -0.037044
  0.178988 -0.037979
  0.188818 -0.038865
  0.198736 -0.039694
  0.208721 -0.040456
  0.218711 -0.041147
  0.228702 -0.041771
  0.238694 -0.042333
  0.248688 -0.042835
  0.258683 -0.043280
  0.268680 -0.043671
  0.278677 -0.044011
  0.288675 -0.044301
  0.298675 -0.044544
  0.308675 -0.044742
  0.318677 -0.044896
  0.328679 -0.045009
  0.338683 -0.045082
  0.348687 -0.045117
  0.358692 -0.045115
  0.368697 -0.045078
  0.378704 -0.045006
  0.388711 -0.044902
  0.398719 -0.044766
  0.408727 -0.044599
  0.418737 -0.044403
  0.428746 -0.044178
  0.438757 -0.043926
  0.448768 -0.043648
  0.458779 -0.043343
  0.468792 -0.043014
  0.478804 -0.042661
  0.488817 -0.042284
  0.498831 -0.041885
  0.508845 -0.041464
  0.518860 -0.041022
  0.528875 -0.040560
  0.538891 -0.040077
  0.548907 -0.039574
  0.558923 -0.039053
  0.568940 -0.038514
  0.578957 -0.037956
  0.588975 -0.037381
  0.598992 -0.036789
  0.609011 -0.036180
  0.619029 -0.035555
  0.629049 -0.034914
  0.639068 -0.034258
  0.649088 -0.033586
  0.659108 -0.032899
  0.669128 -0.032197
  0.679149 -0.031480
  0.689170 -0.030750
  0.699191 -0.030005
  0.709213 -0.029246
  0.719235 -0.028474
  0.729257 -0.027687
  0.739279 -0.026888
  0.749302 -0.026074
  0.759325 -0.025248
  0.769349 -0.024408
  0.779373 -0.023554
  0.789397 -0.022688
  0.799421 -0.021808
  0.809445 -0.020915
  0.819470 -0.020008
  0.829496 -0.019088
  0.839521 -0.018155
  0.849547 -0.017208
  0.859573 -0.016247
  0.869599 -0.015273
  0.879626 -0.014285
  0.889653 -0.013282
  0.899680 -0.012265
  0.909708 -0.011234
  0.919736 -0.010188
  0.929764 -0.009127
  0.939793 -0.008051
  0.949822 -0.006959
  0.959851 -0.005852
  0.969881 -0.004729
  0.979911 -0.003589
  0.989941 -0.002433
  0.999972 -0.001260 ];
naca_midpt = 101;
naca_end = 201; 

[~,naca_top_15] = min(abs(afdata(1:naca_midpt,1)-0.15));
[~,naca_top_65] = min(abs(afdata(1:naca_midpt,1)-0.65));
[~,naca_bot_15] = min(abs(afdata(naca_midpt:naca_end,1)-0.15));
[~,naca_bot_65] = min(abs(afdata(naca_midpt:naca_end,1)-0.65));
naca_bot_15 = naca_bot_15 + naca_midpt - 1;
naca_bot_65 = naca_bot_65 + naca_midpt - 1;

normalised_sparspace =  -trapz(afdata(naca_top_65:naca_top_15,1),afdata(naca_top_65:naca_top_15,2))...
- trapz(afdata(naca_bot_15:naca_bot_65,1),afdata(naca_bot_15:naca_bot_65,2)); %[-]






Wing_volume = normalised_sparspace*Av_chord*(Tip_chord+Centerline_chord)/2*Wingspan;

%%
disp(['Power Loading = ' num2str(y) 'N/W'])
disp(['No of engines = ' num2str(No_of_engines)])
disp(['Scaling for 2 engines = ' num2str(Scaling)]) 

disp(['Wing area = ' num2str(Wing_area) 'm^2'])
disp(['Aspect Ratio = ' num2str(AR)])
disp(['Wingspan = ' num2str(Wingspan) 'm'])
disp(['Wing average chord = ' num2str(Av_chord) 'm'])
disp(['Wing root chord (at centerline) = ' num2str(Centerline_chord) 'm'])
disp(['Wing tip chord = ' num2str(Tip_chord) 'm'])
disp(['Wing volume = ' num2str(Wing_volume) 'm^3'])

disp(['Max mass of fuel in wing = ' num2str(Wing_volume*0.8) ' Mg'])