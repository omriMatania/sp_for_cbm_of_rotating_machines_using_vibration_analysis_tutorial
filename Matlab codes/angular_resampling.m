function [sig_cyc, cyc_fs, sample_pnts] = angular_resampling(t, speed, sig_t)
% Angular resampling convert the signal from the time domain to the cycle
% domain.
% Inputs:
%   t - time axis
%   speed - speed vector (round per second unit)
%   sig_t - signal in the time domain
% Outputs:
%   sig_cyc - signal in the cycle domain
%   cyc_fs - frequency sample in the cycle domain
%   sample_pnts - sample points for optional resampling back from the cycle domain to the time domain
% ----------------------------------------------------------------------- %

dt = t(2) - t(1) ; % time resolution
cumulative_phase = cumsum(speed*dt) ; % cumulative phase of the shaft.
cumulative_phase = cumulative_phase - cumulative_phase(1) ;

cyc_fs = ceil(1/dt/min(speed)) ; % sampling rate in the cycle domain after angular resampling.

constant_phase_intervals = linspace(0, max(cumulative_phase), round(cyc_fs*max(cumulative_phase)))' ; % cumulative phase with constant intervals.
times_of_constant_phase_intervals = interp1(cumulative_phase, t, constant_phase_intervals, 'linear') ; % new time points with constant phase intervals between them.

sig_cyc = interp1(t, sig_t, times_of_constant_phase_intervals, 'spline') ;

% sample points for optional resampling back from the cycle domain to the time domain
sample_pnts.times_of_constant_time_intervals = t ;
sample_pnts.times_of_constant_phase_intervals = times_of_constant_phase_intervals ;

end % of angular_resampling

