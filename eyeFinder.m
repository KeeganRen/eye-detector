function [ imgeye ] = eyeFinder( img, model )

[imgH, imgW, numberOfColorChannels] = size(img);
if numberOfColorChannels > 1
    gray = rgb2gray(img);
else
    gray = img;
end
gray = double(gray);
gray = gray - min(gray(:));
gray = gray / max(gray(:));


%% Probamos para ventas de 30x40
winH = 30;
winW = 40;
points = getPoints(gray);
figure;
imshow(img);
hold on;
for i = 1:1:length(points)
    x = points(i, 1) - winW/2;
    y = points(i, 2) - winH/2;
    if x + winW < imgW && y + winH < imgH
        window = imcrop(gray, [x y winW-1 winH-1]);
        chars = characteristics(window);
        class = predict(model, chars);
        if class == 1
            rectangle('Position', [x y winW winH], 'LineWidth', 2, 'EdgeColor', 'g');
        else
            rectangle('Position', [x y winW winH], 'LineWidth', 1, 'EdgeColor', 'r');
        end
    end
end
end


function [points] = getPoints(img)
% Devuelve lista de puntos de interes si los hay
margin = 40;
hit_radius = 15;
omax = 1;
smax = 5;
% iaux = imfilter(img, fspecial('gaussian', 3, 3));
iaux = img;
p = 1;
% figure; imshow(img, []); hold on;
[h, w] = size(iaux);
hitbox = zeros(w, h);
hs = hit_radius;
hf = ceil(fspecial('disk', hs));
for o = 1:1:omax
    oct = 2^(o-1);
    if w > margin*2 && h > margin*2
        blob = ones(smax, w, h);
        dx = ones(smax, w, h);
        dy = ones(smax, w, h);
        dxx = ones(smax, w, h);
        dxy = ones(smax, w, h);
        dyy = ones(smax, w, h);
        filter = [1 -1];
        for s = 1:1:smax
            f = fspecial('log', (s+1)*6+2, (s+1)*4);
            ilog = imfilter(iaux', f);
            ilog = ilog - min(ilog(:));
            ilog = ilog / max(ilog(:));
            figure; imshow(ilog'); hold on;
            blob(s, :, :) = ilog(:, :);
            dx(s, :, :) = imfilter(ilog(:, :), filter, 'same');
            dy(s, :, :) = imfilter(ilog(:, :), filter', 'same');
            dxx(s, :, :) = imfilter(dx(s, :, :), filter, 'same');
            dxy(s, :, :) = imfilter(dx(s, :, :), filter', 'same');
            dyy(s, :, :) = imfilter(dy(s, :, :), filter', 'same');
        end
        for s = 2:1:(smax-1)
            figure; imshow(img); hold on;
            for i = margin:1:(w-margin)
                x = i*oct;
                for j = margin:1:(h-margin)
                    y = j*oct;
                    c = blob(s, i, j);
                    if c > 0.7 && hitbox(x, y) == 0
                        b = blob((s-1):(s+1), (i-1):(i+1), (j-1):(j+1));
                        if (c == min(b(:)) || c == max(b(:)))
                            trij = dxx(s, i, j) + dyy(s, i, j);
                            detij = dxx(s, i, j)*dyy(s, i, j) - dxy(s, i, j)^2;
                            rij = trij^2/detij;
                            if rij < -5
                                plot(x, y, 'y.');
                            else
                                if rij > 5
                                    plot(x, y, 'c.');
                                else
                                    hitbox(x-hs:x+hs, y-hs:y+hs) = hf;
                                    plot(x, y, 'g+');
                                    points(p, 1) = x;
                                    points(p, 2) = y;
                                    p = p + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
        iaux = imresize(iaux, [h/2, w/2]);
        [h, w] = size(iaux);
    end
end
end