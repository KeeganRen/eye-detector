function [ attrib ] = vertical_projection( image )
    attrib = sum(image, 1);
end
