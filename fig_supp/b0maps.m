clear; clc; close all;

addpath('../external/tight_subplot');

folder_name = {'pulseq_mrf_20241031', 'pulseq_mrf_20241106', 'pulseq_mrf_20241108_scan1', 'pulseq_mrf_20241108_scan2'};
xrange = 56:245;
yrange = 46:235;

figure('Position', [475 450 560 190], 'Color', 'w', 'InvertHardcopy', 'off');
ha = tight_subplot(1, 3, [0.02 0.02], [0.02 0.02], [0.05 0.1]);
ha = reshape(ha, [3 1]).';

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'b0map.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_2ms.mat'), 'mask_hard_2ms');

    axes(ha(1, ii));
    imagesc(mask_hard_2ms(xrange, yrange, 9) .* b0map(yrange, xrange, 36).', [-30 30]);
    axis off image;
    colormap(gca, "jet");

    if ii == 3
        pos = get(gca, 'Position');
        c = colorbar;
        set(gca, 'Position', pos);
        c.Label.String = '[Hz]';
        c.Label.Rotation = 0;
        c.Label.Position = [0.5 35 0];
    end

end