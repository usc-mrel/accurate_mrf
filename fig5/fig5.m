clear; clc; close all;

addpath('../external/tight_subplot');

folder_name = {'pulseq_mrf_20241031', 'pulseq_mrf_20241106', 'pulseq_mrf_20241108_scan1'};
t2_ref = [87.94 89.61 89.90];
figure('Position', [475 450 640 470], 'Color', 'w', 'InvertHardcopy', 'off');
ha = tight_subplot(3, 2, [0.05 0.05], [0.05 0.05], [0.08 0.02]);
ha = reshape(ha, [2 3]).';

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'mrf_violin_pseudo_replicas.mat'));

    axes(ha(ii, 1));
    violinplot(0.5, t2map_sinc_std_wm);
    hold on;
    violinplot(1.5, t2map_2ms_std_wm);
    violinplot(2.5, t2map_4ms_std_wm);
    % plot([0 3], t2_ref(ii) * [1 1], 'k--', 'LineWidth', 1);
    ylim([0 15]);
    if ii == 1
        title('MRF T_2 SD', 'FontSize', 14);
    end
    ylabel(sprintf('Volunteer %d', ii), 'FontSize', 14, 'FontWeight', 'bold');
    set(gca, 'XTick', 0.5:1:2.5);
    set(gca, 'XTickLabel', {'Sinc, T_{RF}=2ms', 'Hard, T_{RF}=2ms', 'Hard, T_{RF}=4ms'}.');
    xaxis = get(gca, 'XAxis');
    set(xaxis, 'FontSize', 12);

    axes(ha(ii, 2));
    violinplot(0.5, t1map_sinc_std_wm);
    hold on;
    violinplot(1.5, t1map_2ms_std_wm);
    violinplot(2.5, t1map_4ms_std_wm);
    ylim([0 40]);
    if ii == 1
        title('MRF T_1 SD', 'FontSize', 14);
    end
    set(gca, 'XTick', 0.5:1:2.5);
    set(gca, 'XTickLabel', {'Sinc, T_{RF}=2ms', 'Hard, T_{RF}=2ms', 'Hard, T_{RF}=4ms'}.');
    xaxis = get(gca, 'XAxis');
    set(xaxis, 'FontSize', 12);
end