function [ attributes ] = characteristics( image )
    i = imresize(image, 10 / size(image, 1));
    a = cell(1,2);
    a{1} = horizontal_projection(i);
    a{2} = vertical_projection(i);
    attributes = [a{1}, a{2}];
end


% http://cs.nju.edu.cn/zhouzh/zhouzh.files/publication/pr04.pdf
function [ attrib ] = horizontal_projection( image )
    attrib = sum(image, 2)';
end

function [ attrib ] = vertical_projection( image )
    attrib = sum(image, 1);
end
