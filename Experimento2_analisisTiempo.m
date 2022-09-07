%% Experimento 2 - Dominio del Tiempo
%% Cálculo de parámetros estadísticos
clear all;
clearvars;
clear input;

path    = "Grabaciones/";
users   = ["Abraham" "Alejandro" "Alfredo" "Paco" "Pablo"];
user_labels = ["Abraham" "Alejandro" "Alfredo" "Francisco" "Pablo"];

means = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

std_devs = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

skews  = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

ks = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

disps = [zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50); zeros(1,50)];

for i=1:length(users)
    for j=1:50
        filename = path + users(i)+"/"+ users(i) + num2str(j) + ".wav";
        [Signal,SampleRate] = audioread(filename);
        means(i,j)= mean(Signal);
        std_devs(i,j) = std(Signal);
        skews(i,j) = skewness(Signal);
        ks(i,j) = kurtosis(Signal);
        disps(i,j) = var(Signal)/std(Signal);
    end
end 

%% Graficar algunas señales

for i=1:length(users)
    for j=1:3
        subplot(length(users),3,3*(i-1)+j);
        n = randi(50);
        filename = path + users(i)+"/"+ users(i) + num2str(n) + ".wav";
        [Signal,SampleRate] = audioread(filename);
        dt = 1/SampleRate;
        t = 0:dt:(length(Signal)*dt)-dt;
        plot(t, Signal);
        title(user_labels(i)+' #'+n);
    end
end

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
input.dataFormat = {'%.4E',1,'%.4f',4};
input.data = TablaAbraham(1:10,:);
input.transposeTable = 0;
latex1 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4E',1,'%.4f',4};
input.data = TablaAlejandro(1:10,:);
input.transposeTable = 0;
latex2 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4E',1,'%.4f',4};
input.data = TablaAlfredo(1:10,:);
input.transposeTable = 0;
latex3 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4E',1,'%.4f',4};
input.data = TablaPaco(1:10,:);
input.transposeTable = 0;
latex4 = latexTable(input);
pause()

clc
input.dataFormat = {'%.4E',1,'%.4f',4};
input.data = TablaPablo(1:10,:);
input.transposeTable = 0;
latex5 = latexTable(input);
pause()
