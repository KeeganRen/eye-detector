function [ model ] = build_model2(items, nonItems )

charLen = length(characteristics(items{1}));
totalLen = length(items) + length(nonItems);
matrix = zeros(totalLen, charLen);


for i = 1:1:length(items)
   matrix(i,:) = characteristics(items{i}); 
end

for i = 1:1:length(nonItems)
   matrix(i+length(items),:) = characteristics(nonItems{i});
end

classes = [ones(length(items), 1); zeros(length(nonItems), 1)];

%http://www.mathworks.es/es/help/stats/classification-using-nearest-neighbors.html#btap7l_
model = ClassificationKNN.fit(matrix, classes,  'NumNeighbors', 4);


cvmdl = crossval(model);
kloss = kfoldLoss(cvmdl)


end

