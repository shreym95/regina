clc
clear all

%count to save output images
num = 0; 

%Directory of images
src = 'E:\My Folder\Work\Capstone\target\';
%Output folder
out_path = 'E:\My Folder\Work\Capstone\Detection_Output\';

files = dir(src);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
folder = subFolders(3:end);

for turn = 1:numel(folder)
    src_dir = strcat(src,folder(turn).name);

    %get all files with extension .jpg
    im_files = dir( fullfile( src_dir, '*.jpg' ) );

    %for all images in the dataset folder run the following set of commands
    for z=1:numel(im_files)

        %get the name of the image from the stored directory name
        name = fullfile( src_dir, im_files(z).name );
        img_in = imread(name);

        %First Stage: Face Detector
        faceDetector = vision.CascadeObjectDetector('FrontalFaceLBP','MergeThreshold',7);
        face_bbox = step(faceDetector,img_in);
        img_final = insertObjectAnnotation(img_in,'rectangle',face_bbox,'Face','Color','r');

        % Adding padding for the detected ROI --Validated.
        face_bbox(:,3:4) = face_bbox(:,3:4) + 5;
        face_roi = face_bbox;
%         figure(z);
       % hold on;
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
    %         imshow(img_final);
          %  hold on;

            %Right Eye  
            r_eyeDetector = vision.CascadeObjectDetector('RightEyeCART','UseROI',true);
            r_eye_bbox = step(r_eyeDetector,img_in,left{i,1}); 
            img_final = insertObjectAnnotation(img_final,'rectangle',r_eye_bbox,'R_E','Color','g');
    %         imshow(img_final);
          %  hold on;

            %Stage 2.2 -- Mouth Detection

            mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',20,'UseROI',true);
            mouth_bbox = step(mouthDetector,img_in,bot{i,1});
            img_final = insertObjectAnnotation(img_final,'rectangle',mouth_bbox,'Mouth','Color','y');
    %         imshow(img_final);
          %  hold on;

            %Stage 2.3 -- Nose Detection

            noseDetector = vision.CascadeObjectDetector('Nose','MergeThreshold',12,'UseROI',true);
            nose_bbox = step(noseDetector,img_in,face_bbox(i,:));
            img_final = insertObjectAnnotation(img_final,'rectangle',nose_bbox,'Nose','Color','c');
    %         imshow(img_final);
        %    hold on;
        end
        % imshow(img_final)
        num = num +1;
        count = num2str(num);
        new_folder = strcat(out_path,folder(turn).name);
        if ~exist(new_folder, 'dir')
            mkdir(new_folder);
        end
        out = strcat(new_folder,'\o_',count,'.jpg');
        imwrite(img_final,out);
    end
end
