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
%   7|------8|------9|  6
%    |       |       |
%   4|------5|------6|  3
%    |       |       |
%   1|------2|------3|
%    0               20
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
% Email : rahmounifaouzi01@gmail.com
%---------------------------------------
clear,clc,close all
%-----------------------------
% INITIALIZING DATA STRUCTURES
%-----------------------------
BS =[]; All = [];

% slave shape
% -----------
L = 50 ; W =9 ;     % length % width
for i = 1:15:200
    numx = i;numy = i;  % element on x,y direction  % nodes on x,y direction
    XYZ = square_node_array([0 0],[L 0],[L W],[0 W],numx+1,numy+1); % GENERATING MESH
    nodes = size(XYZ,1);
    
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
    if any(faT(:))== 0, disp(' --> there is no tool displacement, therefore may there is no contact <--');end
    if faT(1,1)~=0, fac = faT(1,1); else fac = faT(2,2); end %linear displacement
    node_positions(1:3,1)= node_previous(1:3,1);
    node_positions(4:size(node_previous,1),1)= node_previous(4:end,1)+fac ;
    node_positions(:,2) = node_previous(:,2);
    
    %Segment positions and normals
    segment_positions = gather_segment_positions(node_positions, ELXYM_Elemen_con); % segment coordinates
    % CHEEK FACE OF OUT NORMALS POSITION
    segment_normals = calculate_segment_normals(segment_positions);
    
    %----------------------------------------------------------
    % Bucketsort Method:
    % -----------------
    tic;
    if ~isempty(slave_nodes)
        slave_BS = Bucketsort (node_positions, segment_positions,...
            nodes_master, slave_nodes );
        
        
        contact_Find = find_contact_pairs(slave_BS, node_positions,...
            segment_positions, segment_normals,node_previous);
        
    else
        error(' --> there is no nodes slaves <-- ')
    end
    BS(:,size(BS,2)+1) = [toc ; nodes];
    
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
    
    All(:,size(All,2)+1) = [toc ; nodes];
    
end

% Plot
figure, hold on
plot(BS(2,:),BS(1,:),'.-','DisplayName','Bucket-Sort')
plot(All(2,:),All(1,:),'b-','DisplayName','All-to-All')
% legend('show')    % Optional legend (omitted here since we're adding text)
xlabel('Nodes (N)')
ylabel('Time (S) ')
title('Runtime of  BS and all to all methods according to increasing nodes')

disp('->> Program Finished <<-')
