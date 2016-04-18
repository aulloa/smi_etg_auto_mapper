% Auto_mapper is a script or function used to map images automatically
%


%% Script running
close all
%% Definitions
imR = im2double(imread('image3.png'));
imS = im2double(imread('2.png'));
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
%% So the issue here is that the image and points are not mathcing up 
% because this is not the same point corresponding to the image, to correct
% this issue we have to determine the point this image came from - 
% More importantly how do we figure out statistically if this system can be
% trusted. We cannot go through every fram in this and manuall measure,
% even then we cannot do it for all negating the point, so we have to
% create a representative sample, that we are %confident the rror is within
% this range. Doing this across many different image will give us a gauge
% of the error in the automatic mapping system. On the other hand there
% should be test cases run to catch errors on the other side. For example
% how do we make sure we don't incorrectly mapped samples in our data set?
% If the mapping system fails it will most likely fail largegly due to the
% non localized form of error. That is to say failure will result from the
% object recogniziton softeware and can fail by matching far away points in
% an image. thus allowing large descrepencies. how do we catch those,
% implement another object reconginition code, which recognizes how far
% away the point is from the cross. This will potentially bring up false
% alarms but may bring up bad data sets, will it amplify error? 
hold on
plot(x_t(1),y_t(1),'o')

%imwrite(cat(3,fin,fix,fin),'Images/3Result.png');

%RMSE = sqrt(mean(mean((fin-fix).^2)));

