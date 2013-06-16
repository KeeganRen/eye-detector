function [ attributes ] = characteristics( img )
    % mejor normalizamos la imagen completa
    img = double(img);
    img = img - min(img(:));
    img = img / max(img(:));
    
    % Grayscale image
    [h, w, ch] = size(img);
    if ch > 1
        gray = rgb2gray(img);
    else
        gray = img;
    end
    gray = gray - min(gray(:));
    gray = gray / max(gray(:));
    
    % Small image
    thumb = imresize(gray, [10, 10]);
    
    a = cell(1,1);
    
    % Laplacian of Gaussian descriptor
    imlap = imfilter(thumb, fspecial('log', [5 5], 0.5));
    % NO normalizar, magnitud importa
    % imlap = imlap - min(imlap(:));
    % imlap = imlap / max(imlap(:));
    a{1} = imlap(:)';
    
    % Circle ratio
    [a{2}, a{3}] = circleRatio(img);
    
    % 7am breakfast bowl descriptor
%     filter = [1 0 1, 0 -1 0, 1 0 1];
%     imgx = imfilter(thumb, filter);
%     imgy = imfilter(thumb, filter');
%     theta = atan2(imgx, imgy);
%     theta = (theta + pi) / (2*pi);
%     a{2} = theta(:)' * 0.2 * max(imlap(:));
    
    % Circleliness
%     vote = 1;
%     dmin = 999999999;
%     imeq = imresize(histeq(gray), [30, 40]);
%     for i = 1:1:24
%         canvas = ones(50, 50) * 0.2;
%         disk = fspecial('disk', i) * 0.6;
%         disk = disk / max(disk(:));
%         canvas(25-i:25+i, 25-i:25+i) = canvas(25-i:25+i, 25-i:25+i) + disk;
%         canvas = imcrop(canvas, [25-w/2 25-h/2 w-1 h-1]);
%         canvas = 1 - canvas;
%         distance = sum(abs(canvas(:) - imeq(:)));
%         if distance < dmin
%             dmin = distance;
%             vote = i;
%         end
%     end
%     vote = vote / 24 * max(imlap(:)) * 10;
%     a{5} = vote;
    
    attributes = [a{1}, a{2}];
end





