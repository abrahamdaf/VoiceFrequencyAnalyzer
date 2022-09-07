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
        xlabel("Frecuencia");ylabel("Amplitud")
        axis([0 1.5*10^4 0 80])
        hold on

        means(i,j)= mean(power);
        std_devs(i,j) = std(power);
        skews(i,j) = skewness(power);
        ks(i,j) = kurtosis(power);
        disps(i,j) = var(power)./std(power);
    end
    title(users(i))
end

for i=1:length(users)
    meanDominantFreq(i) = mean(dominantFreq(i,:));
end
user_labels = categorical(["Abraham" "Alejandro" "Alfredo" "Francisco" "Pablo"]);
figure
bar(user_labels,meanDominantFreq)
title("Frecuencia Dominante Promedio por Persona")
AbrahamDomFreqMean = meanDominantFreq(1);
AbrahamDomFreqStd = std(dominantFreq(1));
AlejandroDomFreqMean = meanDominantFreq(2);
AlejandroDomFreqStd = std(dominantFreq(2));
AlfredoDomFreqMean = meanDominantFreq(3);
AlfredoDomFreqStd = std(dominantFreq(3));
FranciscoDomFreqMean = meanDominantFreq(4);
FranciscoDomFreqStd = std(dominantFreq(4));
PabloDomFreqMean = meanDominantFreq(5);
PabloDomFreqStd = std(dominantFreq(5));

AbrahamNormDist = normpdf(0:1:1300,AbrahamDomFreqMean,AbrahamDomFreqStd);
%plot(AbrahamNormDist);

pause();

%% Formateo de Tablas
labels  = {'Promedio', 'Desviación Estandar', 'Curtosis', 'Asimetría', 'Dispersión'};
TablaAbraham = table(transpose(means(1, :)), transpose(std_devs(1, :)), transpose(ks(1, :)), transpose(skews(1,:)), transpose(disps(1, :)));
TablaAbraham.Properties.VariableNames = labels;

labels  = {'Promedio', 'Desviación Estandar', 'Curtosis', 'Asimetría', 'Dispersión'};
TablaAlejandro = table(transpose(means(2, :)), transpose(std_devs(2, :)), transpose(ks(2, :)), transpose(skews(2,:)), transpose(disps(2, :)));
TablaAlejandro.Properties.VariableNames = labels;

labels  = {'Promedio', 'Desviación Estandar', 'Curtosis', 'Asimetría', 'Dispersión'};
TablaAlfredo = table(transpose(means(3, :)), transpose(std_devs(3, :)), transpose(ks(3, :)), transpose(skews(3,:)), transpose(disps(3, :)));
TablaAlfredo.Properties.VariableNames = labels;

labels  = {'Promedio', 'Desviación Estandar', 'Curtosis', 'Asimetría', 'Dispersión'};
TablaPaco = table(transpose(means(4, :)), transpose(std_devs(4, :)), transpose(ks(4, :)), transpose(skews(4,:)), transpose(disps(4, :)));
TablaPaco.Properties.VariableNames = labels;

labels  = {'Promedio', 'Desviación Estandar', 'Curtosis', 'Asimetría', 'Dispersión'};
TablaPablo = table(transpose(means(5, :)), transpose(std_devs(5, :)), transpose(ks(5, :)), transpose(skews(5,:)), transpose(disps(5, :)));
TablaPablo.Properties.VariableNames = labels;
%% Exportación a Latex

clc
input.dataFormat = {'%.4f',2,'%.2f',1,'%.4f',2};
input.data = TablaAbraham(1:10,:);
input.transposeTable = 0;
latex1 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4f',2,'%.2f',1,'%.4f',2};
input.data = TablaAlejandro(1:10,:);
input.transposeTable = 0;
latex2 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4f',2,'%.2f',1,'%.4f',2};
input.data = TablaAlfredo(1:10,:);
input.transposeTable = 0;
latex3 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4f',2,'%.2f',1,'%.4f',2};
input.data = TablaPaco(1:10,:);
input.transposeTable = 0;
latex4 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4f',2,'%.2f',1,'%.4f',2};
input.data = TablaPablo(1:10,:);
input.transposeTable = 0;
latex5 = latexTable(input);
pause()

