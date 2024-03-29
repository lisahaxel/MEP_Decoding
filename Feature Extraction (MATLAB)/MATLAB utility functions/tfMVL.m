function [tf_canolty]=tfMVL(x,high_freq,low_freq, Fs)
% This function computes the phase amplitude coupling using TF-MVL method.
% Input:   x            : input signal 
%          high_freq    : Amplitude Frequency range 
%          low_freq     : Phase Frequency range 
%          Fs           : Sampling Frequency  
% Output:  tf_canolty   : Computed PAC using TF-MVL method
%          MVL_surr     : mean surrogate values for TF-MVL method

% Written by: Tamanna T. K. Munia, January 2019
% Please cite: Munia, Tamanna TK, and Selin Aviyente. "time-frequency Based phase-Amplitude 
% coupling Measure for neuronal oscillations." Scientific reports 9, no. 1 (2019): 1-15.

% These scripts have been optimised for the Windows operating systm  
% MATLAB version used 2018a.


%% Amplitude and Phase calculation
[tfd]=rid_rihaczek4(x,Fs);
W=tfd;
W2=W(2:end,:);

tfd_low=W2(low_freq:low_freq,:);
angle_low=angle(tfd_low);
Amp=(W2(high_freq:high_freq,:));
Phase=((angle_low));
tf_canolty_r=(calc_MVL(Phase,Amp));
% 
% [MVL_surr]= MVL_surrogate(Amp,Phase);
% 
% tf_canolty_r(tf_canolty_r<MVL_surr)=0;
tf_canolty=tf_canolty_r;

function [MVL] = calc_MVL(Phase,Amp)
         z1=(exp(1i*Phase));
         z=Amp.*(z1);% Generate complex valued signal
         MVL = abs((mean(z)));
end

end
