x = 0.5;
y = 0.5;
ray_x = [0; 0];
ray_y = [0; 1];
[px py]=project_pt(x, y, ray_x, ray_y);

figure();
hold on;
plot(ray_x, ray_y,'-b');
plot(x,y,'xb');
plot(px,py,'xr');
hold off;
axis equal
