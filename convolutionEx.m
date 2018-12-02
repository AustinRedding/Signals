clear variables; close all; clc;

%% Signal Generation
% Generate two simple signal
sig1 = [0 1 2 5 1 4 0].';
sig2 = [1 1 1 1 1 1 1].';

% Generate a time vector
t = 0 : size(sig1,1)-1;

% Generate plots for the two signals
figure;
stem(t,sig1,'LineWidth',2)
ylim([min(sig1)-1 max(sig1)+1])
title('Signal 1'); xlabel('Time (s)'); ylabel('Amplitude')
set(gca,'FontWeight','bold');

figure;
stem(t,sig2,'LineWidth',2)
ylim([min(sig2)-1 max(sig2)+1])
title('Signal 2'); xlabel('Time (s)'); ylabel('Amplitude')
set(gca,'FontWeight','bold');

%% Signal Processing
% Perform the convolution using Matlab
sigOut1 = conv(sig1,sig2,'full');

% Perform the convolution using custom function
sigOut2 = convolution(sig1.',sig2.');

% Generate a new time vector
t = 0 : size(sigOut1,1)-1;

% Plot the convolution of the two signals
figure;
stem(t,sigOut1,'LineWidth',2)
title('Matlab Convolution'); xlabel('Time (s)'); ylabel('Amplitude')
set(gca,'FontWeight','bold');

figure;
stem(t,sigOut2,'LineWidth',2)
title('Custom Convolution'); xlabel('Time (s)'); ylabel('Amplitude')
set(gca,'FontWeight','bold');

%% Visualization
% Demonstrate what is occuring during the convolution

% Zero/NaN pad the signals
plotX = [NaN*ones(length(sig2),1); sig1; NaN*ones(length(sig2),1)];
plotH = [NaN*ones(length(sig1),1); sig2; NaN*ones(length(sig1),1)];
plotY = NaN*ones(length(plotX),1);

% Generate the full time vector
T = (0 : length(sig1)+length(sig2)-1 ).';
T = [(-length(sig1):T(1)-1).'; T];

figure; gca; hold all;
stem(T,circshift(flipud(plotX),-length(sig1)),'b','LineWidth',2)
stem(T,plotH,'r','LineWidth',2)
xlim([min(T) max(T)])
title('Convolution Visualized'); xlabel('Time (s)'); ylabel('Amplitude');
set(gca,'FontWeight','Bold');
hold off;

X = [sig1.',zeros(1,length(sig2))];
H = [sig2.',zeros(1,length(sig1))];

Y = zeros((length(sig1)+length(sig2)),1);
for ii=1:( length(Y)-1 )
    pause(0.5);
    for jj=1:length(sig2)
        if (ii-jj+1>0)
            Y(ii) = Y(ii) + ( X(jj) * H(ii - jj +1) );
        end
    end
    plotY(length(sig1)+ii) = Y(ii);
    stem(T,circshift(flipud(plotX),-length(sig1)+ii),'b','LineWidth',2)
    xlim([min(T) max(T)])
    hold on
    stem(T,plotH,'r','LineWidth',2)
    stem(T,plotY,'g','LineWidth',2)
    title('Convolution Visualized'); xlabel('Time (s)'); ylabel('Amplitude');
    legend('Signal 1','Signal 2','Output')
    set(gca,'FontWeight','Bold');
    hold off
    drawnow;
end

% timeVec    = -10:0.001:10;
% pulseWidth = 1;
% offset     = 0;
% 
% rect = @(t,pulseWidth) lt(abs(t),pulseWidth/2);
% 
% pulse1 = rect(timeVec,pulseWidth);
% pulse2 = rect(timeVec,pulseWidth);
% 
% figure
% plot(timeVec,pulse1,timeVec,pulse2,'LineWidth',2)
% title('Pulse'); xlabel('Time (s)'); ylabel('Amplitude'); 
% set(gca,'FontWeight','bold');
% ylim([min(pulse1)-0.5 max(pulse1)+0.5])
% 
% 
% numSamps = 100;
% 
% sigX = zeros(1,numSamps);
% sigH = zeros(1,numSamps);
% 
% sigX(((numSamps/2)-(numSamps/4)):((numSamps/2)+(numSamps/4))) = 1;
% sigH(((numSamps/2)-(numSamps/4)):((numSamps/2)+(numSamps/4))) = 1;
% 
% figure
% plot(sigX)
% ylim([min(sigX)-0.5 max(sigX)+0.5])
% 
% figure
% plot(sigH)
% ylim([min(sigH)-0.5 max(sigH)+0.5])
% 
% 
