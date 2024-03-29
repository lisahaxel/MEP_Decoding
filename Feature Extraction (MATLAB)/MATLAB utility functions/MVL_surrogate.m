function [MVL_surr]=MVL_surrogate(Amp,Phase)
% This function generates the surrogate data from given phase and amplitude using block method.
% Input:   Amp: detected amplitude envelope
%          Phase: detected phase envelope
% Output:  MVL_surr: mean surrogate values

% Written by: Tamanna T. K. Munia, January 2019

% These scripts have been optimised for the Windows operating systm  
% MATLAB version used 2018a.

%% Surrogate data calculation
 blocksize=5; % enter requred block size
 L_a= length(Amp) - mod(length(Amp),blocksize);  
 Amp_block= reshape(Amp(1:L_a), blocksize, []); % divide the amp into blocks
  
 L_p= length(Phase) - mod(length(Phase),blocksize);  
 ph_block= reshape(Phase(1:L_p), blocksize, []); % divide the amp into blocks
 
 for surr=1:200   % calculated for 200 times
      random_Phblock=randperm(size(ph_block,1),1); %randomly select phase block number
      ph_surr=ph_block(random_Phblock,:); %extract phase signal for random block
      random_Ampblock=randperm(size(Amp_block,1),1); %randomly select Amp block number
      Amp_ran= Amp_block(random_Ampblock,:); %extract Amp signal for random block
      Amp_sur=Amp_ran(randperm(length(Amp_ran)));
      [M_sur] = calc_MVL(ph_surr, Amp_sur);
       MVL_surra(surr) = M_sur;
  end
    
  MVL_surr=mean(MVL_surra);
    
  function [MVL] = calc_MVL(Phase,Amp)
            z1 = (exp(1i*Phase));
            z=Amp.*(z1);% Get complex valued signal
            MVL = abs((mean(z)));
  end
end
