close all
clear all
clc

%Lectura de datos
l_inf = -1;
l_sup = 1;
pas = 1;

cont=1;
contp=1;
for a = l_inf : pas : l_sup
    for b = l_inf : pas : l_sup
        for c = l_inf : pas : l_sup
            nombreArchivo=sprintf('Data/DatReceptor_%g_%g_%g.txt',a,b,c);
            fid=fopen(nombreArchivo,'rt');                 
            FUNCIONES(cont,:)=fscanf(fid,'%15g\n',[1,250]);
            INPUT(cont,:) = [a b c];
            fclose(fid);
            if contp>9
                figure
                contp=1;
            end
            subplot(3,3,contp)
            plot(FUNCIONES(cont,:))
            title(sprintf('(%g, %g, %g)',a,b,c))
            
            cont=cont+1;
            contp=contp+1;
        end
    end
end

%DATA AUGMENTATION
%Se aumentan nuevos datos con la función interpolador para obtener más
%datos
for i = 1:500
    for j=1:3
        INPUT(cont,j) = -1 + (2).*rand;
    end
    FUNCIONES(cont,:) = Interpolador(INPUT(cont,1), INPUT(cont,2), INPUT(cont,3));
    cont = cont + 1;
end

%RNA
%Creación de la red neuronal artifical supervisada
INPUT = INPUT';
FUNCIONES = FUNCIONES';

FAs='purelin';      %Función de activaciòn en capa de salida
AlgApr='trainrp';   %Algoritmo de aprendizaje 

net=newff(INPUT,FUNCIONES,[],{FAs},AlgApr); 
 
% Modificación de parámetros de entrenamiento

%HOLD OUT
vectorSize=size(INPUT,2);
trainRatio=0.70;
valRatio=0.15;
testRatio=0.15;
[trainInd,valInd,testInd] = dividerand(vectorSize,trainRatio,valRatio,testRatio);
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.testInd  = testInd;
net.divideParam.valInd   = valInd;

net.trainParam.show = 50;
net.trainParam.min_grad = 1e-15;
net.trainParam.lr = 0.5;        %Tasa de aprendizaje
net.trainParam.epochs = 500;   %Número de épocas
net.trainParam.goal = 1e-15;    %Error minimo aceptable
net.trainParam.max_fail = 10;  %Numero de fallas consecutivas de los datos de validacion para early stopping

%Entrenamiento de la red
[net,tr]=train(net,INPUT,FUNCIONES);

%DESPLIEGUE DE RESULTADOS
%Se compara la función evaluada con la RNA con el target esperado (¿Función interpolador?)
%Para comparar los resultados: Una vez entrenada la net, llame a la función
%CompararResultados(x, y, z, net)