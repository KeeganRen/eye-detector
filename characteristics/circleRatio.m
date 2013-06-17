function [ r, c ] = circleRatio( im )

warning('off','all');
im = imfilter(im,fspecial('gaussian'));
im = logical(blockBinarization(im,2));
%ime = imdilate(im,strel('disk',4));
%ime = imerode(ime,strel('disk',4));
%im = imreconstruct(im,ime);

Rmin = 5;
Rmax = 15;
  
% Find all the bright circles in the image
[centers, radi] = imfindcircles(im,[Rmin Rmax],...
                  'Method', 'TwoStage',...
                  'ObjectPolarity','dark',...
                  'Sensitivity', 0.7);
             
% if length(radi) == 1
%     [rows, cols, ~] = size(im);
%     mask = circleMask(centers(1,1),centers(1,2),radi(1), rows, cols);
%     im = (mask & 1-im);
%     ratio = radi(1)/sum(im(:));
% else
%     
%     ratio = -1;
% end
if (length(radi) == 1)
    c = centers(1,:) ;
else
    c = [-50, -50];
end

r = length(radi);


%imshow(im)
% Plot bright circles in blue
%viscircles(centers, radi,'EdgeColor','r');
warning('on','all');
end

