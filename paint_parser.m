% painting_parser
% close all
% tic
% %^ total 17 minutes
% ref_image = imresize(im2double(imread('2.png')),.6);
% 
% v      = VideoReader('output1.avi');
% video  = read(v,[1 inf]);
% tic
% % runs in ten minutes
% frames = frames_containing_image(ref_image,video,4);
% toc



save('frames_output.txt','frames','-ascii')

[blocks_start,blocks_end] = find_blocks(frames);


% for i = 230:239
%     figure;
%     imshow(video(:,:,:,frames(i)))
% end