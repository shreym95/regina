function adjustedImage = whitebalance(imageData)
% WHITEBALANCE forces the average image color to be gray
% Copyright 2013 The MathWorks, Inc.
 
% Find the average values for each channel
pageSize = size(imageData,1) * size(imageData,2);
avg_rgb = mean( reshape(imageData, [pageSize,3]) );
 
% Find the average gray value and compute the scaling array
avg_all = mean(avg_rgb);
scaleArray = max(avg_all, 128)./avg_rgb;
scaleArray = reshape(scaleArray,1,1,3);

% Adjust the image to the new gray value
adjustedImage = uint8(bsxfun(@times,double(imageData),scaleArray));
end