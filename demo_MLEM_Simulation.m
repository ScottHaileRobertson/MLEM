clc; clear all; close all
display_all = 1;

%% Setup PET system dimmensions
% Gantry dimmensions
det_diameter = 92.7; %cm
bore_diameter = 59; %cm

% Detector dimmensions
n_blocks_per_ring = 112;
n_det_per_block = 6;
n_norm_det = n_blocks_per_ring*n_det_per_block;
det_thickness = 3; %cm
det_circumference = pi*det_diameter;
ndw = det_circumference/n_norm_det; %cm
hrw = ndw/4; %cm
[center_angle, det_half_angle] = calcPETgeom(det_diameter, ...
    [n_norm_det], ...
    [ndw ]);

% Pixel dimmensions
im_size = 192;
[pix_bord_lsp_x pix_bord_lsp_y pix_bord_x pix_bord_y pix_cent_x pix_cent_y] ...
    = calcPixGeom(im_size, bore_diameter);

%% Calculate Coincidence LORs
[LOR_x LOR_y, edge_x1, edge_y1, edge_x2, edge_y2] = ...
    calcCoincidenceLORs(center_angle, det_half_angle, det_diameter, ...
    bore_diameter);

%% Display det geometry (if requested)
if(display_all)
    % Get figure handle
    figure();
    hold on;
    
    r_ang = 0:0.0001:2*pi;
    
    det_radius = det_diameter/2;
    bore_radius = bore_diameter/2;
    inner_det_edge_x = det_radius*cos(center_angle-det_half_angle);
    inner_det_edge_y = det_radius*sin(center_angle-det_half_angle);
    outer_det_edge_x = (det_radius+det_thickness)*cos(center_angle-det_half_angle);
    outer_det_edge_y = (det_radius+det_thickness)*sin(center_angle-det_half_angle);
    inner_det_circ_x = det_radius*cos(r_ang);
    inner_det_circ_y = det_radius*sin(r_ang);
    outer_det_circ_x = (det_radius+det_thickness)*cos(r_ang);
    outer_det_circ_y = (det_radius+det_thickness)*sin(r_ang);
    bore_circ_x = bore_radius*cos(r_ang);
    bore_circ_y = bore_radius*sin(r_ang);
    
    % Labeled lines
    plot(bore_circ_x,bore_circ_y,'--b'); % Bore circls
    plot(0,0,'+r');
    plot([inner_det_edge_x;outer_det_edge_x],[inner_det_edge_y; outer_det_edge_y],'-b'); %Cracks
    plot(inner_det_circ_x,inner_det_circ_y,'-b'); % Inner det circle
    plot(outer_det_circ_x,outer_det_circ_y,'-b'); % Outer det circle
    plot([pix_bord_x; pix_bord_x],bore_radius*[ones(size(pix_bord_x)); -ones(size(pix_bord_x))],'-k');
    plot(bore_radius*[ones(size(pix_bord_y)); -ones(size(pix_bord_y))],[pix_bord_y; pix_bord_y],'-k');
    plot(LOR_x, LOR_y,'-r');
    
    xlabel('X-Position (cm)');
    ylabel('Y-Position (cm)');
    legend('Bore','Isocenter','Detectors');
    hold off;
    axis square;
end

%% Calculate Probability Matrix
Pij = calcProbMatrix(LOR_x, LOR_y, edge_x1, edge_y1, edge_x2, edge_y2, pix_bord_lsp_x, pix_bord_lsp_y, ...
    pix_cent_x, pix_cent_y);


% Calculate simulated data with noise
im = phantom(im_size, im_size);
noise_scale = 10^4;
projections = calcProjections(im, Pij);
projections = imnoise(projections/noise_scale,'poisson')*noise_scale;

% Perform ML-EM
recon_im = ones(size(im)); % Initial guess for reconstruction
recon_im = MLEM(recon_im, projections, Pij, 10);

figure();
imagesc(recon_im);
colormap(gray);
axis image;
