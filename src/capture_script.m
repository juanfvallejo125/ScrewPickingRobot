function image = capture_script()
% URL to get a camera snapshot
url='http://192.168.0.20/image.jpg';
img_file='image.jpg';  % temporary file used to store the camera image
user='admin';       % username and password used to perform authentication
pass='';

read_option = 1;
for i = 1
    
    if read_option == 1
        % OPTION 1 - save then load image
        % grab the camera image and store it in a local temporary file
        file_name = urlwrite(url,img_file,'Authentication','Basic','Username',user,'Password',pass);
        % show the camera image and delete the local temporary file
        cam_capture = imread(img_file);
    else
        % OPTION 2 - "stream" image
        cam_capture = imread(url,user,pass);
    end
    % show image
    %imshow(cam_capture);
    pause(0.03);
end

% Clean up temp files
if read_option == 1
    delete(img_file);
end

image = cam_capture;
end