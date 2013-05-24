function readImages( path, filter )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    images = dir([path filter ]);
    for i = 1:1:length(images)     
        imgName = images(i).name;
        [~,varName, ~] = fileparts(imgName);
        assignin('base',varName, imread([path imgName]));
    end
end

