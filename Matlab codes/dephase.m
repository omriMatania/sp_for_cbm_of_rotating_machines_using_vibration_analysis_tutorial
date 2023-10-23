function sig_t_after_dephase = dephase(t, speed, sig_t, num_of_fllwing_sgmnts_2_average)
% dephase attenuates the interferences of the synchronous signal.
% Inputs:
%   t - time vector
%   speed - speed vector (round per second unit)
%   sig_t - signal in the time domain
%   num_of_fllwing_sgmnts_2_average - number of followind segments to
%   average in the synchronous average
% Outputs:
%   sig_t_after_dephase - signal in the time domain after dephase
% ----------------------------------------------------------------------- %

% angular resampling
[sig_cyc, cyc_fs, sample_pnts] = angular_resampling(t, speed, sig_t) ;


sa_len = cyc_fs ; % number of points in the synchronous average
sgmnt_len = sa_len * num_of_fllwing_sgmnts_2_average ; % length of the averaged segment
sig_cyc_after_dephase = zeros(size(sig_cyc)) ;
for long_sgmnt_num = 1 : ceil(length(sig_cyc) / sgmnt_len)
    
    % separation to segments
    first_ind = (long_sgmnt_num-1) * sgmnt_len + 1 ;
    last_ind = (long_sgmnt_num) * sgmnt_len ;
    if last_ind > length(sig_cyc)
        last_ind = length(sig_cyc) ;
        first_ind = length(sig_cyc) - sgmnt_len + 1 ;
    end % of if
    sgmnt = sig_cyc(first_ind:last_ind) ;
    
    % synchronous average
    sa = calc_sa(sgmnt, sa_len) ;

    % concatenation
    concatenated_sa = repmat(sa, num_of_fllwing_sgmnts_2_average, 1) ;
    
    % subtraction
    subtracted_sgmnt = sig_cyc(first_ind:last_ind) - concatenated_sa ;
    
    % assembly of the segments
    sig_cyc_after_dephase(first_ind:last_ind) = subtracted_sgmnt ;

end % of for


% Convert back from the cycle domain to the time domain
sig_t_after_dephase = interp1(sample_pnts.times_of_constant_phase_intervals, ...
    sig_cyc_after_dephase, sample_pnts.times_of_constant_time_intervals, 'spline') ;

end