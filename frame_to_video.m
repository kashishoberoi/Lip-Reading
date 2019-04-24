video=VideoReader('HEAP.mp4');
    cd extracted_frames;
    cd HEAP;
for i = 1:66;
   filename=strcat(num2str(img),'.jpg');
   img = imread(filename);
    M(i)=getframe(img); 
end
% Output the movie as an avi file
movie2avi(M,'HEAP.avi');