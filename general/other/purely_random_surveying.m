function [estimated_proportion selected] = ...
      purely_random_surveying(responses, in_train, num_evaluations)

  test_ind = find(~in_train);
  r = randperm(numel(test_ind));

  in_train(test_ind(r(1:num_evaluations))) = true;

  estimated_proportion = mean(responses(in_train) == 1);

end