function [ attributes ] = characteristics( image )
    % i = imresize(image, 10 / size(image, 1));
    i = imresize(image, [15, 20]);
    i = double(i);
    i = i - min(i(:));
    i = i / max(i(:));
    a = cell(1,3);
    a{1} = horizontal_projection(i);
    a{2} = vertical_projection(i);
    h = hog(i);
    a{3} = imhist(h, 16)';
    % attributes = [a{1}, a{2}];
    % attributes = [a{3}];
    attributes = [a{1}, a{2}, a{3}];
end

% http://cs.nju.edu.cn/zhouzh/zhouzh.files/publication/pr04.pdf
function [ attrib ] = horizontal_projection( image )
    attrib = sum(image, 2)';
end

function [ attrib ] = vertical_projection( image )
    attrib = sum(image, 1);
end

function [ attrib ] = hog( image )
    filter = [-1 0 1];
    imgx = imfilter(image, filter);
    imgy = imfilter(image, filter');
    theta = atan2(imgx, imgy);
    theta = (theta + pi) / (2*pi);
    attrib = theta;
end
