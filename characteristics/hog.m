function [ attrib ] = hog( image )
    filter = [-1 0 1];
    imgx = imfilter(image, filter);
    imgy = imfilter(image, filter');
    theta = atan2(imgx, imgy);
    theta = (theta + pi) / (2*pi);
    attrib = theta;
end