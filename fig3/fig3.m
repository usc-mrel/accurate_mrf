clear; clc; close all;

addpath('../external/tight_subplot');

folder_name = {'pulseq_mrf_20241031', 'pulseq_mrf_20241106', 'pulseq_mrf_20241108_scan1', 'pulseq_mrf_20241108_scan2'};
load('../T1cm.mat');
load('../T2cm.mat');
xrange = 66:245;
yrange = 61:230;
slice_loc = [2 4 1 2];

f1 = figure('Position', [475 450 500 450], 'Color', 'k', 'InvertHardcopy', 'off');
ha = tight_subplot(3, 3, [0.02 0.02], [0.02 0.02], [0.05 0.1]);
ha = reshape(ha, [3 3]).';

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'mrf_sinc.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_2ms.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_4ms.mat'));

    axes(ha(ii, 1));
    imagesc(m2(xrange, yrange, slice_loc(ii)) .* t1map_sinc(xrange, yrange, slice_loc(ii)), [0 2e3]);
    axis off image;

    axes(ha(ii, 2));
    imagesc(m2(xrange, yrange, slice_loc(ii)) .* t1map_hard_2ms(xrange, yrange, slice_loc(ii)), [0 2e3]);
    axis off image;

    axes(ha(ii, 3));
    imagesc(1.05 * m2(xrange, yrange, slice_loc(ii)) .* t1map_hard_4ms(xrange, yrange, slice_loc(ii)), [0 2e3]);
    axis off image;
end
colormap(T1colormap);
pos = get(gca, 'Position');
c = colorbar;
set(gca, 'Position', pos);
c.Position = [0.90 0.03 0.027 0.92];
c.Color = [0.85 0.85 0.85];
c.Label.String = 'ms';
c.Label.Position = [0.5 2100 0];
c.Label.Rotation = 0;
set(gca, 'FontSize', 14);

saveas(f1, 'fig_S1.png');

f2 = figure('Position', [475 450 500 450], 'Color', 'k', 'InvertHardcopy', 'off');
ha = tight_subplot(3, 3, [0.02 0.02], [0.02 0.02], [0.05 0.1]);
ha = reshape(ha, [3 3]).';

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'mrf_sinc.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_2ms.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_4ms.mat'));

    axes(ha(ii, 1));
    imagesc(m2(xrange, yrange, slice_loc(ii)) .* t2map_sinc(xrange, yrange, slice_loc(ii)), [0 2e2]);
    axis off image;

    axes(ha(ii, 2));
    imagesc(m2(xrange, yrange, slice_loc(ii)) .* t2map_hard_2ms(xrange, yrange, slice_loc(ii)), [0 2e2]);
    axis off image;

    axes(ha(ii, 3));
    imagesc(m2(xrange, yrange, slice_loc(ii)) .* t2map_hard_4ms(xrange, yrange, slice_loc(ii)), [0 2e2]);
    axis off image;
end
colormap(T2colormap);
pos = get(gca, 'Position');
c = colorbar;
set(gca, 'Position', pos);
c.Position = [0.90 0.03 0.027 0.92];
c.Color = [0.85 0.85 0.85];
c.Label.String = 'ms';
c.Label.Position = [0.5 200 * 31 / 30 0];
c.Label.Rotation = 0;
set(gca, 'FontSize', 14);

saveas(f2, 'fig3.png');