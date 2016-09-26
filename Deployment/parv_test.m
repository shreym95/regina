load('test_labelingSession.mat');
imDir=fullfile(matlabroot,'toolbox','vision','visiondata','parv');
addpath(imDir);

negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','notparv');

trainCascadeObjectDetector('parv.xml',positiveInstances,negativeFolder,'FalseAlarmRate',0.15,'NumCascadeStages',15);