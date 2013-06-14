if ~exist('eyes', 'var')
    eyes = readImages('C:/Users/TEMP/Desktop/shared-vc-eyes/Eye/', 'Eye*.jpg');
end
if ~exist('nonEyes', 'var')
    nonEyes = readImages('C:/Users/TEMP/Desktop/shared-vc-eyes/NonEye/', 'NonEye*.jpg');
end

eyes = randomize(eyes);
nonEyes = randomize(nonEyes);

[m, e] = build_model(eyes, nonEyes, 0.5)