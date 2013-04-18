function [proj_x proj_y, r] = project_pt(pt_x, pt_y, x1, y1, x2, y2)
r = ((y1-pt_y).*(y1-y2)-(x1-pt_x).*(x2-x1))./((x2-x1).^2 + (y2-y1).^2);
proj_x = x1 + r.*(x2-x1);
proj_y = y1 + r.*(y2-y1);
