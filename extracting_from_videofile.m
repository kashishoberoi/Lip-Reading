function extract_frames = extract()
    video=VideoReader('video1.mp4');
    cd extracted_frames;
    for img = 1:a.NumberOfFrames;
        filename=strcat(num2str(img),'.jpg');
        b=read(a,img);
        imwrite(b,filename);
    end
    cd ..;
end