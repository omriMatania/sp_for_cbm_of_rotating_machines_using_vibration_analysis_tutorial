% Demonstration of bearing diagnosis with an outer race fault

clear all; close all;


% load data
load('D:\data\work_with_Eric\Signal processing for CBM - a tutorial\demo_bearing_diagnosis.mat')


% processing of the healthy signals
num_healthy_sigs = size(sigs_healthy_t, 2) ; % number of healthy signals
% pre-allocation
healthy_ftf_values = zeros(num_healthy_sigs, 1) ; hi_ftf_healthy_vctr = zeros(num_healthy_sigs, 1) ;
healthy_bsf_values = zeros(num_healthy_sigs, 1) ; hi_bsf_healthy_vctr = zeros(num_healthy_sigs, 1) ;
healthy_bpfo_values = zeros(num_healthy_sigs, 1) ; hi_bpfo_healthy_vctr = zeros(num_healthy_sigs, 1) ;
healthy_bpfi_values = zeros(num_healthy_sigs, 1) ; hi_bpfi_healthy_vctr = zeros(num_healthy_sigs, 1) ;
for sig_num = 1 : num_healthy_sigs
    
    sig_healthy_t = sigs_healthy_t(:, sig_num) ; % signal in the time domain
    speed_healthy_gear_t = speed_healthy_gear(:, sig_num) ; % speed vector of the gear
    speed_healthy_bearing_t = speed_healthy_bearing(:, sig_num) ;  % speed vector of the bearing
    t = [0 : dt : (length(sig_healthy_t)-1)*dt].' ; % time vector
    
    % dephase
    num_of_fllwing_sgmnts_2_average = 20 ;
    sig_after_dephase = dephase(t, speed_healthy_gear_t, sig_healthy_t, num_of_fllwing_sgmnts_2_average) ;

    % angular resampling
    [sig_cyc, cyc_fs] = angular_resampling(t, speed_healthy_bearing_t, sig_after_dephase) ;
    dcyc = 1 / cyc_fs ;
    
    % envelope calculation
    sig_env_cyc = abs(hilbert(sig_cyc).^2) ;

    % convert envelope from the cycle domain to the order domain
    sig_env_order = fft(sig_env_cyc) ;
    dorder = 1 / (length(sig_env_cyc)*dcyc) ;

    % features extraction
    shaft_speed = 1 ; % in the cycle domain the shaft speed is 1.
    [ftf, bsf, bpfo, bpfi] = calc_bearing_tones(shaft_speed, bearing_specifications.num_balls, ...
    bearing_specifications.ball_diameter, bearing_specifications.pitch_diameter, bearing_specifications.bearing_contact_angle) ;
    bearing_tones = [ftf, bsf, bpfo, bpfi] ;
    
    order_sensativity = 0.02 ; % sensitivity of the order value for searching the bearing tone pick
    first_ftf_value = extract_specific_bearing_tone(dorder, sig_env_order, ftf, order_sensativity) ;
    first_bsf_value = extract_specific_bearing_tone(dorder, sig_env_order, bsf, order_sensativity) ;
    first_bpfo_value = extract_specific_bearing_tone(dorder, sig_env_order, bpfo, order_sensativity) ;
    first_bpfi_value = extract_specific_bearing_tone(dorder, sig_env_order, bpfi, order_sensativity) ;
    
    healthy_ftf_values(sig_num) = first_ftf_value ;
    healthy_bsf_values(sig_num) = first_bsf_value ;
    healthy_bpfo_values(sig_num) = first_bpfo_value ;
    healthy_bpfi_values(sig_num) = first_bpfi_value ;

end % of for

healthy_ftf_average = mean(healthy_ftf_values) ; healthy_ftf_std = std(healthy_ftf_values) ;
healthy_bsf_average = mean(healthy_bsf_values) ; healthy_bsf_std = std(healthy_bsf_values) ;
healthy_bpfo_average = mean(healthy_bpfo_values) ; healthy_bpfo_std = std(healthy_bpfo_values) ;
healthy_bpfi_average = mean(healthy_bpfi_values) ; healthy_bpfi_std = std(healthy_bpfi_values) ;

for sig_num = 1 : num_healthy_sigs
    
    % HI calculation
    hi_ftf = mean(abs(healthy_ftf_values(sig_num) - healthy_ftf_average)./healthy_ftf_std) ;
    hi_ftf_healthy_vctr(sig_num) = hi_ftf ;
    hi_bsf = mean(abs(healthy_bsf_values(sig_num) - healthy_bsf_average)./healthy_bsf_std) ;
    hi_bsf_healthy_vctr(sig_num) = hi_bsf ;
    hi_bpfo = mean(abs(healthy_bpfo_values(sig_num) - healthy_bpfo_average)./healthy_bpfo_std) ;
    hi_bpfo_healthy_vctr(sig_num) = hi_bpfo ;
    hi_bpfi = mean(abs(healthy_bpfi_values(sig_num) - healthy_bpfi_average)./healthy_bpfi_std) ;
    hi_bpfi_healthy_vctr(sig_num) = hi_bpfi ;

end % of for

