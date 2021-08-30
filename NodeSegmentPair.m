function self=NodeSegmentPair( slave_id, master_id, normal, d_min, xi, proj)

%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
% Container that describes a node/segment pair and the projection of the node on to the segment.
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
%Attributes :
%-----------
% node_id : int
%       Node ID
% proj : array
%         Node where projection is
% xi : float
%         Local coordinate of the projection on the segment
% normal : array
%         Normal vector of the segment at the point of projection
%     global_seg : tuple of int
%         Tuple that describes the segment based on the global node IDs
%--------------------------------------------------------------------------

self.slave_id = slave_id;
self.master_id = master_id;
self.normal = normal;
self.d_min = d_min;
self.proj = proj;
self.xi = xi;

end 