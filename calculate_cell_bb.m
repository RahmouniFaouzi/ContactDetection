function  m =calculate_cell_bb(grid, cell_id)
%"""""""""""""""""""""""""""""""""""
%  Calculates a cells bounding box
%"""""""""""""""""""""""""""""""""""


x1= grid.spatial_bb(1);y1=grid.spatial_bb(2);
cel = cell_id -1;
ix =   mod( cel , grid.cell_count(1) );    
iy = floor( cel / grid.cell_count(1) ); 
min_x = x1 + ix*grid.cell_size(1);
max_x = min_x + grid.cell_size(1);
min_y = y1 + iy*grid.cell_size(2);
max_y = min_y + grid.cell_size(2);
m =[min_x, min_y, max_x, max_y];
end