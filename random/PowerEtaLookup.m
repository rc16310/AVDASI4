function PowerFactor = PowerEtaLookup(mach, alt_ft)     
% Function to determine available thrust (T*V) at mach and alt
        

    surface = [ 0.72027	0.91669	1.06799	1.19447	1.26474	NaN
                0.59157	0.78818	0.96663	1.03568	1.11855	1.20829
                0.48759	0.62661	0.78653	0.88147	1.01707	1.09164
                NaN	0.51364	0.63879	0.73862	0.83045	0.91296
                NaN	0.40437	0.49592	0.56119	0.64209	0.73998
                NaN	0.32394	0.39897	0.47032	0.51800	0.59083
                NaN	0.24501	0.30349	0.34402	0.32553	0.44695];    
    X = 0.2:0.1:0.7;
    Y = 0:5000:30000;
    
    PowerFactor = interp2(X,Y,surface,mach,alt_ft);
    
end
