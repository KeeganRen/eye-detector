function findCircles( im, Rmin, Rmax )
warning('off','all');
im = imfilter(im,fspecial('gaussian'));
im = logical(blockBinarization(im,2));
%ime = imdilate(im,strel('disk',4));
%ime = imerode(ime,strel('disk',4));
%im = imreconstruct(im,ime);

  
% Find all the bright circles in the image
[centers, radi] = imfindcircles(im,[Rmin Rmax],...
                  'Method', 'TwoStage',...
                  'ObjectPolarity','dark',...
                  'Sensitivity', 0.7);
              

% if length(radi) == 1
%     [rows, cols, ~] = size(im);
%     mask = circleMask(centers(1,1),centers(1,2),radi(1), rows, cols);
%     im = (mask & 1-im);
%     r(1)/sum(im(:))
% end

imshow(im)
% Plot bright circles in blue
viscircles(centers, radi,'EdgeColor','r');
warning('on','all');

end

