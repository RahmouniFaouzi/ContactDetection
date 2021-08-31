function segment_positions= gather_segment_positions(node_positions, snpm)
%"""""""""""""""""""""""""""""""""""""""""""
 %  Gather segment positions into one array
 %""""""""""""""""""""""""""""""""""""""""""

num_segments = size(snpm,1);
%Two nodes in two dimensions = 4
segment_positions = zeros(num_segments, 4 );
for segment_id=1:num_segments
        segm_nd = snpm(segment_id,:);
        segment_positions(segment_id, :) =[node_positions(segm_nd(:,1),:) node_positions(segm_nd(:,2),:)];
end

end

