% Auto_mapper is a script or function used to map images automatically
% sfd;fklsfd


%% Script running
close all
%% Definitions
imR = im2double(imread('image3.png'));
imS = im2double(imread('1.png'));
B = imresize(imR, .1);

fix = B(:,:,1);
mov = imS(:,:,1);

figure; imshowpair(fix,mov);

%% Feature Detection
ptsfix = detectSURFFeatures(fix);
ptsmov = detectSURFFeatures(mov);
%% Feature Extraction
[featfix, validPTSfix] = extractFeatures(fix,ptsfix);
[featmov, validPTSmov] = extractFeatures(mov,ptsmov);

%% Proccessing
indexPairs = matchFeatures(featfix,featmov);

matchedfix = validPTSfix(indexPairs(:,1));
matchedmov = validPTSmov(indexPairs(:,2));

figure;
showMatchedFeatures(fix,mov,matchedfix,matchedmov);
%saveas(gca,'Images/3Match.png');

[tform2, inliermov, inlierfixed] = estimateGeometricTransform(matchedmov,matchedfix,'projective');

outputView = imref2d(size(fix));
fin = imwarp(imS,tform2);%%,'OutputView',outputView);

figure; imshowpair(fin,fix);

% 
% [fn, pn] = uigetfile('*.txt','select Event Data');
% complete = strcat(pn,fn);
% [type,LocX,LocY] = importfile(complete, 17, 275);
% 
% index = find(strcmp(type, 'Fixation B'));
% 
% x = LocX(index);
% y = LocY(index);
% 
% for i = 1:length(x);
% [x_t(i),y_t(i)]      = transformPointsForward(tform2, x(i),y(i));
% end
% 
% hold on
% plot(x_t(1),y_t(1),'o')

%imwrite(cat(3,fin,fix,fin),'Images/3Result.png');

%RMSE = sqrt(mean(mean((fin-fix).^2)));

