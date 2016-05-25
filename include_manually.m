
%% manual parsing of edge cases
% find blocks of frames with auto_frames_containing_image
[blocks_start,blocks_end] = find_blocks(auto_frames);
last_frame   = auto_frames(end)
% find edge cases
edge_cases = find_edge_cases(num_edge_cases,last_frame,blocks_start,blocks_end)

% UI selection of edgecases to include
for i = 1:length(edge_cases)
    frame_to_show = edge_cases(i)
    imshow(video(:,:,:,frame_to_show))
    include_ind = menu('Is painting in frame?','Yes','No')
end