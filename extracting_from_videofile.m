function extract_frames = extract()
    video=VideoReader('HEAP.mp4');
    cd extracted_frames;
    cd HEAP;
    for img = 1:video.NumberOfFrames;
        filename=strcat(num2str(img),'.jpg');
        frame=read(video,img);
        imwrite(frame,filename);
    end
    cd ..;
    cd ..;
end