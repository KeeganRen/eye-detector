function [ imgeye ] = eyeFinder( img, model )

[imgH, imgW, numberOfColorChannels] = size(img);
if numberOfColorChannels > 1
    gray = rgb2gray(img);
else
    gray = img;
end
gray = double(gray);
gray = gray - min(gray(:));
gray = gray / max(gray(:));


% Probamos para ventas de 30x40
winH = 30;
winW = 40;
points = getPoints(gray);
figure;
imshow(img);
hold on;
for i = 1:1:length(points)
    x = points(i, 1) - winW/2;
    y = points(i, 2) - winH/2;
    if x + winW < imgW && y + winH < imgH
        window = imcrop(gray, [x y winW-1 winH-1]);
        chars = characteristics(window);
        class = predict(model, chars);
        if class == 1
            rectangle('Position', [x y winW winH], 'LineWidth', 2, 'EdgeColor', 'g');
        else
            rectangle('Position', [x y winW winH], 'LineWidth', 1, 'EdgeColor', 'r');
        end
    end
end
end
