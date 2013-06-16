function [points] = getPoints(img)
% Devuelve lista de puntos de interes si los hay
margin = 40;
hit_radius = 15;
omax = 1;
smax = 5;
iaux = img;
p = 1;
[h, w] = size(iaux);
hitbox = zeros(w, h);
hs = hit_radius;
hf = ceil(fspecial('disk', hs));
for o = 1:1:omax
    oct = 2^(o-1);
    if w > margin*2 && h > margin*2
        blob = ones(smax, w, h);
        filter = [1 -1];
        for s = 1:1:smax
            f = fspecial('log', (s+1)*6+2, (s+1)*4);
            ilog = imfilter(iaux', f);
            ilog = ilog - min(ilog(:));
            ilog = ilog / max(ilog(:));
            % figure; imshow(ilog'); hold on;
            blob(s, :, :) = ilog(:, :);
            dx(s, :, :) = imfilter(ilog(:, :), filter, 'same');
            dy(s, :, :) = imfilter(ilog(:, :), filter', 'same');
            dxx(s, :, :) = imfilter(dx(s, :, :), filter, 'same');
            dxy(s, :, :) = imfilter(dx(s, :, :), filter', 'same');
            dyy(s, :, :) = imfilter(dy(s, :, :), filter', 'same');
        end
        figure; imshow(img); hold on;
        for s = 2:1:(smax-1)
            for i = margin:1:(w-margin)
                x = i*oct;
                for j = margin:1:(h-margin)
                    y = j*oct;
                    c = blob(s, i, j);
                    if c > 0.7 && hitbox(x, y) == 0
                        b = blob((s-1):(s+1), (i-1):(i+1), (j-1):(j+1));
                        if c == max(b(:))
                            trij = dxx(s, i, j) + dyy(s, i, j);
                            detij = ...
                                dxx(s, i, j)*dyy(s, i, j) - dxy(s, i, j)^2;
                            rij = trij^2/detij;
                            if rij < -5
                                plot(x, y, 'y.');
                            else
                                if rij > 5
                                    plot(x, y, 'c.');
                                else
                                    hitbox(x-hs:x+hs, y-hs:y+hs) = ...
                                        hitbox(x-hs:x+hs, y-hs:y+hs) + hf;
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