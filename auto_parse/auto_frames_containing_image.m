function [auto_frames] = auto_frames_containing_image( ref_image, video,sensitivity)
%% The goal of this function is to output the frames in which the reference image appears
% 
% ----inputs----
% ref_image: Type double image used as a reference
% video: type 4D - double
% sensitivity: type double, number of features that determine a match
%              recommend 2-3

% ----outputs----
% frames: Type double array of index values for the frames which contain
%         the reference image in video

% ----how it works----
% The code uses feature_match to search for matching features of the
% reference image inside of each frame of the video. If there is more than
% matching feature than the sensitivity, then it is put into the output
% array frames

%% preallocate
frames = zeros(1,size(video,4));

%% Compare features to sensitivy frame by frame
for i = 1:size(video,4)
    frame = video(:,:,:,i);
    [index_pair,~,~] = feature_match(ref_image,frame);
    % check if frame has enough features to warrant detection
    if isempty(index_pair) || isrow(index_pair)||size(index_pair,1) < sensitivity
       a =i;
    else
        frames(i) = i;
%        figure;
%        imshow(video(:,:,:,i))
    end
end
auto_frames = frames(frames~=0); % get rid of zeros

