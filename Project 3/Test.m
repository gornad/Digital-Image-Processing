clc;
clear all;
close all;
f=imread('lake.tif');
[M, N] = size(f);   
c = zeros(M,N);
for x = 1 : M
    for y = 1 : N
        c(x,y) = f(x,y) + (32*cos((2*pi*32*x)/N));
    end
end
imwrite(c,'corupted.tif');

im = imread('corupted.tif');
figure,imshow(im);
FT = fft2(double(im));
FT1 = fftshift(FT);%finding spectrum
imtool(abs(FT1),[]);
m = size(im,1);
n = size(im,2);

t = 0:pi/20:2*pi;
xc=(m+150)/2; % point around which we filter image
yc=(n-150)/2;
r=200;   %Radium of circular region of interest(for BRF)
r1 = 40;
xcc = r*cos(t)+xc;
ycc =  r*sin(t)+yc;

xcc1 = r1*cos(t)+xc;
ycc1 =  r1*sin(t)+yc;

mask = poly2mask(double(xcc),double(ycc), m,n);
mask1 = poly2mask(double(xcc1),double(ycc1), m,n);%generating mask for filtering

mask(mask1)=0;

FT2=FT1;
FT2(mask)=0;%cropping area or bandreject filtering

imtool(abs(FT2),[]);
output = ifft2(ifftshift(FT2));
imtool(output,[]);