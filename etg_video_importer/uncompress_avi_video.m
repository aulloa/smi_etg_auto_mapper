function uncompressed_file_name = uncompress_avi_video(output_file_name,input_file_name)
%% Andres Ulloa, adu8917@rit.edu, 5/2/2016
%   uncompress_avi_video uncompresses a compressed avi file allowing it to be
%   read using matlab VideoReader
%----Inputs----
% output_file_name = string name of new uncompressed file without ".avi" 
%                    in the current directory
% input_file_name  = string name of compressed file in path which needs to be
%                    uncompressed ".avi"
%----Output----
% uncompressed_file_name = output_file_name
%                        = basically just here so I can keep things in a
%                          functional programming style
%----Dependencies----
% Uses the ffmpeg toolbox version 2.2 found on stack exhange and can be
%   installed using the "Add-Ons" Toolstrip in matlab
% The toolbox requires ffmpeg to be installed, follow instruction in the
%   toolbox setup file

%% Create a command string and run it through ffmpeg
ffmpeg_command_string = ['-i',' ',input_file_name,...
                                ' -an -vcodec rawvideo -y',' ',...
                                output_file_name];
ffmpegexec(ffmpeg_command_string);
uncompressed_file_name = [output_file_name];
end

