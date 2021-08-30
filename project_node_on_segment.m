function [xi, proj] = project_node_on_segment(segment_position,node_position)
%""""""""""""""""""""""""""""""""""""""""""
% Projects a node on to a (linear) segment
%""""""""""""""""""""""""""""""""""""""""""
%
%  proj : Node where projection is
%  xi   : Local coordinate of the projection on the segment
%
%"""""""""""""""""""""""""""""""""""""""""""""""

a = segment_position(1:2);b= segment_position(3:4); 
c = node_position;
ba = b-a;
ca = c-a;
xi = dot(ca,ba) / dot(ba,ba);
proj=a + (b-a)*xi;

% for elment Q4
% if (element_segment_id >4) || (element_segment_id <1)
%     disp('Invalid segment ID provided')
% end

end 

    
    