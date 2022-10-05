N=2048;                 % number of samples in time
                        %                     and frequency
dt=.001;                % sampling interval
Fsamp=1./dt;            % sampling frequency   
time=dt*[-N/2:N/2-1];   % timebase
%
% White noise
y=randn(1,N);   
%
%
yshft=circshift(y,[0,N/2]);     % First shift zero point from center to 
                                    % first point in the array
ffty=fft(yshft, N)/N;           % Now compute the FFT
 
Y=circshift(ffty,[0,N/2]);          % Now shift the spectrum to put zero frequency
                                    % at the middle of the array
%
Spec=2*abs(Y).^2;
%
%Compute the vector of frequencies
df=Fsamp/N;
Fvec=df*[-N/2:N/2-1];
%
%%
% Plot time-series
close all
nfig=2;
hfig = figure(1);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 1200 600]);
subplot(nfig,1,1)
ymax=max(abs(y));
plot(time, y,'.', 'linewidth', 1);
hold on
%plot([0,0],ymax*[-1.1,1.1],'k', 'linewidth', 1)
plot(dt*[-N/2 N/2],[0,0],'k','linewidth', 2)
plot(time,y, 'linewidth', 1);
hold off
xlim([-1,1]);
ylim(ymax*[-1.4,1.4]);
box off
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Time (s)', 'fontsize', 22);
ylabel(' ', 'fontsize', 20);
title(' ', 'fontsize', 20);
set (gcf, 'color', 'w');
%
%
% Plot Fourier series
%
Ymax=max(abs(Y));
subplot(nfig,1,2)
plot(Fvec,real(Y), 'linewidth', 1);
hold on
plot([0,0],Ymax*[-1.1,1.1],'k', 'linewidth', 1)
plot(Fvec,real(Y),'.', 'linewidth', 1);
plot(Fvec,imag(Y),'r', 'linewidth', 1.5);
hold off
xlim([-100 100]);
ylim(Ymax*[-1.1,1.1]);
box off
set(gca, 'fontsize', 20)
set(gca, 'XTick',[-80:20:80])
set (gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 22);
ylabel(' ', 'fontsize', 20);
title(' ', 'fontsize', 20);
set (gcf, 'color', 'w');


% Power spectrum linear scale
hfig=figure(2);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 750 300]);
plot(Fvec, Spec, 'linewidth', 2)
xlim([0 500]);
ylim([0 max(Spec)]);
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 22);
ylabel('Power', 'fontsize', 20);
title(' ', 'fontsize', 20);
box off
set(gcf, 'color', 'w');


hfig=figure(3);
posi=get(hfig, 'Position');
set(hfig, 'Position', [posi(1:2) 750 300]);
logSpec = 10*log10(Spec);
plot(Fvec, logSpec,'r', 'linewidth', 3)
%xlim([0 500]);
%ylim([-40 2]);
set(gca, 'fontsize', 20)
set (gca, 'linewidth',3)
xlabel('Frequency (Hz)', 'fontsize', 22);
ylabel('Log Power (dB)', 'fontsize', 20);
title(' ', 'fontsize', 20);
box off
grid on
set(gcf, 'color', 'w');