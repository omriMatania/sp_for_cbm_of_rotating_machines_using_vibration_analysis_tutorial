function [sa] = calc_sa(sig_cyc, sa_len)
% calc_sa calculates the synchronous average.
% Inputs:
%   sig_cyc - signal in the cycle domain
%   sa_len - synchronous average length (number of points)
% Outputs:
%   sa - the calculated synchronous average
% ----------------------------------------------------------------------- %

num_sgmnts = floor(length(sig_cyc)/sa_len) ;
sig_cyc = sig_cyc(1:num_sgmnts*sa_len) ;
sigs_mtrx = reshape(sig_cyc, sa_len, num_sgmnts) ;

sa = mean(sigs_mtrx, 2) ;

end % of calc_sa
