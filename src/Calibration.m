%% Calibration
function [q_calib, centroid_calib, dx, dy] = Calibration()
Dynamixel_Functions
dxl_start
dxl_TorqueEnable(1);
dxl_TorqueEnable(2);
dxl_TorqueEnable(3);
goHome()
dxl_TorqueDisable(1);
dxl_TorqueDisable(2);
dxl_TorqueDisable(3);
% We should find a red small object that we can use for the calibration, I
% am thinking a washer that we paint red with a sharpie.
threshold = 0.3;
[image_bw, raw_image] = getBWimage(threshold);% Get the bw image with given threshold
image_size = size(image_bw);
desired_size = image_size.*1;
image_bw = image_bw(1:210, 1:desired_size(2)); %desired_size(2)
raw_image = raw_image(1:210, 1:desired_size(2),:);
stats = regionprops(image_bw, 'Centroid', 'Area');
[centroids, areas, category] = filterObjects(stats);

%% Visualize robot position calibration
%imshow(image_bw)
mask_small_screws = category==2 | category==1;
centroids_col1 = centroids(:,1);
centroids_col2 = centroids(:,2);
small_screw_centroids = [centroids_col1(mask_small_screws), centroids_col2(mask_small_screws)];
hold off
for i = 1:size(small_screw_centroids, 1)
    figure(i)
    imshow(raw_image);
    hold on
    plot([small_screw_centroids(i,1)-10, small_screw_centroids(i,1)+10],...
        [small_screw_centroids(i,2)-10, small_screw_centroids(i,2)+10])
    x = [small_screw_centroids(i,1)];
    y = [small_screw_centroids(i,2)];
    legend(sprintf('Object %d', i));
    hold off
end

selected_centroid = input('Type the number of the desired calibration point\n');
close all;
%%


input('Press enter whenever the end effector is at the same point as the calibration\n');
q1 = dxl_CurrentPos(1);
q2 = dxl_CurrentPos(2);
q_calib = [q1, q2];
centroid_calib = small_screw_centroids(selected_centroid, :);
pause(2)

%% dx dy calibration
dxl_TorqueEnable(3)
goHome()

input('Press enter once you have placed two calibration objects\n')
figure(1)
threshold = 0.3;
[image_bw, raw_image] = getBWimage(threshold);% Get the bw image with given threshold
image_size = size(image_bw);
desired_size = image_size.*1;
image_bw = image_bw(1:desired_size(1), 1:desired_size(2));
raw_image = raw_image(1:desired_size(1), 1:desired_size(2),:);
stats = regionprops(image_bw, 'Centroid', 'Area');
[centroids, areas, category] = filterObjects(stats);% Filter the objects

mask_small_screws = category==1 | category==2;
centroids_col1 = centroids(:,1);
centroids_col2 = centroids(:,2);
small_screw_centroids = [centroids_col1(mask_small_screws), centroids_col2(mask_small_screws)];
imshow(raw_image);
hold on
for i = 1:size(small_screw_centroids, 1)
    figure(i)
    imshow(raw_image);
    hold on
    plot([small_screw_centroids(i,1)-10, small_screw_centroids(i,1)+10],...
        [small_screw_centroids(i,2)-10, small_screw_centroids(i,2)+10])
    x = [small_screw_centroids(i,1)];
    y = [small_screw_centroids(i,2)];
    legend(sprintf('Object %d', i));
    hold off
end
selected_centroids = input('Type the numbers of the desired calibration points in a vector\n');
delta_pixels = small_screw_centroids(selected_centroids(1))-small_screw_centroids(selected_centroids(2));
dist = input('Measure the distance between the points\n');
dx = dist/delta_pixels(1);
dy = dx;
end
