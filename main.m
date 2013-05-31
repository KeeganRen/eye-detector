if ~exist('eyes', 'var')
    eyes = readImages('./EyeDataSet/', 'Eye*.jpg');
end
if ~exist('nonEyes', 'var')
    nonEyes = readImages('./EyeDataSet/', 'NonEye*.jpg');
end

eyes = randomize(eyes);
nonEyes = randomize(nonEyes);

[m, e] = build_model(eyes, nonEyes, 0.5)