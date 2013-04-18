function a = MLEM(a, p, M, numItterations)
% a = activity in ith pixel
% p = measured projection in jth line of response (LOR)
% M = probability that radiation emitted from ith pixel will be detected
%     in the jth LOR

[num_LOR] = length(M);

% Calculate normalizing factor
norm_im = zeros(size(a));
num_pixels = numel(norm_im);
for j=1:num_LOR
    norm_im = norm_im + M{j};
end

% figure();
% imagesc(norm_im);
% colormap(gray);
% axis image;

% Itteratively calculate
for itter = 1:numItterations
    
    add_proj = zeros(size(a));
    for j = 1:num_LOR
        if(sum(sum(M{j}.*a))>0) % make sure you have data
            add_proj = add_proj + M{j}.*p(j)/sum(sum(M{j}.*a));
        end
    end
    
    non_zero = (norm_im~=0);
    a(non_zero)  = a(non_zero).*add_proj(non_zero)./norm_im(non_zero);
    
    figure(2);
    imagesc(a,[0 1]);
    colormap(gray);
    axis image;
    title(['Itteration:' num2str(itter)]);
    colorbar();
end

end % function
