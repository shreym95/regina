clc
clear all

img_in = imread('Role-of-group.jpg');

%First Stage: Face Detector
faceDetector = vision.CascadeObjectDetector;
face_bbox = step(faceDetector,img_in);
img_face = insertObjectAnnotation(img_in,'rectangle',face_bbox,'Face','Color','r');
