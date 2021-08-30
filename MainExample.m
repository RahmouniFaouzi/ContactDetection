% Main programm for bucketSort "Example"
% -----------------------------
% Master (rigid); Slave (Deformable)
% Master shape :
% ------------
%                   3
%           |      /
%  Blengh   |alh  /  dis(2)
%           |    /    Alengh
%       2   | N /----------Gam  1
%                dis(1)
% Slave Shape :
% -----------
%  10|-----11|-----12|  9
%    |       |       |
%   7|------8|------9|  
%    |       |       |
%   4|------5|------6|  
%    |       |       |
%   1|------2|------3|
%    0               50
% Input:
%     XYZ: coordinate slave nodes
%     ELXYM_FIRST: master coordinates
%     ELXYM_second: master coordinates afetr moving
%     nodes_master: master coordinates ids
%     segments_master: master segments ids
%     ELXYM_Elemen_con :master segments conectivity
% Output
%    contact_pairs: contact node slave with Master segment after
%                   penetration
% you are free to destrubute or change this programme.
% Email : rahmounifaouzi01@gmail.com
%---------------------------------------
clear,clc,close all
%-----------------------------
% INITIALIZING DATA STRUCTURES                 
%----------------------------- 
% slave shape
% -----------
L = 50 ; W =9 ;                     % length % width
numx = 100;numy = 100;              % element on x,y direction  % nodes on x,y direction 
XYZ = square_node_array([0 0],[L 0],[L W],[0 W],numx+1,numy+1); % GENERATING MESH

% Master shape 
% ------------
Alpha=7; Gamma =2;                    % Rake and Col angles  
N=[50.9 7];                           % First point
Alength=10; Blength=10;               % lenght of segments 
Dis=[1 1];                            % Mater segment Discritization
[ELXYM_FIRST,ELXYM.Conect,ELXYM_Elemen_con] = Shape_Master(Alpha,Gamma,N,Alength,Blength,Dis);
ELXYM_second = [ELXYM_FIRST(:,1)-5, ELXYM_FIRST(:,2)]; % move the tool
segments_master = 1:size(ELXYM_Elemen_con,1);
nodes_master=1:size(ELXYM_Elemen_con,1)+1;

%-------------
% plot Shapes
figure;
hold on
plot(XYZ(:,1),XYZ(:,2),'*');
plot(ELXYM_FIRST(:,1), ELXYM_FIRST(:,2), '-*');
plot(ELXYM_second(:,1), ELXYM_second(:,2), '-*');
%axis off
hold off
%
node_previous=[ELXYM_FIRST;XYZ];
for num=1:size(XYZ,1)
    if num==size(XYZ,1)
        continue
    end
    slave_nodes(1)=4;
    slave_nodes(num+1)=4+num;%#ok<SAGROW> % matrice conectivity for nodes
end

faT=ELXYM_FIRST-ELXYM_second;
if any(faT(:))==0, disp(' --> there is no tool displacement, therefore may there is no contact <--');end
if faT(1,1)~=0, fac=faT(1,1); else fac=faT(2,2); end %linear displacement
node_positions(1:3,1)=node_previous(1:3,1);
node_positions(4:size(node_previous,1),1)=node_previous(4:end,1)+fac ;
node_positions(:,2)=node_previous(:,2);

%Segment positions and normals
segment_positions = gather_segment_positions(node_positions, ELXYM_Elemen_con); % segment coordinates
% CHEEK FACE OF OUT NORMALS POSITION 
segment_normals = calculate_segment_normals(segment_positions);

%----------------------------------------------------------
% Bucketsort Method:
% ------------------
tic;
if ~isempty(slave_nodes)
    grid = Bucketsort(node_positions, segment_positions,...
        nodes_master, slave_nodes);
    
     contact_pairs_BS = find_contact_pairs(grid, node_positions,...
         segment_positions, segment_normals,node_previous);
    
     if ~isempty(contact_pairs_BS)
         disp('contact_pairs for BS is :')
         disp('contact_nodes | segment')
         disp(contact_pairs_BS)
     else 
         disp('no contact')
     end
else 
    error(' --> there is no nodes slaves <-- ')
end
disp('Time for BS (ms) :')
disp(toc)


%----------------------------------------------------------
% all-to-all Method Checking The Whole Nodes:
% ------------------------------------------
%close all
tic;
Contact_all = [];
if ~isempty(slave_nodes)
    for q = 1:length(slave_nodes)
        S_pos = slave_nodes(:,q);
        A = [node_positions(S_pos(1),:), node_previous(S_pos(1),:)];
        for ii = 1:size(segment_positions,1)
            B = segment_positions(ii,:);
            [intersect , segm] = segment_Intersect(A,B,ii);
            
            if intersect
                counter = size(Contact_all,1)+1;
                Contact_all(counter,:) = [S_pos-3,segm];
            end
        end
    end
end

if ~isempty(Contact_all)
    disp('contact_pairs for All-tO-All is :')
    disp('contact_nodes | segment')
    disp (Contact_all)
else
    disp('no contact')
end
disp('Time for All-TO-all (ms) :')
disp (toc)


disp('->> Program Finished <<-')