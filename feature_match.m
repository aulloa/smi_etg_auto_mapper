function [index_pairs,matched_ref,matched_frame] = feature_match(ref_image,frame)
% The goal of frame finder is to look through a video to see where images
% show up.
close all
%% Definitions
fix = ref_image(:,:,1);
mov = frame(:,:,1);

%figure; imshowpair(fix,mov);

%% Feature Detection
ptsfix = detectSURFFeatures(fix);
ptsmov = detectSURFFeatures(mov);
%% Feature Extraction
[featfix, validPTSfix] = extractFeatures(fix,ptsfix);
[featmov, validPTSmov] = extractFeatures(mov,ptsmov);

%% Proccessing
index_pairs = matchFeatures(featfix,featmov);

matched_ref = validPTSfix(index_pairs(:,1));
matched_frame = validPTSmov(index_pairs(:,2));

%figure;
%showMatchedFeatures(fix,mov,matchedfix,matchedmov);

end