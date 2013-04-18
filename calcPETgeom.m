function [center_angle, det_half_angle] = calcPETgeom(det_diameter, ...
    det_cnts, det_arclengths, varargin)
tol = 10^-13;

% Calculate differential angles (in radians) of each detector size
det_circumference = pi*det_diameter;
det_angles = 2*det_arclengths/det_diameter;%radians

%Check that we have a full ring of detectors (not more or less)
if(abs(sum(det_angles.*det_cnts)-2*pi)>tol)
    error(['You must fill the detector array exactly (currently using ' num2str(sum(det_angles.*det_cnts)) ' of 2\pi radians']);
end

n_det_groups = length(det_cnts);
det_indiv_angle=[];
for i=1:n_det_groups
    group_angle_sz = det_angles(i);
    n_det_in_group = det_cnts(i);
    
    % This is very sloppy... should preallocate, but we have plenty of
    % memory to be lazy at this point :)
    det_indiv_angle = [det_indiv_angle group_angle_sz*ones(1,n_det_in_group)];
end

% Calculate half angles
det_half_angle = det_indiv_angle/2;

% Create detector center angles
center_angle = cumsum(det_indiv_angle) - det_half_angle;