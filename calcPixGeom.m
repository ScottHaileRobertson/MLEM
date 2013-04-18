function [pix_bord_lsp_x pix_bord_lsp_y pix_bord_x pix_bord_y pix_cent_x ...
    pix_cent_y] = calcPixGeom(im_size, bore_diameter)
% Calculate bore radius;
bore_radius = bore_diameter/2;

pix_bord_lsp_x = linspace(-bore_radius,bore_radius,im_size+1);
pix_bord_lsp_y = pix_bord_lsp_x;
[pix_bord_x pix_bord_y] = meshgrid(pix_bord_lsp_x, pix_bord_lsp_y);
linsp_pix_cent = pix_bord_lsp_x + (pix_bord_lsp_x(2)-pix_bord_lsp_x(1))/2;
linsp_pix_cent = linsp_pix_cent(1:(end-1));
[pix_cent_x pix_cent_y] = meshgrid(linsp_pix_cent, linsp_pix_cent);
