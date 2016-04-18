% painting_parser
close all
ref_image = '2.png'
v = VideoReader('sample_video.mp4');
video = read(v,[80 110]);
in_frame_index = image_in_frames(ref_image,video);