% Demonstration of gear diagnosis

clear all; close all;


% load data
load('D:\data\papers\Signal processing for CBM - a tutorial\demo_gear_diagnosis.mat')


% processing of the healthy signals
num_healthy_sigs = size(sigs_healthy_t, 2) ; % number of healthy signals
healthy_features = zeros(4, num_healthy_sigs) ; % pre-allocation for the healthy features
for sig_num = 1 : num_healthy_sigs
    
    sig_healthy = sigs_healthy_t(:, sig_num) ; % signal in the time domain
    speed_faulty_t = speed_healthy(:, sig_num) ; % speed vector in the time domain
    t = [0 : dt : (length(sig_healthy)-1)*dt].' ; % time vector

    % angular resampling
    [sig_cyc, cyc_fs] = angular_resampling(t, speed_faulty_t, sig_healthy) ;
    num_pnts_in_round = cyc_fs ;

    % synchronous average
    sa = calc_sa(sig_cyc, num_pnts_in_round) ;

    % difference signal
    gear_mesh = 38; num_sidebands = 2 ;
    difference_sig = calc_difference_signal(sa, gear_mesh, num_sidebands) ;

    % features extraction 
    sa_rms = rms(sa) ;
    sa_kurtosis = kurtosis(sa) ;
    difference_rms = rms(difference_sig) ;
    difference_skewness = skewness(difference_sig) ;
    sig_features = [sa_rms, sa_kurtosis, difference_rms, difference_skewness].' ;
    healthy_features(:, sig_num) = sig_features ;

end % of for

% average and standard deviation of the healthy features 
healthy_features_average = mean(healthy_features, 2) ;
healthy_features_std = std(healthy_features.').' ;

healthy_hi_vctr = zeros(num_healthy_sigs, 1) ; % health indicator of the healthy signals
for sig_num = 1 : num_healthy_sigs
    
    % HI calculation
    hi = mean(abs(healthy_features(:, sig_num) - healthy_features_average)./healthy_features_std) ;
    healthy_hi_vctr(sig_num) = hi ;

end % of for


% processing of the faulty signals
num_faulty_sigs = size(sigs_faulty_t, 2) ; % number of faulty signals
hi_faulty_vctr = zeros(num_faulty_sigs, 1) ; % pre-allocation for the HI of the faulty signals
for sig_num = 1 : num_faulty_sigs
    
    sig_faulty_t = sigs_faulty_t(:, sig_num) ; % signal in the time domain
    speed_faulty_t = speed_faulty(:, sig_num) ; % speed vector in the time domain
    t = [0 : dt : (length(sig_faulty_t)-1)*dt].' ; % time vector

    % angular resampling
    [sig_cyc, cyc_fs] = angular_resampling(t, speed_faulty_t, sig_faulty_t) ;
    num_pnts_in_round = cyc_fs ;

    % synchronous average
    sa = calc_sa(sig_cyc, num_pnts_in_round) ;

    % difference signal
    gear_mesh = 38; num_sidebands = 2 ;
    difference_sig = calc_difference_signal(sa, gear_mesh, num_sidebands) ;

    % features extraction 
    sa_rms = rms(sa) ;
    sa_kurtosis = kurtosis(sa) ;
    difference_rms = rms(difference_sig) ;
    difference_skewness = skewness(difference_sig) ;
    sig_features = [sa_rms, sa_kurtosis, difference_rms, difference_skewness].' ;

    % HI calculation
    hi = mean(abs(sig_features - healthy_features_average)./healthy_features_std) ;
    hi_faulty_vctr(sig_num) = hi ;

end % of for


% ----------------------------------------------------------------------- %
% Part for figures

axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 25 ;
lgnd_font_size = 20 ;

figure
plot([1:num_healthy_sigs], healthy_hi_vctr, 'LineWidth', 3, 'Color', 'g') ;
hold on
plot([num_healthy_sigs+1:num_healthy_sigs+num_faulty_sigs], hi_faulty_vctr, 'LineWidth', 3, 'Color', 'r') ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Health indicator of the healthy and faulty signals', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Record number', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('HI value', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Healthy records', 'Faulty records', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest');