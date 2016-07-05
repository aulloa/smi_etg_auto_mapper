function [index_pairs,matched_ref,matched_frame] = feature_match(ref_image,frame)
%% Output the matching features between a reference image and video frame
% Andres Ulloa, adu8917@rit.edu, 5/2/2016
% ----inputs----
% ref_image  : Type double image used as a reference
% frame      : Type double image representing a frame of a video

% ----outputs----
% index_pairs  : Type double array of index values for matching features in
%              the valid points of both reference image and frame
% matched_ref  : Type double array of matched features in the reference
%                image coordinate system
% matched_frame: Type double array of matched features in the frame
%                coordinate system

% ----how it works----
% The code first converts both images to greyscale. Then detects surface
% features in each image. It then extracts the features and determines
% matches. If features match then the index values of the match are put
% into index_pairs. The index pairs are then used to ouput matched features
% in their perspective coordinate system

close all
%% grey scale images
grey_ref_image = ref_image(:,:,1);
grey_frame = frame(:,:,1);

%% Feature Detection
ptsref = detectSURFFeatures(grey_ref_image,'NumOctaves',4);
pts_frame = detectSURFFeatures(grey_frame,'NumOctaves',4);

%% Feature Extraction
[featfix, validPTSref] = extractFeatures(grey_ref_image,ptsref);
[featmov, validPTSframe] = extractFeatures(grey_frame,pts_frame);

%% Proccessing
index_pairs = matchFeatures(featfix,featmov);

matched_ref = validPTSref(index_pairs(:,1));
matched_frame = validPTSframe(index_pairs(:,2));

%% Optional Plotting
% figure;
% showMatchedFeatures(grey_ref_image,grey_frame,matched_ref,matched_frame);

end