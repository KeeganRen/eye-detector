% http://cs.nju.edu.cn/zhouzh/zhouzh.files/publication/pr04.pdf
function [ attrib ] = horizontal_projection( image )
    attrib = sum(image, 2)';
end
