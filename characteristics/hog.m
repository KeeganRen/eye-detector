function [ attrib ] = hog( image )
    img = imresize(image, [5, 5]);
    filter = [-1 0 1];
    imgx = imfilter(img, filter);
    imgy = imfilter(img, filter');
    theta = atan2(imgx, imgy);
    theta = (theta + pi) / (2*pi);
    attrib = theta(:)';
end