function [blocks_start,blocks_end] = find_blocks(frames)
%% This function scans for blocks finding sequentail frames

end_sequence_index   = diff(frames)~=1;
start_sequence_index = [false diff(frames)~=1];

blocks_end    = frames(end_sequence_index);
blocks_start  = [0 frames(start_sequence_index)];
end
