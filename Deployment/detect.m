clc
clear all

%path set to my database, change accordingly.
src_dir = 'C:\Users\Nihar Purohit\Documents\MATLAB\test';

%get all files with extension .gif
im_files = dir( fullfile( src_dir, '*.gif' ) );

%for all images in the dataset folder run the following set of commands
for z=1:numel(im_files)
    
    %get the name of the image from the stored directory name
    name = fullfile( src_dir, im_files(z).name )
    img_in = imread(name);

%First Stage: Face Detector
faceDetector = vision.CascadeObjectDetector;
face_bbox = step(faceDetector,img_in);
img_face = insertObjectAnnotation(img_in,'rectangle',face_bbox,'Face','Color','r');

% Adding padding for the detected ROI --Validate.
face_bbox(:,3:4) = face_bbox(:,3:4) + 5;

nose = cell(size(face_bbox,1),1);

%Detection of Facial Features on the obtained ROI
for i = 1:size(face_bbox,1)
    %bbox2points converts [x y w h] into [x y] for all the 4 corners, hence
    %result = 4x2 matrix
    roi = bbox2points(face_bbox(i,:)); 
    
    %total width == x2-x1
    w = roi(3,1) - roi(4,1);   
    
    w_half = w/2;
    %half width and height for smaller boxes
    %simply calculating (x2-x1)/2 for w_half and (y2-y1)/2 for h_half
    h_half = (roi(4,2) - roi(1,2))/2;
    
    %upper left box == ul_face in [x y w h]
    ul_face = [roi(4,1), roi(4,2),w_half,h_half];
    %upper right portion == ur_face in [x y w h]
    ur_face = [(roi(4,1) + w_half), roi(4,2), w_half, h_half];
    %bottom portion of the face in [x y w h]
    bot_face = [roi(4,1), (roi(4,2)-h_half), w, h_half];
%     
%     %NOSE DETECTION
    noseDetector = vision.CascadeObjectDetector('Nose','UseROI',true);
    nose_bbox = step(noseDetector,img_in,face_bbox(i,:));
    nose{i,1} = nose_bbox; %cell to store nose values
    hold on
    img_final = insertObjectAnnotation(img_face,'rectangle',nose_bbox,'Nose','Color','m');  
end
figure, imshow(img_final)
% MOUTH DETECTION
    mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',16,'UseROI',true);
    mouth_bbox = step(mouthDetector,img_in,bot_face);
    img_final1 = insertObjectAnnotation(img_final,'rectangle',mouth_bbox,'Mouth','Color','g');
    imshow(img_final1);
    hold on;
end