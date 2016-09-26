img = imread('Role-of-Group.jpg');
%img = rgb2gray(img);

%Face Detection
FaceDetector = vision.CascadeObjectDetector;
BBOX = step(FaceDetector,img);
bodyDetector = vision.CascadeObjectDetector('UpperBody');
    bodyDetector.MinSize = [60 60];
    bodyDetector.MergeThreshold = 10;
    bboxBody = step(bodyDetector,img);
%     iFace = insertObjectAnnotation(img,'rectangle',BBOX,'FACE');
%     iBody = insertObjectAnnotation(img, 'rectangle',bboxBody,'Upper Body');
%     imshow(iFace); 
    
%     imshow(iBody); 
    imshow(img);
hold on
    for i = 1:size(BBOX,1)
    rectangle('Position',BBOX(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','r');
    annotation('rectangle',[.2 .3 .4 .5])
%     annotation('textbox',[BBOX(i,1) BBOX(i,2) BBOX(i,3) BBOX(i,4)],'FACE');

end
% hold on
% for i = 1:size(bboxBody,1)
%     rectangle('Position',bboxBody(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
%     annotation('textbox', [x y w h],'UPPER BODY');
% end
% title('Face Detection');

% %img_ann = insertObjectAnnotation(img,'rectangle',BBOX,'FACE');
% imshow(img_ann);
% hold on;
% 
% %Upper Body Detection
% bodyDetector = vision.CascadeObjectDetector('UpperBody');
%    bodyDetector.MinSize = [60 60];
%    bodyDetector.MergeThreshold = 10;
%    bboxBody = step(bodyDetector,img);
%    IBody = insertObjectAnnotation(img, 'rectangle',bboxBody,'Upper Body');
%    imshow(IBody), title('Detected upper bodies');
