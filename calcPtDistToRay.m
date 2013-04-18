function dist_to_ray = calcPtDistToRay(pt_x, pt_y, ray_x, ray_y);
[proj_x proj_y] = project_pt(pt_x,pt_y, ray_x(1), ray_x(2), ray_y(1), ray_y(2));
dist_to_ray = sqrt((pt_x-proj_x).^2+(pt_y-proj_y).^2);
