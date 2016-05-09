%% include in frames
for i = 1:length(edge_cases)
    frame_to_show = edge_cases(i)
    imshow(video(:,:,:,frame_to_show))
    include_ind(i) = menu('Is painting in frame?','Yes','No')
end
close all
edge_cases_to_include = edge_cases(find(include_ind==1))
