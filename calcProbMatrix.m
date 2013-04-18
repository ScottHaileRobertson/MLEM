function Pij = calcProbMatrix(LOR_x, LOR_y, edge_x1, edge_y1, edge_x2, ...
    edge_y2, pix_bord_lsp_x, pix_bord_lsp_y, ...
    pix_cent_x, pix_cent_y)

n_LOR = length(LOR_x);
Pij = cell(n_LOR,1);

% Calculate diagonal of pixel
pix_diag = sqrt((pix_bord_lsp_x(1)-pix_bord_lsp_x(2))^2 + ...
    (pix_bord_lsp_y(1)-pix_bord_lsp_y(2))^2);

% Prepare a friendly waitbar since the calculation takes a bit...
h = waitbar(0,'Calculating Pij matrix...');
proggress_multiplier = 1/n_LOR;
for i = 1:n_LOR
    Pij(i) = {calcRayProbMatrix(LOR_x(:,i), LOR_y(:,i), ...
        edge_x1(:,i), edge_y1(:,i), edge_x2(:,i), edge_y2(:,i), ...
        pix_bord_lsp_x, pix_bord_lsp_y, pix_cent_x, pix_cent_y)};
    
    waitbar(i*proggress_multiplier,h,'Calculating Pij matrix...');
end
waitbar(1,h,'Finished calculating Pij matrix.');
delete(h);
