function [ result ] = randomize( cell )
    result = cell(randperm(length(cell)));
end

