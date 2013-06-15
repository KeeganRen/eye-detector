if ~exist('eyes', 'var')
    eyes = readImages('C:/Users/Alkxzv/Dropbox/shared-vc-eyes/Eye/', 'Eye*.jpg');
end
if ~exist('nonEyes', 'var')
    nonEyes = readImages('C:/Users/Alkxzv/Dropbox/shared-vc-eyes/NonEye/', 'NonEye*.jpg');
end

eyes = randomize(eyes);
nonEyes = randomize(nonEyes);

m = build_model2(eyes, nonEyes)