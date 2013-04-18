function in_bounds = calcPtBetweenRays(pt_x, pt_y, ray1_x, ray1_y, ...
    ray2_x, ray2_y)

if((ray1_x(1) == ray1_x(2)) & (ray1_y(1) == ray1_y(2)))
    % make ray 1 of non zero length in direction of ray 2
    ray1_x(2) = ray1_x(2) + (ray2_x(1)-ray2_x(2));
    ray1_y(2) = ray1_y(2) + (ray2_y(1)-ray2_y(2));
end

% Project point onto both edges
[proj_x_edge proj_y_edge, r] = project_pt(pt_x,pt_y, ray1_x(1), ray1_y(1),ray1_x(2), ray1_y(2));
[edge_int_x edge_int_y] = calcIntersection(pt_x, pt_y, proj_x_edge, proj_y_edge, ...
    ray2_x(1), ray2_y(1), ray2_x(2), ray2_y(2));
[junk2 junk2, r] = project_pt(pt_x,pt_y, proj_x_edge, proj_y_edge, edge_int_x, edge_int_y);

% Find out if the point lies between or on the two edges
in_bounds = ((r>=0) & (r<=1));


