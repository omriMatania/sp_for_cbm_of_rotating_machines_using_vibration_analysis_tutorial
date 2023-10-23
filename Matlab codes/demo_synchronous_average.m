% Demonstration of synchronous average

clear all; close all;


% load data
load('D:\data\work_with_Eric\Signal processing for CBM - a tutorial\demo_synchronous_average.mat')


% synchronous average
sa = calc_sa(sig_cyc, num_pnts_sa_gear) ;


% SNR improvment curve
snr_vctr = zeros(length(sig_cyc)/num_pnts_sa_gear, 1) ;
for num_average_sgmnts = 1 : length(sig_cyc)/num_pnts_sa_gear
    short_sig_cyc = sig_cyc(1 : num_average_sgmnts*num_pnts_sa_gear) ;
    short_sa = calc_sa(short_sig_cyc, num_pnts_sa_gear) ;
    snr = rms(sig_gear)/rms(sig_gear-short_sa) ;
    snr_vctr(num_average_sgmnts) = snr ;
end


% ----------------------------------------------------------------------- %
% Part for figures
dcyc = 1 / num_pnts_sa_gear ; % cycle resolution 
len_cyc = length(sig_cyc) ; % cycle vector length
cyc = [0 : dcyc : (length(sig_cyc)-1)*dcyc].' ; % cycle vector
cyc_sa = [0 : dcyc : (num_pnts_sa_gear-1)*dcyc].' ; % cycle vector of the synchronous average

axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 25 ;
lgnd_font_size = 15 ;

figure
subplot(2, 1, 1)
plot(cyc, sig_cyc, 'LineWidth', 1) ;
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the cycle domain', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Number of rounds', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
xlim([0 cyc(end)])
subplot(2, 1, 2)
plot(cyc(1:num_pnts_sa_gear), sig_cyc(1:num_pnts_sa_gear), 'LineWidth', 1) ;
hold on
plot(cyc(1:num_pnts_sa_gear), sig_gear, 'LineWidth', 1) ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('First round', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Number of rounds', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Measured signal', 'Original gear signal', 'FontName', ...
    'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest') ;
xlim([0 1])

figure
plot(cyc_sa, sa, 'LineWidth', 1) ;
hold on
plot(cyc_sa, sig_gear, 'LineWidth', 1) ;
hold off
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the cycle domain', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Number of rounds', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Calculated synchronous average', 'Original gear signal', 'FontName', ...
    'Times New Roman', 'FontSize', lgnd_font_size, 'location', 'northwest') ;

figure
plot(snr_vctr, 'LineWidth', 3) ;
ax = gca;
ax.FontSize = axis_font_size;
title('SNR improvment curve', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Number of average segments', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('SNR', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
xValues = [18, 36, 54, 72, 90];
line([xValues; xValues], ylim, 'Color', [0.5 0.5 0.5], 'LineStyle', '--');
