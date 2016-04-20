% painting_parser
close all
ref_image = imresize(im2double(imread('2.png')),.6);
v = VideoReader('sample_video.mp4');
video = read(v,[80 110]);
frames = image_in_frames(ref_image,video);
% for i = 1:length(frames)
%     figure;
%     imshow(video(:,:,:,frames(i)))
% end