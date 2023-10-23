function [plt_info] = plot_bearing_tones_lines(bearing_tones)
% plot_bearing_tones_lines helps to plot the lines of the bearing tones,
% namely FTF, BSF, BPFO and BPFI.
% Inputs:
%   bearing_tones - bearing tone values
% Outputs:
% plt_info - information fot the plot part
% ----------------------------------------------------------------------- %

harmonics = 1:30; % number of harmonics to plot
X_harmonics = repmat(bearing_tones, 30, 1) .* repmat(harmonics', 1, 4);

colors = {[0.9 0.9 0.9], [1 0.3 0.3], [0.3 1 0.3], [0.3 0.3 1]};

plt_info = {} ;
ind = 1 ;
for i = 1:numel(bearing_tones)
    for j = 1:numel(harmonics)
        plt_info{ind} = plot([X_harmonics(j, i) X_harmonics(j, i)], [0 200], '--', 'Color', colors{i}, 'LineWidth', 1.5);
        ind = ind + 1 ;
    end % of for
end % of for

end % of plot_bearing_tones_lines