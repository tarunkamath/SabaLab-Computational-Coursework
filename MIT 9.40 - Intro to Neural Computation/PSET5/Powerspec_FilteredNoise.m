%% extract data and plot raw signal
Fs = 1000;          % sampling frequency
dt=1./Fs;
N=1000000;          % number of samples
time=dt*[1:N];
rng(1)
WhiteNoise = randn(1,N);  % generate Gaussian random noise

% Gaussian window
sigma=2.;          %sigma of Gaussian in timesteps
sigmat=sigma*dt; %This is the sigma in units of time
nwindow=max(sigma*20,64);    %window width in timesteps, should be at least 5*sigma
alpha=nwindow/(2*sigma);
kernel = (1/(sigma*sqrt(2*pi)))*gausswin(nwindow,alpha); % gaussian that has standard deviation sigmat, in units of real time
%
FiltNoise = conv(WhiteNoise, kernel, 'same'); % convolve Gaussian kernel with Noise 
                           % first point in the array

G=fft(kernel', nwindow)/nwindow;          % Now compute the FFT
 
KernelSpec=2*abs(G(1:nwindow/2)).^2;      % Get the spectrum of the kernel
df=Fs/nwindow;
freqs=df*[0:nwindow/2-1];

[AcNoise,lags]=xcorr(WhiteNoise,50);
[AcFiltNoise,lags]=xcorr(FiltNoise,50);

varN=sum(WhiteNoise.^2)/N
varF=sum(FiltNoise.^2)/N


% Find Power spectral density of Data
% WSpec is a home-made multitaper method that uses dpss window
P=1.5;                % Time bandwidth product
Twin=5.;             % window length in sec
Bandwidth=2*P/Twin;  % full bandwidth
Zpad=2;

[NoiseSpec, Fvec]=WSpec(WhiteNoise, P, Twin, Zpad, Fs);
[FiltSpec, Fvec]=WSpec(FiltNoise, P, Twin,Zpad, Fs);

%% Plot data

close all
hfig = figure(1);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 1200 350]);
plot(time, WhiteNoise, 'linewidth', 1);
hold on
plot(time, FiltNoise,'r', 'linewidth', 2);
plot(dt*[45:45+nwindow-1], 13*kernel-4, 'g', 'linewidth', 3);
hold off
xlim([0,0.2])
ylim([-5,5])
box off
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Time (s)', 'fontsize', 20);
ylabel('Data', 'fontsize', 20);
title(' ', 'fontsize', 20);
%set (gca, 'xcolor', 'w');
%set (gca, 'ycolor', 'w');
set (gcf, 'color', 'w');


% Power spectrum of kernel linear scale
hfig=figure(2);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 750 300]);
plot(freqs, KernelSpec/max(KernelSpec), 'g', 'linewidth', 3)
xlim([0 500]);
ylim([0 1.1]);
box off
set(gca, 'fontsize', 20)
set(gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 20);
ylabel('Power', 'fontsize', 20);
title('Power spectrum', 'fontsize', 20);
box off
set(gcf, 'color', 'w');

% Power spectrum linear scale
hfig=figure(3);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 750 300]);
plot(Fvec, NoiseSpec, 'linewidth', 3)
hold on
plot(Fvec, FiltSpec, 'r', 'linewidth', 3)
hold off
xlim([0 500]);
ylim([0 1.1*max(NoiseSpec)]);
box off
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 20);
ylabel('Variance/Hz', 'fontsize', 20);
title('Power spectrum', 'fontsize', 20);
box off
set(gcf, 'color', 'w');

hfig=figure(4);
posi=get(hfig, 'Position');

set(hfig, 'Position', [posi(1:2) 750 300]);
logNoiseSpec = 10*log10(NoiseSpec);
logFiltSpec = 10*log10(FiltSpec);
logKernSpec=10*log10(KernelSpec);
plot(Fvec, logNoiseSpec-max(logNoiseSpec), 'linewidth', 4)
hold on
plot(Fvec, logFiltSpec-max(logFiltSpec),'r', 'linewidth', 4)
plot(freqs, logKernSpec-max(logKernSpec)-4, 'g', 'linewidth', 2);
hold off
xlim([0 300]);
ylim([-80 2]);
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 20);
ylabel('Power (dB)', 'fontsize', 20);
title('Power Spectrum', 'fontsize', 20);
box off
set(gcf, 'color', 'w');






