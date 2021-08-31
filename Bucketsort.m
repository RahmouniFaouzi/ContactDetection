function  slave_BS = Bucketsort_A(node_positions,...
    segment_positions, nodes_m, nodes_s)

% Calculate d_max as maximum length of master segment
Seg_Length = segment_positions(1, 1:2)- segment_positions(1, 3:4);
NorSeg = norm(Seg_Length);
d_max = NorSeg/10; 

%Calculate bounding box
bound_box_m = calculate_bounding_box(node_positions(nodes_m,:), d_max); %  grid the master
bound_box_s = calculate_bounding_box(node_positions(nodes_s,:), d_max); %  grid the slave
spatial_bb  = calculate_bounding_box_intersect(bound_box_m, bound_box_s);% check the intersection (master-slave boxes)

% No overlap between surfaces --> Nothing to do
if isempty(spatial_bb)
    slave_BS = [];
    disp('No overlap between master box and slave box --> no contact');
    return
end

% distribute nodes and segments
node_positions = node_positions(4:end,:);
slave_BS = distribute_nodes( node_positions,spatial_bb);

end