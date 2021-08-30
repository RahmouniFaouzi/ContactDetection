function neighbours=get_cell_neighbourhood(grid, cell_id)
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
%Determines 'neighbourhood' of cells around a particular cell, including the cell itself
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

% Cells per row
cpr = grid.cell_count(1);

% Immediate neighbours cells for cell_id
neighbour = [cell_id;
             cell_id-1;
             cell_id+1;
             cell_id+cpr;
             cell_id-cpr;
             cell_id+cpr-1;
             cell_id-cpr-1;
             cell_id+cpr+1;
             cell_id-cpr+1];

% Filter - make sure cells are valid
% ------------------------------------
neighbours=[];
for call=1:size(neighbour,1)
    cell_id =  neighbour(call);
    if  1 <= cell_id && cell_id <= grid.num_cells
        count=size(neighbours,2)+1;
        neighbours(count) = cell_id; 
    end  
end

% 
neighbours=unique(neighbours);

% Exception of neighbers cells 
cell_id=cell_id+cpr-1;
if cell_id == 1 && grid.num_cells > 4
    Del_Factors=find(neighbours==(cell_id+cpr-1));
    neighbours(Del_Factors)=[];
elseif cell_id==grid.num_cells && grid.num_cells > 4
    Del_Factors=find(neighbours==(cell_id-cpr+1));
    neighbours(Del_Factors)=[];
elseif cell_id==cpr+1 && grid.num_cells > 4
    Del_Factors(1)=find(neighbours==(cpr));
    Del_Factors(2)=find(neighbours==(2*cpr));
    neighbours(Del_Factors)=[];
elseif cell_id==grid.num_cells-cpr && grid.num_cells > 4
    Del_Factors(1)=find(neighbours==(grid.num_cells-cpr+1));
    Del_Factors(2)=find(neighbours==(grid.num_cells-(2*cpr)+1));
    neighbours(Del_Factors)=[];
end
for Num=1:(grid.cell_count(2)-3)
    if cell_id==((Num+1)*cpr)+1 && grid.num_cells > 4
        Del_Factors(1)=find(neighbours==(cell_id+cpr-1));
        Del_Factors(2)=find(neighbours==(cell_id-1));
        Del_Factors(3)=find(neighbours==(cell_id-cpr-1));
        neighbours(Del_Factors)=[];
    elseif cell_id==grid.num_cells-((Num+1)*cpr) && grid.num_cells > 4
        Del_Factors(1)=find(neighbours==(cell_id+cpr+1));
        Del_Factors(2)=find(neighbours==(cell_id+1));
        Del_Factors(3)=find(neighbours==(cell_id-cpr+1));
        neighbours(Del_Factors)=[];
        
    end
end
%------------------------------------------------------------