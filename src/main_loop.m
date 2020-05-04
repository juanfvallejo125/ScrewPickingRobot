%% Main loop
arduinoSerialEnd(s)
dxl_TorqueEnable(3)
s = arduinoSerialStart;
y_pixel_size = 0.0021;
x_pixel_size = 0.0021;% Frame length from measure
q_calib = [-97.0160  117.7920];
centroid_calib = [206.1579   92.1579].*x_pixel_size;
threshold = 0.3;
xy_home = RRFDA(q_calib);
goHome()
%user_input = input('Type in a to start');
[image_bw, raw_image] = getBWimage(threshold);% Get the bw image with given threshold
image_size = size(image_bw);
desired_size = image_size.*1;
image_bw = image_bw(1:210, 1:desired_size(2));
raw_image = raw_image(1:210, 1:desired_size(2),:);
stats = regionprops(image_bw, 'Centroid', 'Area');
[centroids, areas, category] = filterObjects(stats);

%% Visualization
figure(1)
%imshow(image_bw)
mask_small_screws = category==1;
centroids_col1 = centroids(:,1);
centroids_col2 = centroids(:,2);
small_screw_centroids = [centroids_col1(mask_small_screws), centroids_col2(mask_small_screws)];
imshow(raw_image);
hold on
for i = 1:size(small_screw_centroids, 1)
    plot([small_screw_centroids(i,1)-10, small_screw_centroids(i,1)+10], [small_screw_centroids(i,2)-10, small_screw_centroids(i,2)+10], 'b')
    x = [small_screw_centroids(i,1), small_screw_centroids(i,1)+10];
    y = [small_screw_centroids(i,2), small_screw_centroids(i,2)-10];

end

%figure(2)
mask_big_screws = category==2;
centroids_col1 = centroids(:,1);
centroids_col2 = centroids(:,2);
big_screw_centroids = [centroids_col1(mask_big_screws), centroids_col2(mask_big_screws)];
%imshow(raw_image);
for i = 1:size(big_screw_centroids, 1)
    plot([big_screw_centroids(i,1)-10, big_screw_centroids(i,1)+10], [big_screw_centroids(i,2)-10, big_screw_centroids(i,2)+10],'r')
    x = [big_screw_centroids(i,1), big_screw_centroids(i,1)+10];
    y = [big_screw_centroids(i,2), big_screw_centroids(i,2)-10];

end
%% Go to position
for i = 1:size(big_screw_centroids,1)
    xy_desired = big_screw_centroids(i,:)*x_pixel_size;
    motion = (xy_desired - centroid_calib);
    rotation = [0,-1;-1,0];
    motion = rotation*motion';
    command = xy_home+motion;
    goToPos(command, 40, 'xy', 'Trapezoidal')
    waitToComplete(0.5)
    pickupScrew(s)
    pause(1)
    goHome
    dropScrew(s)
end

for i = 1:size(small_screw_centroids,1)
    xy_desired = small_screw_centroids(i,:)*x_pixel_size;
    motion = (xy_desired - centroid_calib);
    rotation = [0,-1;-1,0];
    motion = rotation*motion';
    command = xy_home+motion;
    goToPos(command, 40, 'xy', 'Trapezoidal')
    waitToComplete(0.5)
    pickupScrew(s)
    pause(1)
    goHome2
    dropScrew(s)
end
goHome()
arduinoSerialEnd(s);