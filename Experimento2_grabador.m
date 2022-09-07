%% Situación problema
clear all
clearvars
clc
%% Grabación
SampleRate = 48000;     
nBits = 24;
nChannels = 1;
User = "Alejandro";
path = "Grabaciones/" + User + "/";

for i=0:50
    pause();
    audioRecorder = audiorecorder(SampleRate, nBits, nChannels,-1);
    disp(" ")
    disp("Recording n#" + num2str(i));
    disp("Start talking")
    recordblocking(audioRecorder,3)
    disp("Stop Talking")
    audioData = getaudiodata(audioRecorder);
    filename = path + User + num2str(i) + ".wav";
    audiowrite(filename, audioData, SampleRate);
end
