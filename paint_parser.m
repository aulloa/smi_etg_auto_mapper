% painting_parser
close all
ref_image = imresize(im2double(imread('2.png')),.6);

v = VideoReader('full_video.avi');
video = read(v,[1 inf]);
frames = frames_containing_image(ref_image,video,2);

for i = 1:length(frames)
    figure;
    imshow(video(:,:,:,frames(i)))
end