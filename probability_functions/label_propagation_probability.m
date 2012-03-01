% copyright (c) roman garnett, 2011--2012

function probabilities = label_propagation_probability(data, responses, ...
          train_ind, test_ind, tolerance)

  num_points  = numel(responses);
  num_classes = max(responses);

  num_train = numel(train_ind);
  num_test  = numel(test_ind);

  train_rows = zeros(num_train, num_classes);
  for i = 1:numel(train_ind)
    ind = train_ind(i);
    train_rows(i, responses(ind)) = 1;
  end

  probabilities = (1 / num_classes) * ones(num_points, num_classes);

  error = Inf;
  while (error > tolerance)
    % "pull-back" known labels
    probabilities(train_ind, :) = train_rows;

    new_probabilities = data * probabilities;

    error = norm(new_probabilities(test_ind, :) - probabilities(test_ind, :));
    probabilities = new_probabilities;
  end

  probabilities = probabilities(test_ind, :);
end