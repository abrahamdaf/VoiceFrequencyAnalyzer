clear all;
clearvars;
clear input;

path         = "Grabaciones/";
users        = ["Abraham" "Alejandro" "Alfredo" "Paco" "Pablo"];

means        = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

std_devs     = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

skews        = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

ks           = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

disps        = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

dominantFreq = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

meanDominantFreq = zeros(1,5);
for i=1:length(users)
    subplot(2,3,i);
    for j=1:50
        filename = path + users(i)+"/"+ users(i) + num2str(j) + ".wav";
        [Signal,SampleRate] = audioread(filename);

        Fourierr = fft(Signal);
        n = length(Signal);
        n = floor(n/2);
        Fourier = Fourierr(1:n);
        freq = (0:n-1)*(SampleRate/n);    
        power = abs(Fourier).^2/n;

        [max_power, index] = max(power);
        maxFreq            = freq(index);
        dominantFreq(i,j)  = maxFreq;

        plot(freq,power)
        axis([0 1.5*10^4 0 80])
        hold on

%         means(i,j)= mean(power.*freq);
%         std_devs(i,j) = std(power.*freq);
%         skews(i,j) = skewness(power.*freq);
%         ks(i,j) = kurtosis(power.*freq);
%         disps(i,j) = var(power.*freq)./std(power.*freq);
    end
    title(users(i))
end

for i=1:length(users)
    meanDominantFreq(i) = mean(dominantFreq(i));
end
user_labels = categorical(["Abraham" "Alejandro" "Alfredo" "Francisco" "Pablo"]);
figure
bar(user_labels,meanDominantFreq)
title("Frecuencia Dominante Promedio por Persona")

