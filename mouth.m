img = imread(img_name);
temp_img=img;
temp_img = rgb2gray(temp_img);
temp_img = imadjust(temp_img);
temp_img = histeq(temp_img);
temp_img = adapthisteq(temp_img);
detector=vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=150;
bbox=step(detector,pout_histeq);
out=insertObjectAnnotation(pout_histeq,'rectangle',...
    bbox,'rahul');
imshow(out);