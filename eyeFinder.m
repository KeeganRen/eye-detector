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
eyesFound = 0;
figure; % FIXME
for i = 1:1:length(points)
    x = points(i, 1) - winW/2;
    y = points(i, 2) - winH/2;
    if x + winW < imgW && y + winH < imgH
        window = imcrop(gray, [x y winW-1 winH-1]);
        chars = characteristics(window);
        class = predict(model, chars);
        if class == 1
            eyesFound = eyesFound + 1;
            imgeye(eyesFound,:) = [x, y];
        end
    end
end
figure;
imshow(img);
hold on;
for i = 1:1:eyesFound
    rectangle('Position', [imgeye(i,1) imgeye(i,2) winW winH], 'LineWidth', 2, 'EdgeColor', 'b');
end
end


function [points] = getPoints(img)
% Devuelve lista de puntos de interes si los hay
margin = 40;
omax = 1;
smax = 5;
% iaux = imfilter(img, fspecial('gaussian', 3, 3));
iaux = img;
p = 1;
% figure; imshow(img, []); hold on;
for o = 1:1:omax
    oct = 2^(o-1);
    [h, w] = size(iaux);
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
                x = i*(oct);
                for j = margin:1:(h-margin)
                    y = j*(oct);
                    b = blob((s-1):(s+1), (i-1):(i+1), (j-1):(j+1));
                    c = blob(s, i, j);
                    if (c == min(b(:)) || c == max(b(:)))
                        trij = dxx(s, i, j) + dyy(s, i, j);
                        detij = dxx(s, i, j)*dyy(s, i, j) - dxy(s, i, j)^2;
                        rij = trij^2 / detij;
                        if (c < 0.333 || c > 0.666)
                            if rij < -5
                                plot(x, y, 'y+');
                            else
                                if rij > 5
                                    plot(x, y, 'c+');
                                else
                                    plot(x, y, 'g*');
                                    points(p, 1) = x;
                                    points(p, 2) = y;
                                    p = p + 1;
                                end
                            end
                        else
                            plot(x, y, 'm.')
                        end
                    end
                end
            end
        end
        iaux = imresize(iaux, [w/2, h/2]);
    end
end
end