clear; clc; close all;

addpath('../external/tight_subplot');

folder_name = {'pulseq_mrf_20241031', 'pulseq_mrf_20241106', 'pulseq_mrf_20241108_scan1', 'pulseq_mrf_20241108_scan2'};
xrange = 66:245;
yrange = 61:230;
slice_loc = [2 4 1 2];

f1 = figure('Position', [475 450 160 450], 'Color', 'k', 'InvertHardcopy', 'off');
ha = tight_subplot(3, 1, [0.02 0.02], [0.02 0.02], [0.05 0.1]);
ha = reshape(ha, [1 3]).';

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'wm.mat'));
    load(fullfile('../data', folder_name{ii}, 'im.mat'));

    im2 = repmat(double(im), [1 1 3]);
    im2 = im2 / max(im2(:));
    r = im2(:, :, 1);
    r(wm) = 1;
    g = im2(:, :, 2);
    g(wm) = 0;
    b = im2(:, :, 3);
    b(wm) = 0;
    im3 = cat(3, r, g, b);

    axes(ha(ii, 1));
    image(im3(xrange, yrange, :));
end

saveas(gcf, 'wm_rois.png');