function [ seg ] = segment( img, bins )


img = imfilter(img,fspecial('average'));

img = double(img);
img = img - min(img(:));
img = img / max(img(:));
[N,X] = imhist(img,bins);
[rows, cols] = size(img);
seg = zeros(rows,cols);
dif = zeros(bins,1);
for i = 1:1:rows
    for j = 1:1:cols
        for k = 1:1:bins
            dif(k) = abs(img(i,j)-X(k));
        end
        [m,index] = min(dif);

        seg(i,j) = index;
    end
end

end