% processing of the faulty signals
num_faulty_sigs = size(sigs_faulty_t, 2) ;
hi_ftf_faulty_vctr = zeros(num_faulty_sigs, 1) ;
hi_bsf_faulty_vctr = zeros(num_faulty_sigs, 1) ;
hi_bpfo_faulty_vctr = zeros(num_faulty_sigs, 1) ;
hi_bpfi_faulty_vctr = zeros(num_faulty_sigs, 1) ;
for sig_num = 1 : num_faulty_sigs
    
    sig_faulty_t = sigs_faulty_t(:, sig_num) ; % signal in the time domain
    speed_faulty_gear_t = speed_faulty_gear(:, sig_num) ; % speed vector of the gear
    speed_faulty_bearing_t = speed_faulty_bearing(:, sig_num) ; % speed vector of the bearing
    t = [0 : dt : (length(sig_faulty_t)-1)*dt].' ; % time vector
    
    % dephase
    num_of_fllwing_sgmnts_2_average = 20 ;
    sig_after_dephase = dephase(t, speed_faulty_gear_t, sig_faulty_t, num_of_fllwing_sgmnts_2_average) ;

    % angular resampling
    [sig_cyc, cyc_fs] = angular_resampling(t, speed_faulty_bearing_t, sig_after_dephase) ;
    dcyc = 1 / cyc_fs ;
    
    % envelope calculation
    sig_env_cyc = abs(hilbert(sig_cyc).^2) ;

    % convert envelope from the cycle domain to the order domain
    sig_env_order = fft(sig_env_cyc) ;
    dorder = 1 / (length(sig_env_cyc)*dcyc) ;

    % features extraction
    shaft_speed = 1 ; % in the cycle domain the shaft speed is 1.
    [ftf, bsf, bpfo, bpfi] = calc_bearing_tones(shaft_speed, bearing_specifications.num_balls, ...
    bearing_specifications.ball_diameter, bearing_specifications.pitch_diameter, bearing_specifications.bearing_contact_angle) ;
    bearing_tones = [ftf, bsf, bpfo, bpfi] ;
    
    order_sensativity = 0.02 ; % sensitivity of the order value for searching the bearing tone pick
    first_ftf_value = extract_specific_bearing_tone(dorder, sig_env_order, ftf, order_sensativity) ;
    first_bsf_value = extract_specific_bearing_tone(dorder, sig_env_order, bsf, order_sensativity) ;
    first_bpfo_value = extract_specific_bearing_tone(dorder, sig_env_order, bpfo, order_sensativity) ;
    first_bpfi_value = extract_specific_bearing_tone(dorder, sig_env_order, bpfi, order_sensativity) ;

    % HI calculation
    hi_ftf = mean(abs(first_ftf_value - healthy_ftf_average)./healthy_ftf_std) ;
    hi_ftf_faulty_vctr(sig_num) = hi_ftf ;
    hi_bsf = mean(abs(first_bsf_value - healthy_bsf_average)./healthy_bsf_std) ;
    hi_bsf_faulty_vctr(sig_num) = hi_bsf ;
    hi_bpfo = mean(abs(first_bpfo_value - healthy_bpfo_average)./healthy_bpfo_std) ;
    hi_bpfo_faulty_vctr(sig_num) = hi_bpfo ;
    hi_bpfi = mean(abs(first_bpfi_value - healthy_bpfi_average)./healthy_bpfi_std) ;
    hi_bpfi_faulty_vctr(sig_num) = hi_bpfi ;

end % of for


% ----------------------------------------------------------------------- %
% Part for figures

axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 25 ;
lgnd_font_size = 20 ;

figure
plot([1:num_healthy_sigs], hi_ftf_healthy_vctr, 'LineWidth', 3, 'Color', 'g') ;
hold on
plot([num_healthy_sigs+1:num_healthy_sigs+num_faulty_sigs], hi_ftf_faulty_vctr, 'LineWidth', 3, 'Color', [0.7 0.7 0.7]) ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Health indicator of the cage', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Record number', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('HI value', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Healthy records', 'Faulty records', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest');

figure
plot([1:num_healthy_sigs], hi_bsf_healthy_vctr, 'LineWidth', 3, 'Color', 'g') ;
hold on
plot([num_healthy_sigs+1:num_healthy_sigs+num_faulty_sigs], hi_bsf_faulty_vctr, 'LineWidth', 3, 'Color', [0.7 0.7 0.7]) ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Health indicator of the rolling elements', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Record number', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('HI value', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Healthy records', 'Faulty records', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest');

figure
plot([1:num_healthy_sigs], hi_bpfo_healthy_vctr, 'LineWidth', 3, 'Color', 'g') ;
hold on
plot([num_healthy_sigs+1:num_healthy_sigs+num_faulty_sigs], hi_bpfo_faulty_vctr, 'LineWidth', 3, 'Color', 'r') ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Health indicator of the outer race', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Record number', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('HI value', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Healthy records', 'Faulty records', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest');

figure
plot([1:num_healthy_sigs],hi_bpfi_healthy_vctr, 'LineWidth', 3, 'Color', 'g') ;
hold on
plot([num_healthy_sigs+1:num_healthy_sigs+num_faulty_sigs], hi_bpfi_faulty_vctr, 'LineWidth', 3, 'Color', [0.7 0.7 0.7]) ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Health indicator of the inner race', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Record number', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('HI value', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Healthy records', 'Faulty records', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest');