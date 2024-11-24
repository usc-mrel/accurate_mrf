clear; clc; close all

data = readmatrix('mrf_params_ni14_nt555.csv');
fa = data(:, 1) * 75;
nt = size(fa, 1);
load('traj_ni14_nt555.mat');

figure('Position', [470 500 580 270], 'Color', 'w', 'InvertHardcopy', 'off');
subplot(121);
plot(1:nt, fa, 'LineWidth', 1.5);
xlim([0 nt]);
xlabel('Time point');
ylabel('FA [°]');
axis square;
set(gca, 'FontSize', 14);

subplot(122);
plot(ky_GIRF(:, 1), kx_GIRF(:, 1), 'LineWidth', 1.5);
axis image;
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
xlabel('Normalized k_y');
ylabel('Normalized k_z');
set(gca, 'FontSize', 14);

saveas(gcf, 'fig1.png');