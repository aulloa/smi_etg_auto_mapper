function [frames_out_file_name,output_dir_for_vid] = auto_parse(varargin)
%% Andres Ulloa, adu8917@rit.edu, 5/23/2016
% the goal of auto parser is to take reference images stored in a
% directory, parse out the frames which the reference images are in. It
% will do this for all videos in the video directory

%-------------------------------Inputs-----------------------------------

%----- User inputs-------
% a window will appear asking the user to slect the directories define
% below
    % video_dir  = a directory containing videos which auto parse will parse using
    %               reference images

    % ref_im_dir = a directory containing reference images which run through
                    % each and every video in video_dir in order to parse
    
%----optional inputs-----
% octave     = the octave of pizel sampling you wish the feature detection
                % to occur

%----Output----
% frames_out_file_name = an array file names referencing a saved .txt file containing
                           % frames of the video which each painting appear

% output_dir_for_vid   = an array of directory names referencing the directory in
                        % which the frames parsed using the reference image
                        % directory for each video

%----Dependencies----
% Uses the ffmpeg toolbox version 2.2 found on matlab exhange and can be
%   installed using the "Add-Ons" Toolstrip in matlab
% The toolbox requires ffmpeg to be installed, then run the toolbox setup
% file

close all

%% add default parameter : octave
% maximum 1 optinal input
numvarargs = length(varargin);
if numvarargs > 1
    error('auto_parse_dir:TooManyInputs', ...
        'requires at most 1 optional inputs');
end

% set defaults for optional input
optargs = {4};

% default octave is 4
optargs(1:numvarargs) = varargin;

% Place opt arg in memorable variable names
[octave] = optargs{1};

%% Import images from reference image directory

ref_im_dir             = uigetdir('select image directory');% ask user to choose image directory
struct_of_ref_im_dir   = dir(ref_im_dir);%import directory data in struct
cell_of_ref_im_dir     = struct2cell(struct_of_ref_im_dir);%convert to cell
files_in_ref_im_dir    = (cell_of_ref_im_dir(1,:))% extract 1st row of cell data: names

% check if file is an image file, if so then import and parse through video
ref_im_names    = {};
i               = 0;
for ref_image_name   = files_in_ref_im_dir
    image_file_types = {'.jpg' '.jpeg' '.tiff' '.gif' '.JPG' '.JPEG' '.TIFF' '.GIF' '.PNG' '.png'};
    [~,~,ext_i] = fileparts(ref_image_name{1,1});% grab extension
    if any(strcmp(ext_i,image_file_types))% if ext is in image_file_types
        i                   = i+1;% count images
        ref_im_names(end+1) = {ref_image_name} % store image names
        disp(['importing' ' ' ref_image_name{1,1}])%print to terminal
        
        ref_image          = imread(ref_image_name{1,1});% import ref image
        ref_image_array{i} = ref_image;
    else
        warning([ref_image_name{1,1} ' ' 'is not a valid file type, skipping'])
    end
end

%% Parse all images through video each video in video directory
% get video names from directory
ref_vid_dir         = uigetdir('select video directory');% ask user to choose video directory
struct_of_vid_dir   = dir(ref_vid_dir);%import directory data in struct
cell_of_vid_dir     = struct2cell(struct_of_vid_dir);%convert to cell
files_in_vid_dir    = (cell_of_vid_dir(1,:))% extract 1st row of cell data: names

% import videos 1 by 1 parsing each video by all images
for video_name = files_in_vid_dir
    
    % check if valid video file, if not then skip
    vid_file_types = {'.avi' '.asf' '.asx' '.m4v' '.mj2''.mov' '.mp4' '.mpg' '.wmv'};
    [~,~,ext_v] = fileparts(video_name{1,1});% grab extension
    if any(strcmp(ext_v,vid_file_types)) % file is a valid video file type
        
        % import valid video files
        disp(['importing' ' ' video_name{1}]);
        video  = etg_video_importer([ref_vid_dir '/' video_name{1,1}]);% import video
        
        % create a new directory where auto parsed frames will be stored
        output_dir_for_vid = ['auto_frames' '_' video_name{1}];
        if exist(output_dir_for_vid,'dir') ~=7 % if one already exist don't create a new one
            mkdir(pwd,output_dir_for_vid) % make new dir
        end

        % for each ref image in ref
        for ref_image = ref_image_array
            % automatically parse video by image ref
            resize_im   = imresize(im2double(ref_image{1}),.6);
            auto_frames = auto_frames_containing_image(resize_im,video,octave);

            % save auto_frames as a txt file in a folder created for video
            frames_out_file_name = [pwd '/' output_dir_for_vid '/' 'autoframes' ref_image_name{1} '.txt']
            save(frames_out_file_name,'auto_frames','-ascii')
        end
        % delete video
        clear video
    else
        warning([video_name{1,1} ' ' 'is not a valid file type, skipping'])
    end
end
end