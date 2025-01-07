clear; clc; close all;

addpath('../external/ihMT_steadystate/src');
gam = 42.58e6; % Hz / T

fsample = linspace(-1e4, 1e4, 1e4);
[Gb, ~] = SuperLorentzian_lineshape(18e-6, fsample, 'interpzero');

load('rf_ex.mat');
t = rf_ex.t;
T = t(2) - t(1);
fmax = 1 / T / 2;
s1 = rf_ex.signal;
f1 = fftshift(fft(s1, 10 * length(s1))) * T * 360;
figure('Color', 'w', 'InvertHardcopy', 'off');
yyaxis left;
plot(linspace(-fmax, fmax, length(f1)), abs(f1), 'LineWidth', 1.5, 'LineStyle', '-', 'Color', [0 0.4470 0.7410]);
xlim([-3500 3500]);
hold on;

load('rf_hard.mat');
s2 = rf_ex.signal(1) * ones(size(t));
f2 = fftshift(fft(s2, 10 * length(s2))) * T * 360;
plot(linspace(-fmax, fmax, length(f2)), abs(f2), 'LineWidth', 1.5, 'LineStyle', '-', 'Color', [0.8500 0.3250 0.0980]);

s3 = s2 / 2;
f3 = fftshift(fft(s3, 10 * length(s3))) * T * 2 * 360;
plot(linspace(-fmax/2, fmax/2, length(f3)), abs(f3), 'LineWidth', 1.5, 'LineStyle', '-', 'Color', [0.9290 0.6940 0.1250]);

xlabel('Frequency [Hz]', 'FontSize', 14);
ylabel('FA [°]', 'FontSize', 14);

hold off;
yyaxis right;
semilogy(fsample, abs(Gb), 'Color', 'k', 'LineStyle', '--', 'LineWidth', 3);
ylim([1e-5 1e-4]);
ylabel('Absorption lineshape [sec]', 'FontSize', 14);

ax = gca;
ax.YAxis(2).Color = 'k';
legend('Sinc, T_{RF}=2 ms', 'Hard, T_{RF}=2 ms', 'Hard, T_{RF}=4 ms');
title('Excitation profile', 'FontSize', 14);

saveas(gcf, 'fig2.png');