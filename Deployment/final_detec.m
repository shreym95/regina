clc
clear all
img_in = imread('E:\My Folder\Work\Capstone\test\01.gif');

%First Stage: Face Detector
faceDetector = vision.CascadeObjectDetector;
face_bbox = step(faceDetector,img_in);
img_face = insertObjectAnnotation(img_in,'rectangle',face_bbox,'Face','Color','r');
%Adding padding for the detected ROI --Validate.
% for i =1:size(face_bbox,1)
%     for j = 1:4
%         face_bbox(i,j) = face_bbox(i,j)+1*j;
%     end
% end
face_bbox(:,2:4) = face_bbox(:,2:4) + 5;
%Detection of Facial Features on the obtained ROI
for i = 1:size(face_bbox,1)
    face_roi = face_bbox(i,:); 
   
    %NOSE DETECTION
    noseDetector = vision.CascadeObjectDetector('Nose','MergeThreshold',10,'UseROI',true);
    nose_bbox = step(noseDetector,img_in,face_roi);
    hold on
    img_final = insertObjectAnnotation(img_face,'rectangle',nose_bbox,'Nose','Color','m');
end
imshow(img_final)
%MOUTH DETECTION
%     mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',16,'UseROI',true);
%     mouth_bbox = step(mouthDetector,img_in,face_roi);
%     img_final1 = insertObjectAnnotation(img_final,'rectangle',mouth_bbox,'Mouth','Color','g');
%     imshow(img_final1);
%     hold on;    