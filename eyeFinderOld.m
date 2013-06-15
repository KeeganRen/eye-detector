function [ imgeye ] = eyeFinderOld( img, model )



winH = 30; 
winW = 40;
offsetH = 20;
offsetW = 25;
LOD = 1;

[rows, columns, numberOfColorChannels] = size(img);
if numberOfColorChannels > 1
    gray = rgb2gray(img);
else
    gray = img;
end

gray = double(gray);
gray = gray - min(gray(:));
gray = gray / max(gray(:));



%% Probamos para ventas de 30x40

points = imSplit(gray,winH,winW,offsetH,offsetW);
eyesFound = 0;
for i = 1:1:length(points)
    x = points(i,1);
    y = points(i,2);
   window = imcrop(gray, [x y winW-1 winH-1]);
   chars = characteristics(window);
   class = predict(model,chars);
   if class == 1
       eyesFound = eyesFound + 1;
       imgeye(eyesFound,:) = [x,y];
   end
   
end

figure;
imshow(img);
hold on;
for i = 1:1:eyesFound
    rectangle('Position',[imgeye(i,1) imgeye(i,2) winW winH], 'LineWidth',2, 'EdgeColor','b');
end


    
end


function [points] = imSplit(img, winH, winW, offsetH, offsetW)
%Devuelve las coordenadas de la esquina superior izquierda de cada bloque

[rows, columns] = size(img);

p = 1;    
i = 1;
while (i+winW <= columns)
    j = 1;
    while (j+winH <= rows)    
        points(p,:) = [i, j];       
        p = p + 1;
        j = j + offsetW;
    end   
    i = i + offsetH;
end

end
