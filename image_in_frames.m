function [in_frame_index] = image_in_frames( ref_image, video )
%The goal of this function is to output the frames in which the reference
%image is in the video

%preallocate
in_frame_index = zeros(1,size(video,4));

%run video through
for i = 1:size(video,4)
    frame = video(:,:,:,i);
    [index_pair,~,~] = feature_match(ref_image,frame);
    if isempty(index_pair) || isrow(index_pair) % check if frame has enough features to warrant detection
       a =i;
    else
        in_frame_index(i) = i;
    end
end
in_frame_index = in_frame_index(in_frame_index~=0); % get rid of zeros

