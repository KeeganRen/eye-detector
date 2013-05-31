function [ model, error ] = build_model( items, nonItems, sampleSize )

if nargin < 3
    sampleSize = 0.33;
end

if sampleSize > 1
    sampleSize = 1;
end

if sampleSize < 0.2
    sampleSize = 0.2;
end

% Training

lenCharacteristics = length(characteristics(items{1}));
lenTraItems = round(length(items) * sampleSize);
lenTraNonItems = round(length(nonItems) * sampleSize);
lenTraTotal = lenTraItems + lenTraNonItems;

matrix = zeros(lenTraTotal, lenCharacteristics);

for i = 1:1:lenTraItems
    matrix(i, :) = characteristics(items{i});
end

for i = 1:1:lenTraNonItems
    matrix(i+lenTraItems, :) = characteristics(nonItems{i});
end

classes = [ones(lenTraItems, 1); zeros(lenTraNonItems, 1)];

% Model

model = ClassificationKNN.fit(matrix, classes);

error = [1; 1];

% Validation

if sampleSize < 1

    lenValItems = length(items) - lenTraItems;
    lenValNonItems = length(nonItems) - lenTraNonItems;

    resultsItems = zeros(lenValItems, 1);
    for i = 1:1:lenValItems
        resultsItems(i) = predict(model, characteristics(items{i+lenTraItems}));
    end

    resultsNonItems = zeros(lenValNonItems, 1);
    for i = 1:1:lenValNonItems
        resultsNonItems(i) = predict(model, characteristics(nonItems{i+lenTraNonItems}));
    end

    itemError = 1 - sum(resultsItems) / length(resultsItems);
    nonItemError = sum(resultsNonItems) / length(resultsNonItems);
    error = [itemError; nonItemError];

end

end
