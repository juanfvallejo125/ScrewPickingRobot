function [image_bw, raw_image] = getBWimage(threshold,img)
%% Matlab Image Processing Algorithm Shell Program


image = img;%(capture_script()); %truecolor image is mxnx3
raw_image = image;
%% testing with preloaded image
% image = imread('img5.jpg');
imshow(image);
%% Identify shapes
image_bw = imbinarize(rgb2gray(image),threshold); %take image from true color to bw
imshow(image_bw)
% imshowpair(image,image_bw,'montage');
% image_bw = bw_filter;
image_bw = imcomplement(image_bw);
end