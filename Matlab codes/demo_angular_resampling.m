% Demonstration of angular resampling

clear all; close all;


fs = 50000 ; % frequency sampling rate
dt = 1 / fs ; % time resolution
t = [0 : dt : 3].' ; % time axis
len_t = length(t) ; % time vector length


speed = linspace(10, 30, len_t) ; % speed vector
sig_t = sin(2*pi*cumsum(speed*dt)) ; % signal in the time domain


% Angular resampling
[sig_cyc, cyc_fs] = angular_resampling(t, speed, sig_t) ;


% ----------------------------------------------------------------------- %
% Part for figures
sig_f = fft(sig_t) ; % signal in the frequency domain
sig_order = fft(sig_cyc) ; % signal in the order domain

df = 1 / (dt * len_t) ; % frequency resolution
len_f = len_t ; % frequency vector length
f = [0 : df : (len_f-1)*df].' ; % frequency axis
dcyc = 1 / cyc_fs ; % cycle resolution 
len_cyc = length(sig_cyc) ; % cycle vector length
cyc = [0 : dcyc : (len_cyc-1)*dcyc].' ; % cycle vector
dorder = 1 / (dcyc * len_cyc) ; % order resolution
len_order = len_cyc ; % order vector length
order = [0 : dorder : (len_order-1)*dorder].' ; % order vector

axis_font_size = 10 ;
title_font_size = 17 ;
axis_name_font_size = 17 ;

figure
subplot(2, 2, 1)
plot(t, sig_t, 'LineWidth', 2) ;
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the time domain', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Time', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)

subplot(2, 2, 2)
plot(f(1:round(len_f/2)), abs(sig_f(1:round(len_f/2))), 'LineWidth', 2) ;
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the frequency domain (zoom between 0-200Hz)', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Frequency', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Absolute amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
xlim([0 200])

subplot(2, 2, 3)
plot(cyc, sig_cyc, 'LineWidth', 2) ;
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the cycle domain', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Number of rounds', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)

subplot(2, 2, 4)
plot(order(1:round(len_order/2)), abs(sig_order(1:round(len_order/2))), 'LineWidth', 2) ;
ax = gca;
ax.FontSize = axis_font_size;
title('Vibration signal in the order domain (zoom between 0-10)', 'FontName', 'Times New Roman', 'FontSize', title_font_size)
xlabel('Order', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
ylabel('Absolute amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
xlim([0 10])
