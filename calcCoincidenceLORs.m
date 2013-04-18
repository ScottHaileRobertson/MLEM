function [LOR_x LOR_y, edge_x1, edge_y1, edge_x2, edge_y2] = ...
    calcCoincidenceLORs(center_angle, det_half_angle, det_diameter, ...
    bore_diameter)
det_radius = det_diameter/2;
bore_radius = bore_diameter/2;
det_center_x = det_radius*cos(center_angle);
det_center_y = det_radius*sin(center_angle);
det_edge1_x = det_radius*cos(center_angle+det_half_angle);
det_edge1_y = det_radius*sin(center_angle+det_half_angle);
det_edge2_x = det_radius*cos(center_angle-det_half_angle);
det_edge2_y = det_radius*sin(center_angle-det_half_angle);
n_det = length(det_center_x);

k=0;
n_rays = sum(1:(n_det-1));
LOR_x_all = zeros(2,n_rays);
LOR_y_all = LOR_x_all;
edge_x1_all = LOR_x_all;
edge_y1_all = LOR_x_all;
edge_x2_all = LOR_x_all;
edge_y2_all = LOR_x_all;

% Prepare a friendly waitbar since the calculation takes a bit...
h = waitbar(0,'Calculating coincidence LORs...');
proggress_multiplier = 1/(n_det+n_rays);

% Loop through all possible pairs and only add unique rays
for i=1:n_det %Starting pixel
    for j=1:n_det %Ending pixel
        % Only add rays that are unique and not starting/ending at the same point
        if((i ~= j) && ...
                ((det_center_x(i)>det_center_x(j)) || ...
                ((det_center_x(i)==det_center_x(j)) && ...
                (det_center_y(i)>det_center_y(j)))))
            k=k+1;
            LOR_x_all(:,k)=[det_center_x(i); det_center_x(j)];
            LOR_y_all(:,k)=[det_center_y(i); det_center_y(j)];
            
            edge_x1_all(:,k)=[det_edge1_x(i); det_edge2_x(j)];
            edge_y1_all(:,k)=[det_edge1_y(i); det_edge2_y(j)];
            edge_x2_all(:,k)=[det_edge2_x(i); det_edge1_x(j)];
            edge_y2_all(:,k)=[det_edge2_y(i); det_edge1_y(j)];            
        end
    end
    
    waitbar(i*proggress_multiplier,h,'Calculating coincidence LORs...');
end

% Only keep LORs that intersect the bore radius
k = 0;
for i=1:n_rays
    if((LOR_x_all(1,i)<-bore_radius) && (LOR_x_all(2,i)<-bore_radius))
        continue;
    elseif((LOR_x_all(1,i)>bore_radius) && (LOR_x_all(2,i)>bore_radius))
        continue;
    elseif((LOR_y_all(1,i)<-bore_radius) && (LOR_y_all(2,i)<-bore_radius))
        continue;
    elseif((LOR_y_all(1,i)>bore_radius) && (LOR_y_all(2,i)>bore_radius))
        continue;
    else
        k = k+1;
        LOR_x(:,k) = LOR_x_all(:,i);
        LOR_y(:,k) = LOR_y_all(:,i);
        edge_x1(:,k) = edge_x1_all(:,i);
        edge_y1(:,k) = edge_y1_all(:,i);
        edge_x2(:,k) = edge_x2_all(:,i);
        edge_y2(:,k) = edge_y2_all(:,i);
    end
    waitbar((i+n_det)*proggress_multiplier,h,'Calculating coincidence LORs...');
end

waitbar(1,h,'Finished calculating coincidence LORs.');
delete(h);