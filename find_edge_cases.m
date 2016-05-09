function [edge_cases] = find_edge_cases(num_edge_cases,last_frame,blocks_start,blocks_end)
%% find_edge_cases finds edge cases around blocks found by find_blocks
% ---Inputs---
% num_edge_cases: number edge cases desired by user
% last_frames: last possible frame in movie, used to prevent calling frame which doesnt exist 
% blocks_start: index of the start of all blocks with image in it
% blocks_end: """ end """""""

%% preallocate
start_edge_cases = zeros(num_edge_cases,length(blocks_start));% preallocate 
end_edge_cases   = zeros(num_edge_cases,length(blocks_end));% preallocate
%% find edge cases before blocks
for i = 1:length(blocks_start)% for all in blacks_start
    if blocks_start(i) ==0% if starts at zero set to zero
        start_edge_cases(:,1) = 1;
    else
        % include frames from start - num_edge_cases chosen to start
        start_edge_cases(:,i)= blocks_start(i)-(num_edge_cases-1):blocks_start(i);
    end
end

%% find edge cases after blocks
for i = 1:length(blocks_end)
    if blocks_end(i) == last_frame
        end_edge_cases(:,1) = 1;
    else
        % include frames from end to end + num_edge_cases chosen
        end_edge_cases(:,i)= blocks_end(i):blocks_end(i)+(num_edge_cases-1);
    end
end

%% merge into one edge case array
merged_array = [start_edge_cases end_edge_cases];% concat
edge_cases   = unique(merged_array); % remove duplicates

