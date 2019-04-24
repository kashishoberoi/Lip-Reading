function data_process = data_processing()
    video=VideoReader('HEAP.mp4');
    mean_data = csvread('mean.csv');
    std_data = csvread('std.csv');
    size_data_files = size(mean_data);
    cd extracted_frames;
    cd HEAP;
    detector = vision.CascadeObjectDetector('mouth');
    detector.MergeThreshold=50;
    area_p = [];
    width_p = [];
    height_p = [];
    for img = 1:video.NumberOfFrames;
        filename=strcat(num2str(img),'.jpg');
        img = imread(filename);
        img = imresize(img,0.2);
        temp_img=img;
        temp_img = rgb2gray(temp_img);
        temp_img = imadjust(temp_img);
        temp_img = histeq(temp_img);
        temp_img = adapthisteq(temp_img);
        bbox=step(detector,temp_img);
        area=bbox(3)*bbox(4);
        width=bbox(3);
        height=bbox(4);
        for i=2:size_data_files(1);
            z_score_area = (area-mean_data(i,1))/std_data(i,1);  
            z_score_width = (width-mean_data(i,2))/std_data(i,2);
            z_score_height = (height-mean_data(i,3))/std_data(i,3);
            area_p = [area_p,z_score_area];
            width_p = [width_p,z_score_width];
            height_p = [height_p,z_score_height];
        end
        for i=1:5;
            area_p(i) = normcdf(area_p(i)) > 0.4207 & normcdf(area_p(i)) < 0.5793;
            width_p(i) = normcdf(width_p(i)) > 0.4207 & normcdf(width_p(i)) < 0.5793;
            height_p(i) = normcdf(height_p(i)) > 0.4207 & normcdf(height_p(i)) < 0.5793;
        end
        result_p=[area_p;width_p;height_p];
        for i=1:5;
            if(result_p(1,i) & result_p(2,i) & result_p(3,i));
                if(i==2);
                   img = insertObjectAnnotation(img,'rectangle',bbox,'heap'); 
                end
            end
        end
        cd ..;
        cd ..;
        cd output_frames;
        cd HEAP;
        imwrite(img,filename);
        cd ..;
        cd ..;
        cd extracted_frames;
        cd HEAP;
    end
    cd ..;
    cd ..;
end