im1 = img_all(:, :, 1);
im2 = circshift(img_all(:, :, 2), -1, 1);
im3 = circshift(imrotate(circshift(img_all(:, :, 3), -3, 1), -1, 'crop'), 1, 2);
im4 = circshift(imrotate(circshift(img_all(:, :, 4), -4, 1), -1, 'crop'), 1, 2);

img_all = cat(3, im1, im2, im3, im4);
figure;
imagesc3D(cat(3, im1, im2, im3, im4));
colormap(gray);