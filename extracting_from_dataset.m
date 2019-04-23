function a_calc = a_cal()
    cd dataset;
    cd o;
    a_val=zeros(50,3);
    detector = vision.CascadeObjectDetector('mouth');
    detector.MergeThreshold=150;
    for i =1:50
            img_name=strcat(num2str(i),'.jpg');
            img = imread(img_name);
            img = imresize(img,0.2);
            temp_img=img;
            temp_img = rgb2gray(temp_img);
            temp_img = imadjust(temp_img);
            temp_img = histeq(temp_img);
            temp_img = adapthisteq(temp_img);
            bbox=step(detector,temp_img);
            x=size(bbox)
            if x(1)==1;
                area=bbox(3)*bbox(4);
                width=bbox(3);
                height=bbox(4);
                a_val(i,1)=area;
                a_val(i,2)=width;
                a_val(i,3)=height;
            end
    end
    result_mean = mean(a_val);
    result_std=std(a_val);
    cd ..;
    cd ..;
    x = csvread('mean.csv');
    x_size=size(x);
    x_row=x_size(1);
    y = csvread('std.csv');
    y_size=size(y);
    y_row=y_size(1);
    x(x_row+1,:)=result_mean;
    y(y_row+1,:)=result_std;
    csvwrite('mean.csv',x)
    csvwrite('std.csv',y)
end