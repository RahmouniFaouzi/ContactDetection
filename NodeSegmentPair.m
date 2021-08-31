function self=NodeSegmentPair( slave_id, master_id, normal, d_min, xi, proj)

%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
% Container that describes a node/segment pair and the projection of the node on to the segment.
%"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

self.slave_id = slave_id;
self.master_id = master_id;
self.normal = normal;
self.d_min = d_min;
self.proj = proj;
self.xi = xi;

end 