function contact_Find = find_contact_pairs( slave_BS, node_positions, segment_positions, segment_normals,node_previous)
%""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
% Finds node-segment pairs that have penetrated (i.e. are in contact)
%""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

% Calculate Contact-pairs 
%-------------
contact_Find = [];
if ~isempty(slave_BS)
    for q = 1:length(slave_BS)
        S_pos = slave_BS(:,q);
        
        A = [node_positions(S_pos(1)+3,:), node_previous(S_pos(1)+3,:)];
        for ii = 1:size(segment_positions,1)
            B = segment_positions(ii,:);
            [intersect , segm] = segment_Intersect(A,B,ii);
            
            if intersect
                counter = size(contact_Find,1)+1;
                contact_Find(counter,:) = [S_pos,segm];
            end
        end
    end
end

% % Calculate Contact Gap
% %------------------------
% for i=1 : size(contact_Find,1)
% SM= [node_positions(contact_Find(i,1)+3,:) segment_positions(contact_Find(i,2),:)];
% SM= reshape (SM,2,3);
%     
% XT = SM(:,3)-SM(:,2);   % tengentiel vector  
% XDEN = norm(XT);        % norm tengentiel vector
% 
% % UNIT NORMAL AND TANGENTIAL VECTOR
% XT = XT/XDEN;         %  unit tengentiel vector
% XN = [-XT(2); XT(1)]; %  normal vector
% 
% % NORMAL GAP FUNCTION Gn = (X_s - X_M).N
% GAP(i) = (SM(:,1) - SM(:,2))'*XN;
% end



