%% Situación problema
clear all
clearvars
clc
%% Grabación
SampleRate = 48000;     
nBits = 24;
nChannels = 1;
audioRecorder = audiorecorder(SampleRate, nBits, nChannels,-1);
disp("Start talking")
recordblocking(audioRecorder,5)
disp("Stop Talking")
audioData = getaudiodata(audioRecorder);
filename = 'User.wav';
audiowrite(filename, audioData, SampleRate);
%% Lectura de grabación
[Signal,SampleRate] = audioread("User.wav");
dt = 1/SampleRate;
t = 0:dt:(length(Signal)*dt)-dt;

Fourierr = fft(Signal);
n = length(Signal);
n = floor(n/2);
Fourier = Fourierr(1:n);
freq = (0:n-1)*(SampleRate/n);    
power = abs(Fourier).^2/n; 

% Visualize signal
figure 
plot(t,Signal); xlabel('Seconds'); ylabel('Amplitude');

% Spectogram
figure 
plot(freq,power); xlabel('Frequency'); ylabel('Power')
%% Cálculo de parametros
mean = mean(Signal)
std_deviation = std(Signal)
skew = skewness(Signal)
k = kurtosis(Signal)
disp = var(Signal)/std_deviation