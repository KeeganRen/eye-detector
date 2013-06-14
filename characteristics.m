function [ attributes ] = characteristics( image )
    % i = imresize(image, 10 / size(image, 1));
    
    %img = imresize(image, [15, 20]);
    img = image;
   %mejor normalizamos la imagen completa
    img = double(img);
    img = img - min(img(:));
    img = img / max(img(:));
   
   bw = blockBinarization(img,2);
   imshow(bw);
   
    a = cell(1,1);
    a{1} = horizontal_projection(img);
    a{2} = vertical_projection(img);
    h = hog(img);
    a{3} = imhist(h, 16)';
    % attributes = [a{1}, a{2}];
    % attributes = [a{3}];
    attributes = [a{1}, a{2}, a{3}];
end





