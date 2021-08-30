function [ intersect , b ] = segment_Intersect(A,B,ii)
%"""""""""""""""""""""""""""""""""""""""""""""""
% Two segment Intersect from Coordinates A and B
%"""""""""""""""""""""""""""""""""""""""""""""""
a = A(1:2)'; b = A(3:4)';
c = B(1:2)'; d = B(3:4)';
r = (b - a);
s = (d - c);
fac=(c - a);
d=(r(1)*s(2))-(r(2)*s(1));     % cross(r,s)
fac1=fac(1)*r(2)-fac(2)*r(1);  % cross(fac,r)
fac2=fac(1)*s(2)-fac(2)*s(1);  % cross(fac,s)
u = fac1/d;
t = fac2/d;
if  (0 <= u && u <= 1) && (0 <= t && t <= 1) 
    intersect = 1; b = ii;
else 
    intersect = 0; b =[];
end
% % Intersect point 
% cheek1 = a+(t*r);
% cheek2 = c+(u*s);
% if cheek1 == cheek1
%     point_intersect = cheek1;
% else
%     point_intersect = [];
% end 
    
end