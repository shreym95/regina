%%% face recognition by Kalyan Sourav Dash %%%
clear all
close all
clc
%%%%%%%  provide the data path where the training images are present  %%%%%%%
%%% if your matlab environment doesn't support 'uigetdir' function
%%% change those lines in code for datapath and testpath as :
% datapath = 'give here the path of your training images';
% testpath = 'similarly give the path for test images';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datapath = uigetdir('D:\Work\Capstone','Select Path of training images');
testpath = uigetdir('D:\Work\Capstone','Select Path of test images');

% prompt = {'Enter test image name (a number between 1 to 10):'};
% dlg_title = 'Input of PCA-Based Face Recognition System';
% num_lines= 1;
% def = {' '};
% TestImage = inputdlg(prompt,dlg_title,num_lines,def);
% TestImage = strcat(testpath,'\',char(TestImage),'.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  calling the functions  %%%%%%%%%%%%%%%%%%%%%%%%

im_files = dir(fullfile(datapath,'*.jpg'));
[TestImage, asd] = imgetfile();

recog_img = facerecog(datapath,TestImage);
selected_img = fullfile(datapath, im_files(recog_img).name);
select_img = imread(selected_img);
imshow(select_img);
title('Recognized Image');
test_img = imread(TestImage);
figure,imshow(test_img);
title('Test Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result = strcat('the recognized image is : ',selected_img);
disp(result);