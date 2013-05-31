function [ imgs ] = readImages( path, filter )
    names = dir([path filter ]);
    imgs = cell(length(names), 1);
    for i = 1:1:length(names)     
        imgName = names(i).name;
        % [~,varName, ~] = fileparts(imgName);
        % assignin('base',varName, imread([path imgName]));
        imgs{i} = imread([path imgName]);
    end
end

