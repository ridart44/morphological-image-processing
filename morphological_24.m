% 9. Morphological Image Processing
%oleh Hanif Imam - 1706043273
% Hary Teguh Gurun Gala Ridart - 1706042882
% Muhammad Koku - 1706043203
clear all
close all

% a)
I = imread('pcb.jpg');
figure (1)
imshow(I)
title('Original Image')
figure (2)
imhist(I(:,:,1))
title('Original Image Histogram')

% b)
% Secara kasat mata, gambar a dan b tidak terlihat berbeda karena sumber gambar utama nya merupakan gambar hitam putih, 
% namun pada histogram nya, kita dapat lihat nilai sebelum gambar diubah menjadi binary image, nilai setiap pixel nya yang tadinya 0-255
% menjadi 1 atau 0 saja yakni bernilai biner. Nilai diatas 127 akan dijadikan nilai 1 sementara dibawahnya menjadi 0. Rentang lebih dari 
% 127 adalah warna putih, sebaliknya warna hitam. Nilai biner tersebut dapat ditampilkan pada bar diagram dan histogram dibawah

BW = I(:,:,1) > 127;
figure (3)
imshowpair(I,BW,'montage')
title('Comparison of Original Image and Black and White Image')
figure (4)
imhist(BW);
title('BW Image Histogram')
figure (5)
[n,x] = imhist(BW);
bar(x,n)
title('BW Image Histogram Bar')

% c)
BW2 = imfill(BW,'holes');
figure (6)
imshow(BW2);
title('Filled Image')

% d)
% Untuk mendapatkan lingkarannya, kita hanya perlu mengurangi secara logical saja antara imgfill dengar original.

figure (7)
imshowpair(BW,BW2,'montage')
title('Comparison of normal BW Image and filled BW Image')
holesBW = logical(BW2 - BW);
figure (8)
imshow(holesBW);
title('Circles in the Image')

% e)
stats1 = regionprops('table',holesBW,'Centroid','MajorAxisLength','MinorAxisLength')
centers = stats1.Centroid;
diameters = mean([stats1.MajorAxisLength stats1.MinorAxisLength],2);
disp(diameters);

hold on;
stats = regionprops(holesBW, 'Area', 'Centroid');
min_radius =  Inf;
max_radius = -Inf;
for k = 1:length(stats)
    radius = sqrt(stats(k).Area/pi);
    min_radius = min(min_radius, radius);
    max_radius = max(max_radius, radius);
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
    text(centroid(1)+2, centroid(2), sprintf('%.1f',2*radius) ,'Color', 'r', 'FontSize', 24, 'FontWeight', 'bold');
end
drawnow();
