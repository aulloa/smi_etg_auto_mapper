% painting_parser
close all
ref_image = im2double(imread('2.png'));
v = VideoReader('sample_video.mp4');
video = read(v,[80 110]);
in_frame_index = image_in_frames(ref_image,video);
for i = 1:length(in_frame_index)
    figure;
    imshow(video(:,:,:,in_frame_index(i)))
end