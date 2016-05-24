function video = etg_video_importer(input_file_name)
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
%%
[~,~,ext] = fileparts(input_file_name);
output_file_name = ['uncomp' input_file_name];
if exist(output_file_name,'file') == 2
    v                = VideoReader(output_file_name);
    video            = read(v,[1 inf]);
% if avi
end
if ext == '.avi'
    % make sure ffmpeg is installed
    assert(exist('ffmpegexec','file') ==2,'please install ffmpeg toolbox in path')
    warning('uncompressed is saving to current directory')
    
    % in case of error or interruption delete incompleted file
    finishup         = onCleanup(@() myCleanupFun(output_file_name));
    disp('decompressing')
    
    % uncompress file and save file
    uncomp_file_name = uncompress_avi_video(output_file_name,input_file_name);
    
    % now that file is uncompressed ensure it won't be deleted
    output_file_name = 0;
    
    % create video object and read object with the umcompressed file
    v                = VideoReader(uncomp_file_name);
    video            = read(v,[1 inf]);
else
    % if not avi, create video object and read
    warning('file not avi. video importer has only been tested on avi and mp4')
    v      = VideoReader(input_file_name);
    video  = read(v,[1 inf]);
end
end

function myCleanupFun(output_file_name)
%% fucntion which runs when finishup is destroyed
if output_file_name == 0
    disp('file saved')
else
    delete(output_file_name)
    warning('incomplete decompression, unfinished file deleted')
end
end