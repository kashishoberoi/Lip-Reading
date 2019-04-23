function data_process = data_processing()
    video=VideoReader('video1.mp4');
    mean_data = csvread('mean.csv');
    std_data = csvread('std.csv');
    size_data_files = size(mean_data)
    cd extracted_frames;
    detector = vision.CascadeObjectDetector('mouth');
    detector.MergeThreshold=50;
    area_p = []
    width_p = []
    height_p = []
    for img = 1:a.NumberOfFrames;
        filename=strcat(num2str(img),'.jpg');
        img = imread(filename);
        bbox=step(detector,img);
        area=bbox(3)*bbox(4);
        width=bbox(3);
        height=bbox(4);
        for i=2:size_data_files(1):
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
            if(result(1,i) & result(2,i) & result(3,i));
                img = insertObjectAnnotation(img,'rectangle',bbox,char(64+i))
            end
        end
        cd ..;
        cd output_frames;
        imwrite(img,filename);
        cd ..;
        cd extracted_frames;
    end
end