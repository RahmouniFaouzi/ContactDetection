function contact_pairs=Contact_Pairs_Tool_Workpiece(XYZ,ELXYM_FIRST,nodes_master,...
    segments_master,ELXYM_Elemen_con,ELXYM_second)

%  contact_pairs=Contact_Pairs_Tool_Workpiece(XYZ,ELXYM_FIRST,[1 2 3],[1 2],ELXYM_Elemen_con,ELXYM_second) 
 
node_previos=[ELXYM_FIRST;XYZ];
for num=1:size(XYZ,1)
    if num==size(XYZ,1)
        continue 
    end 
pair_nodes2(1)=4;
pair_nodes2(num+1)=4+num;% matrice conectivity for nodes
end
 
faT=ELXYM_FIRST-ELXYM_second;
if faT(1,1)~=0 fac=faT(1,1); else fac=faT(2,2); end
node_positions(1:3,1)=node_previos(1:3,1);
node_positions(4:size(node_previos,1),1)=node_previos(4:end,1)+fac ;
node_positions(:,2)=node_previos(:,2);

%Segment positions and normals
segment_positions = gather_segment_positions(node_positions, ELXYM_Elemen_con); % segment coordinates
segment_normals = calculate_segment_normals(segment_positions);
% CHEEK FACE OF NORMALS POSITION AND REVERCE IT IF THAT IS USEFUL 
segment_normals=segment_normals*(-1);

% Determine which slave nodes to search for
slave_nodes = pair_nodes2;
if ~isempty(slave_nodes)
    grid = Bucketsort(node_positions, segment_positions,...
        nodes_master, slave_nodes,...
        segments_master);
    
    contact_pairs=find_contact_pairs(grid, node_positions,...
        segment_positions, segment_normals,node_previos);
end
if ~isempty(contact_pairs)
    contact_pairs=unique(contact_pairs,'rows');
    contact_pairs(:,1)=contact_pairs(:,1)-3;
end


end 