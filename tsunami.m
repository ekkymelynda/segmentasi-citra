clear all; close all; clc;
i = imread ('Satellite image.main story.jpg');
figure,imshow(i);title('Citra Asli');

rgb = rgb2gray(i);
figure,imshow(rgb);title('Citra Gray');

CitraFilter= medfilt2(rgb,[3 3]);
figure,imshow(CitraFilter);title('Citra Filter');

LowIn=double(min(min(CitraFilter)))/255;
HighIn=double(max(max(CitraFilter)))/255;
CitraAdjust= imadjust(CitraFilter,[LowIn
HighIn],[0 1]);
figure,imshow(CitraAdjust);title('Citra CitraAdjust');

t = graythresh(rgb);
CitraTepi=edge(CitraAdjust,'canny',t);
figure,imshow(CitraTepi);title('Citra CitraTepi');

se=ones (3,3);
Dilasi=imdilate(CitraTepi,se,1);
figure,imshow(Dilasi);title('Citra Dilasi');

CitraAdjustTepi=CitraAdjust;
CitraAdjustTepi(find(Dilasi==1))= 255;
figure,imshow(CitraAdjustTepi);title('Citra CitraAdjustTepi')

CitraRGB= label2rgb(CitraAdjustTepi,jet(256));
CitraRed = CitraRGB(:,:,1);
CitraRed(find(Dilasi==1))= 255;
CitraGreen= CitraRGB(:,:,2);
CitraGreen(find(Dilasi==1))=25;
CitraBlue = CitraRGB(:,:,3);
CitraBlue(find(Dilasi==1))=255;
CitraRGBjoin=cat(3,CitraRed,CitraGreen,CitraBlue);
figure,imshow(CitraRGBjoin);title('Citra CitraRGBjoin');

Pix = ginput(1);
ImgPoint=get(gca,'CurrentPoint')
XPoint = ImgPoint(1,1);
YPoint = ImgPoint(1,2);

g = splitmerge(CitraFilter, 2, @predicate);
figure,imshow(g);title('Citra Region');
g1 = im2bw(g);
sum(sum(g1))
figure,imshow(g1);title('Citra Region G1');
Pixel = sum(sum(g1))
luas = 0.019 * Pixel