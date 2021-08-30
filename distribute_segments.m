function cells=distribute_segments( segment_positions, segment_ids,num_cells,MAX_ELEMENTS_PER_CELL)
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
%Distributes segments into cells for a given grid, based on the segments node positions.
%           |-----------------|
%         3 |  |--3--|-----|  |4        cell1: 1 4  distrubute segment example        
%           | 4|     |     |  |         cell2: 1 2
%           ---|-----|---2-|--|         cell3: 3 4
%           |  |    1|     |  |         cell4: 2 3
%           |  |-----|-----|  | 
%           |-----------------|
%               1       2 
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cells = zeros(num_cells, MAX_ELEMENTS_PER_CELL);
cells_count = ones(num_cells,1);
for Num=1:size(segment_ids,2)
    segment_id=segment_ids(Num);
    node_1 = segment_positions(segment_id, 1:2);
    node_2 = segment_positions(segment_id, 3:4);
    for I=1:2
        if I==1
            node_pos=node_1;
        else
            node_pos=node_2;
        end
        cell_ids(I) = get_cell_number(node_pos);
    end
    cell_ids=unique(cell_ids);
    for L=1:size(cell_ids,2)
        cell_id=cell_ids(L);
        if  1 <= cell_id && cell_id <= num_cells
            cells(cell_id, cells_count(cell_id)) = segment_id;
            cells_count(cell_id) = cells_count(cell_id)+1;
        else
            continue
        end
    end
end

end
