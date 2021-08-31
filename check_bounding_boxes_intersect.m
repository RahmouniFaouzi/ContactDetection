function [xL,yL] = check_bounding_boxes_intersect(a, b)
%""""""""""""""""""""""""""""""""""""""""
% Check if two bounding boxes intersect
%"""""""""""""""""""""""""""""""""""""""""
%
xN = max( a(1), b(1) );
yN = max( a(2), b(2) );
xR = min( a(3), b(3) );
yT = min( a(4), b(4) );
%
if xN <= xR  && yN <= yT
    xL = xN;
else
    xL=[];
end
%
if yN <= yT
    yL = yN;
else
    yL=[];  
end
%
end