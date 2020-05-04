function [centroids, areas, category] = filterObjects(stats)
num_blobs = length(stats);
category = zeros(num_blobs,1);
centroids = zeros(num_blobs, 2);
areas = zeros(num_blobs,1);

for i = 1:length(stats)
    area = stats(i).Area;
    centroid = stats(i).Centroid;
   if(area>=5 & area<=45)
       category(i) = 1;
   elseif(area>=46 & area<=150)
       category(i) = 2;
   else
       category(i) = 0;
   end
   areas(i) = area;
   centroids(i,:) = centroid;
   
end
mask = category>0;

centroids_col1 = centroids(:,1);
centroids_col2 = centroids(:,2);
centroids = [centroids_col1(mask),centroids_col2(mask)];
areas = areas(mask);
category = category(mask);
end