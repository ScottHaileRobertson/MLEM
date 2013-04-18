function [int_x int_y] = calcIntersection(x1, y1, x2, y2, x3, y3, x4, y4)
denom = (x1-x2).*(y3-y4)-(y1-y2).*(x3-x4);
int_x = ((x1.*y2-y1.*x2).*(x3-x4)-(x1-x2).*(x3.*y4-y3.*x4))./denom;
int_y = ((x1.*y2-y1.*x2).*(y3-y4)-(y1-y2).*(x3.*y4-y3.*x4))./denom;


