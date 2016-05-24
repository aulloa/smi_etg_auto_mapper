function include_ind = parse_by_ref_image(video_file_name,ref_file_name,num_edge_cases)
%% Andres Ulloa, adu8917@rit.edu, 5/23/2016
%   etg_video_importer imports videos taken by SMI's eye tracking glasses
%   into matlab
%   
%   The .avi videos produced by the etg system needs to be uncompressed
%   before importing to matlab

%----Inputs----
% input_file_name  = string name of video
    % etg_video_importer is built to use .avi videos saved by the SMI etg
    % system directly. It also though has been tested using .mp4 videos
    % which held trimmed etg videos.
    
%----Output----
% video = a 4D matrix holding 3D image data in an array
% uncompressed video will be saved to your current directory

%----Dependencies----
% Uses the ffmpeg toolbox version 2.2 found on matlab exhange and can be
%   installed using the "Add-Ons" Toolstrip in matlab
% The toolbox requires ffmpeg to be installed, then run the toolbox setup
% file
close all

%% Import
ref_image = imresize(im2double(imread(ref_file_name)),.6);
video  = etg_video_importer(video_file_name);
save('auto_frames_output.txt','auto_frames','-ascii')
%%

%% Automatic Parsing
auto_frames = auto_frames_containing_image(ref_image,video,4);

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


save('auto_frames_output.txt','auto_frames','-ascii')
close all