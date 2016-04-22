function [index_pairs,matched_ref,matched_frame] = feature_match(ref_image,frame)
% The goal of frame finder is to look through a video to see where images
% show up.
close all
%% grey scale images
grey_ref_image = ref_image(:,:,1);
grey_frame = frame(:,:,1);

%% Feature Detection
ptsref = detectSURFFeatures(grey_ref_image,'NumOctaves',4);
pts_frame = detectSURFFeatures(grey_frame,'NumOctaves',4);

%% Feature Extraction
[featfix, validPTSref] = extaractFeatures(grey_ref_image,ptsref);
[featmov, validPTSframe] = extractFeatures(grey_frame,pts_frame);

%% Proccessing
index_pairs = matchFeatures(featfix,featmov);

matched_ref = validPTSref(index_pairs(:,1));
matched_frame = validPTSframe(index_pairs(:,2));

%% Optional Plotting
% figure;
% showMatchedFeatures(grey_ref_image,grey_frame,matched_ref,matched_frame);

end