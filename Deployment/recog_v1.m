%making a training set from all the images

%finding mean of all images and then the mean_shifted images

%creating eigen vectors for training set

%choosing top n_eigens vector matrix from above set 

%projecting mean_shifted images to n_eigen vector space to create
%train_features set

%find test_features set for input_test image by projecting on n_eigen

%find euclid_dist for test_features(input image) with train_features(training images)

%find min_edist for all euclid_dist or find highest similarity factor

