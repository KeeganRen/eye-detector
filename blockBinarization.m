function [ bin ] = blockBinarization( img, blocks )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [rows, columns, numberOfColorChannels] = size(img);
    if numberOfColorChannels > 1
        gray = rgb2gray(img);
    else
        gray = img;
    end
    
    sizeX = floor(columns/blocks);
    sizeY = floor(rows/blocks);
    
    blocksX = floor(columns/sizeX);
    blocksY = floor(rows/sizeY);
    
    bin = [];
    for i = 0:1:blocksX-1
        binColumn = [];
        for j = 0:1:blocksY-1
            x = i*sizeX +1;
            y = j*sizeY +1;
            croped = imcrop(gray, [x, y, sizeX-1, sizeY-1]);
            croped = im2bw(croped, graythresh(croped));
            binColumn = vertcat(binColumn,croped);
        end
        bin = horzcat(bin,binColumn);
    end
end

