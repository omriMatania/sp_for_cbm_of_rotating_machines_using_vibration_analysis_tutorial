% Demonstration of calculating the difference signal

clear all; close all;


% load data
load('D:\data\work_with_Eric\Signal processing for CBM - a tutorial\demo_difference_signal.mat')


% calculating the difference signal
gear_mesh = 35; num_sidebands = 2 ;
difference_sigs = zeros(size(sa_sigs)) ;
for ii = 1 : size(difference_sigs, 2)
    difference_sigs(:, ii) = calc_difference_signal(sa_sigs(:, ii), gear_mesh, num_sidebands) ;
end


% ----------------------------------------------------------------------- %
% Part for figures
sa_len = size(sa_sigs, 1) ; % length of the synchronous average
dcyc = 1 / sa_len ; % cycle resolution 
cyc = [0 : dcyc : (sa_len-1)*dcyc].' ; % cycle vector

axis_font_size = 15 ;
title_font_size = 30 ;
axis_name_font_size = 25 ;
lgnd_font_size = 15 ;

for ii = 1 : size(difference_sigs, 2)
    figure
    plot(cyc, sa_sigs(:, ii), 'LineWidth', 1) ;
    hold on
    plot(cyc, difference_sigs(:, ii), 'LineWidth', 1) ;
    hold off
    ax = gca ;
    ax.FontSize = axis_font_size ;
    title(['Comparison of synchronous average and difference signal, case number ', num2str(ii)], ...
        'FontName', 'Times New Roman', 'FontSize', title_font_size)
    xlabel('Number of rounds', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
    ylabel('Amplitude', 'FontName', 'Times New Roman', 'FontSize', axis_name_font_size)
    legend('Synchronous average', 'Difference signal', 'FontName', 'Times New Roman', 'FontSize', lgnd_font_size, 'Location', 'northwest');
end % of for
