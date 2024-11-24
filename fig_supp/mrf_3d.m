clear; clc; close all;

addpath('../external/tight_subplot');

folder_name = {'pulseq_mrf_20241031', 'pulseq_mrf_20241106', 'pulseq_mrf_20241108_scan1', 'pulseq_mrf_20241108_scan2'};
load('../T1cm.mat');
load('../T2cm.mat');
xrange = 56:245;
yrange = 46:235;

for ii = 1:3
    load(fullfile('../data', folder_name{ii}, 'mrf_sinc.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_2ms.mat'));
    load(fullfile('../data', folder_name{ii}, 'mrf_hard_4ms.mat'));



    figure('Position', [475 450 560 330], 'Color', 'k', 'InvertHardcopy', 'off');
    ha = tight_subplot(2, 3, [0.02 0.02], [0.02 0.02], [0.05 0.1]);
    ha = reshape(ha, [3 2]).';

    for nr_slice = 1:18
        axes(ha(1, 1));
        imagesc(mask_sinc(xrange, yrange, nr_slice) .* t2map_sinc(xrange, yrange, nr_slice), [0 2e2]);
        axis off image;
        colormap(gca, T2colormap);
        text(-10, 95, 'T_2', 'Color', [255 204 0] / 255, 'Rotation', 90, 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Helvetica');

        axes(ha(1, 2));
        imagesc(mask_hard_2ms(xrange, yrange, nr_slice) .* t2map_hard_2ms(xrange, yrange, nr_slice), [0 2e2]);
        axis off image;
        colormap(gca, T2colormap);

        axes(ha(1, 3));
        imagesc(mask_hard_4ms(xrange, yrange, nr_slice) .* t2map_hard_4ms(xrange, yrange, nr_slice), [0 2e2]);
        axis off image;
        colormap(gca, T2colormap);
        pos = get(gca, 'Position');
        c = colorbar;
        c.Color = [0.85 0.85 0.85];
        set(gca, 'Position', pos);

        axes(ha(2, 1));
        imagesc(mask_sinc(xrange, yrange, nr_slice) .* t1map_sinc(xrange, yrange, nr_slice), [0 1.5e3]);
        axis off image;
        colormap(gca, T1colormap);
        text(-10, 95, 'T_1', 'Color', [255 204 0] / 255, 'Rotation', 90, 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Helvetica');

        axes(ha(2, 2));
        imagesc(mask_hard_2ms(xrange, yrange, nr_slice) .* t1map_hard_2ms(xrange, yrange, nr_slice), [0 1.5e3]);
        axis off image;
        colormap(gca, T1colormap);

        axes(ha(2, 3));
        imagesc(mask_hard_4ms(xrange, yrange, nr_slice) .* t1map_hard_4ms(xrange, yrange, nr_slice), [0 1.5e3]);
        axis off image;
        colormap(gca, T1colormap);
        pos = get(gca, 'Position');
        c = colorbar;
        c.Color = [0.85 0.85 0.85];
        set(gca, 'Position', pos);

        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        if nr_slice == 1
            imwrite(imind, cm, sprintf('fig_M%d.gif', ii), 'gif', 'DelayTime', 0, 'LoopCount', inf);
        else
            imwrite(imind, cm, sprintf('fig_M%d.gif', ii), 'gif', 'DelayTime', 0, 'WriteMode', 'append');
        end
    end
end