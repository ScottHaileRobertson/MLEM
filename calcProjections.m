function projections = calcProjections(im, Pij)
% % Calculate projections
n_LOR = length(Pij);
projections = zeros([n_LOR 1]);

% Prepare a friendly waitbar since the calculation takes a bit...
h = waitbar(0,'Calculating projections...');
proggress_multiplier = 1/n_LOR;
for j=1:n_LOR
    projections(j) = sum(sum(Pij{j}.*im));
    
    waitbar(j*proggress_multiplier,h,'Calculating projections...');
end
waitbar(1,h,'Finished calculating projections.');
delete(h);