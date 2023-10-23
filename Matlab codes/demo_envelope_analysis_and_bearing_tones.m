% Demonstration of envelope analysis and bearing tones calculation

clear all; close all ;


% load data
load('D:\data\work_with_Eric\Signal processing for CBM - a tutorial\demo_envelope_analysis_and_bearing_tones.mat')


% envelope calculation using hilbert transform
sig_env = abs(hilbert(sig_cyc).^2) ;


% bearing tones calculation
shaft_speed = 1 ; % In the cycle domain the shaft speed is 1.
[ftf, bsf, bpfo, bpfi] = calc_bearing_tones(shaft_speed, bearing_specifications.num_balls, ...
    bearing_specifications.ball_diameter, bearing_specifications.pitch_diameter, bearing_specifications.bearing_contact_angle) ;
bearing_tones = [ftf, bsf, bpfo, bpfi] ;


% ----------------------------------------------------------------------- %
% Part for figures
sig_env_order = abs(fft(sig_env)) ; % envelope in the order domain
sig_len = length(sig_cyc) ; % length of the signal
cyc = [0 : dcyc : (sig_len-1)*dcyc].' ; % cycle vector
dorder = 1 / (sig_len*dcyc) ; % order resolution
order = [0 : dorder : (sig_len-1)*dorder].' ; % order vector

axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 25 ;
lgnd_font_size = 20 ;

figure
hold on
[plt_info] = plot_bearing_tones_lines(bearing_tones) ;
h = plot(order, sig_env_order / length(sig_env_order), 'LineWidth', 2, 'Color', 'black') ;
hold off
legend([plt_info{1}, plt_info{31}, plt_info{61}, plt_info{91}, h], {'FTF', 'BSF', 'BPFO', 'BPFI', 'Signal'}, ...
    'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'Location', 'northwest');
xlim([0 10])
max_ind = round(10/dorder) ;
ylim([0 1.5*max(sig_env_order(2:max_ind)/length(sig_env_order))])
ax = gca;
ax.FontSize = axis_font_size;
title('Outer race spall', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Order', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)