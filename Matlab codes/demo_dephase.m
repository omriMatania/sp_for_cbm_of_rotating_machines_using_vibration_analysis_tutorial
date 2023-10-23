% Demonstration of dephase

clear all; close all;


% load data
load('D:\data\work_with_Eric\Signal processing for CBM - a tutorial\demo_dephase.mat')


% Dephase
num_of_fllwing_sgmnts_2_average = 10 ;
t = [0 : dt : (length(sig_t)-1)*dt].' ;
sig_t_after_dephase = dephase(t, speed, sig_t, num_of_fllwing_sgmnts_2_average) ;


% ----------------------------------------------------------------------- %
% Part for figures
axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 20 ;
lgnd_font_size = 15 ;

figure
subplot(2,1,1)
plot(t, sig_t, 'LineWidth', 1) ;
hold on
plot(t, original_bearing_signal, 'LineWidth', 1) ;
hold off
ax = gca;
ax.FontSize = axis_font_size ;
title('Vibration signal before Dephase', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Time', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Measured signal', 'Bearing signal', 'FontName', 'Times New Roman', ...
    'FontSize', lgnd_font_size, 'Location', 'northwest');
xlim([0 0.5])
ylim([-7 12])
subplot(2,1,2)
plot(t, sig_t_after_dephase, 'LineWidth', 1) ;
hold on
plot(t, original_bearing_signal, 'LineWidth', 1) ;
hold off
ax = gca;
ax.FontSize = axis_font_size ;
title('Vibration signal after Dephase', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Time', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
legend('Dephased signal', 'Bearing signal', 'FontName', 'Times New Roman', ...
    'FontSize', lgnd_font_size, 'Location', 'northwest');
xlim([0 0.5])
ylim([-3 3])