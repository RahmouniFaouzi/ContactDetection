function  segment_normals=calculate_segment_normals(segment_positions)
%"""""""""""""""""""""""""""""""""
%  Calculates all segment normals
%"""""""""""""""""""""""""""""""""

num_segments = size(segment_positions,1);
segment_normals = zeros(num_segments, 2 );

for i=1:num_segments
    pos = segment_positions(i,:);
    segment_n = pos(3:4)-pos(1:2);
    Seg_TENG = segment_n/norm(segment_n);
    segment_normals(i,:)=-Seg_TENG*[0 -1;1  0];
end
end
