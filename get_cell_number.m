function A_D= get_cell_number(pos)
%-----------------------------------------------------------
%  Returns a positions corresponding cell index in a grid
%           --------------------
%           |        |         | 
%           |   3    |     4   | 
%           --------------------
%           |        |         | 
%           |   1    |    2    | 
%           --------------------
%
%-----------------------------------------------------------
%clear, clc
global spatial_bb cell_size cell_count
% spatial_bb=[5 0];
% cell_size=[5 5];cell_count=[1 1];
% pos=[6 5];
x1 = spatial_bb(1);y1=spatial_bb(2);
x = pos(1);y=pos(2);
cell_dx = cell_size(1); cell_dy=cell_size(2);
A_D =(floor(abs((x-x1)/cell_dx)) + floor(abs((y-y1)/cell_dy)) * cell_count(1))+1;

end 