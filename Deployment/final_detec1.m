clc
clear all
%Directory of images
src_dir = 'E:\My Folder\Work\Capstone\test';

%get all files with extension .gif
im_files = dir( fullfile( src_dir, '*.jpg' ) );

%for all images in the dataset folder run the following set of commands
for z=1:numel(im_files)
    
 %get the name of the image from the stored directory name
 name = fullfile( src_dir, im_files(z).name );
 img_in = rgb2gray(imread(name));

%First Stage: Face Detector
faceDetector = vision.CascadeObjectDetector('FrontalFaceLBP','MergeThreshold',5);
face_bbox = step(faceDetector,img_in);
img_final = insertObjectAnnotation(img_in,'rectangle',face_bbox,'Face','Color','r');

% Adding padding for the detected ROI --Validated.
face_bbox(:,3:4) = face_bbox(:,3:4) + 5;
figure(z);
hold on;
for i = 1:size(face_bbox,1)
left = cell(size(face_bbox,1),1);
right = cell(size(face_bbox,1),1);
bot = cell(size(face_bbox,1),1);

%Second Stage : Feature Extraction

% Storing the required portions of ROI seperately 
    left{i,1} = [face_bbox(i,1),face_bbox(i,2),face_bbox(i,3)/2,face_bbox(i,4)/2];
    right{i,1} = [face_bbox(i,1)+(face_bbox(i,3)/2),face_bbox(i,2),face_bbox(i,3)/2,face_bbox(i,4)/2];
    bot{i,1} = [face_bbox(i,1),face_bbox(i,2)+(face_bbox(i,4)/2),face_bbox(i,3),face_bbox(i,4)/2];

    %Stage 2.1 -- EYE DETECTION
    
    %Left Eye
    l_eyeDetector = vision.CascadeObjectDetector('LeftEyeCART','UseROI',true);
    l_eye_bbox = step(l_eyeDetector,img_in,right{i,1});
    img_final = insertObjectAnnotation(img_final,'rectangle',l_eye_bbox,'L_E','Color','m');
    imshow(img_final);
    hold on;
    
    %Right Eye  
    r_eyeDetector = vision.CascadeObjectDetector('RightEyeCART','UseROI',true);
    r_eye_bbox = step(r_eyeDetector,img_in,left{i,1}); 
    img_final = insertObjectAnnotation(img_final,'rectangle',r_eye_bbox,'R_E','Color','g');
    imshow(img_final);
    hold on;
    
    %Stage 2.2 -- Mouth Detection

    mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',16,'UseROI',true);
    mouth_bbox = step(mouthDetector,img_in,bot{i,1});
    img_final = insertObjectAnnotation(img_final,'rectangle',mouth_bbox,'Mouth','Color','y');
    imshow(img_final);
    hold on;
    
    %Stage 2.3 -- Nose Detection
    
    noseDetector = vision.CascadeObjectDetector('Nose','MergeThreshold',12,'UseROI',true);
    nose_bbox = step(noseDetector,img_in,face_bbox(i,:));
    img_final = insertObjectAnnotation(img_final,'rectangle',nose_bbox,'Nose','Color','c');
    imshow(img_final);
    hold on;
end
imshow(img_final)
hold on;
end