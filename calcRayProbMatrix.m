function Pj = calcRayProbMatrix(ray_x, ray_y, ...
    edge1_x, edge1_y, edge2_x, edge2_y, ...
    pix_bord_lsp_x, pix_bord_lsp_y, pix_cent_x, pix_cent_y)

%Initialize image
Pj = zeros(size(pix_cent_x));

pix_half_size = (pix_bord_lsp_x(2)-pix_bord_lsp_x(1))/2;

% Calculate pixel diagonal distance
pix_diag = sqrt((pix_bord_lsp_x(1)-pix_bord_lsp_x(2))^2 + ...
    (pix_bord_lsp_y(1)-pix_bord_lsp_y(2))^2);

% Project corner of each pixel onto ray
% Corner labels: 1 2
%                3 4
corner1_in_bounds = calcPtBetweenRays(pix_cent_x-pix_half_size,...
    pix_cent_y-pix_half_size, edge1_x, edge1_y, ...
    edge2_x, edge2_y);
corner2_in_bounds = calcPtBetweenRays(pix_cent_x+pix_half_size,...
    pix_cent_y-pix_half_size, edge1_x, edge1_y, ...
    edge2_x, edge2_y);
corner3_in_bounds = calcPtBetweenRays(pix_cent_x-pix_half_size,...
    pix_cent_y+pix_half_size, edge1_x, edge1_y, ...
    edge2_x, edge2_y);
corner4_in_bounds = calcPtBetweenRays(pix_cent_x+pix_half_size,...
    pix_cent_y+pix_half_size, edge1_x, edge1_y, ...
    edge2_x, edge2_y);

% if all four corners are within bounds, set the pixel to 1
Pj(corner1_in_bounds & corner2_in_bounds & corner3_in_bounds & corner4_in_bounds) = 1;

% Handle edge around edge1

% Handle edge around edge1

% Make matrix sparse
Pj = sparse(Pj);