%% Matlab Image Processing Algorithm Shell Program


image = (capture_script()); %truecolor image is mxnx3
%% testing with preloaded image
% image = imread('img5.jpg');
imshow(image);
%% Identify shapes
image_bw = imbinarize(rgb2gray(image),0.3); %take image from true color to bw
% imshowpair(image,image_bw,'montage');
% image_bw = bw_filter;
image_bw = imcomplement(image_bw);
bolts = bwlabel(image_bw(:,:,1));
%% Work through each connected blob
num_conn = max(max(bolts(:,:,1))); % count number of blobs
mag = []; %prepare to record each blob size
rc = {}; %cell structure containing the row/col coords of cound blobs
good_blob_count= 0;
dummy = image_bw(:,:,1);
dummy(:,:) = 0;
for i = 1:num_conn
    [r, c] = find(bolts(:,:,1)==i);
    len = length(r)
    if len > 17 && len < 35 || len > 60 && len < 90 %only add a blob if it is sized right
        mag = [mag length(r)]; %admit blob into mag if not spec or negative
        good_blob_count = good_blob_count + 1;
        rc{good_blob_count} = [r c]; %store row/col indices of good blobs
        %check identification below
        clear figure
        figure(good_blob_count)
        dummy(rc{good_blob_count}(:,1),rc{good_blob_count}(:,2)) = 1; %this is a check, setting everything but bolt to black
        imshowpair(image_bw,dummy,'montage');
    end
end

%% Get coordinates for the shapes
x1 = mean(rc{1}(:,2)); % command position as average of blob
y1 = mean(rc{1}(:,1)); %coordinates expanded like this for readability
x2 = mean(rc{2}(:,2)); %second bolt (column)
y2 = mean(rc{2}(:,1)); %second bolt y (row))
pos_1 = [x1 y1];
pos_2 = [x2 y2];

%% Plot the shapes
for i = 1:good_blob_count
    xi = mean(rc{i}(:,2)); % command position as average of blob
    yi = mean(rc{i}(:,1)); %coordinates expanded like this for readability
    pos_i = [x1 y1];
    marked_i = insertShape(image,'circle',[pos_i(1) pos_i(2) 10],'LineWidth',3);
    imshow(marked_i)
end

marked_1 = insertShape(image,'circle',[pos_1(1) pos_1(2) 10],'LineWidth',3);
marked_2 = insertShape(marked_1,'circle',[pos_2(1) pos_2(2) 10],'LineWidth',3);
imshow(marked_2) %if i get the computer vision toolbox
% 
% figure(2),imshow(image)
% hold on
% plot([pos_1(1),pos_2(1)],[pos_1(2),pos_2(2)],'Color','r','LineWidth',2)
% hold off
