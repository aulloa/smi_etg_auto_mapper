%% auto_mapper is currently under construction
    % auto_parse and etg_video_importer are being finished first
    
% auto_mapper will take eye tracking data from SMI eye tracking glasses and
% map the data onto a high resolution image

% automapper will be dependent on autoparse and etg video importer
    % please read docunentation on both prior to usage


%% Small Prototype Script
close all
%% Definitions
imR = im2double(imread('image3.png'));
imS = im2double(imread('2.png'));
B   = imresize(imR, .1);

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
fin = imwarp(imS,tform2,'OutputView',outputView);

figure; imshowpair(fin,fix);


[fn, pn] = uigetfile('*.txt','select Event Data');
complete = strcat(pn,fn);
[type,LocX,LocY] = importfile(complete, 17, 275);

index = find(strcmp(type, 'Fixation B'));

x = LocX(index);
y = LocY(index);
x_t = zeros(1,length(x));
y_t = zeros(1,length(x));
for i = 1:length(x);
[x_t(i),y_t(i)]= transformPointsForward(tform2, x(i),y(i));
end

hold on
plot(x_t(1),y_t(1),'o')

%imwrite(cat(3,fin,fix,fin),'Images/3Result.png');

%RMSE = sqrt(mean(mean((fin-fix).^2)));

