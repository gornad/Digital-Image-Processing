%%%%%%%%%%%%% The Gamma.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Performs gamma correction on image
%
% Input Variables:
%      Input 2D image
%      
% Returned Results:
%      Powerlaw transformed gamma = 0.2 and gamma = 5 images
%      CDF and histograms of transformed images
%
%  Date:        11/1/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all
close all
a=imread('truck.gif');

gamma=5;
d=255*(double(a)/255).^gamma;
figure(1);
imshow(a),title('ORIGINAL IMAGE')
figure(2);
imshow(uint8(d)),title('POWERLAW TRANSOFRMATION WITH GAMMA=5.0');
imwrite(d,'Gamma5.gif')
gamma1=0.2;
d1=255*(double(a)/255).^gamma1;
figure(3);
imshow(uint8(d1)),title('POWERLAW TRANSFORMATION WITH GAMMA=0.2');
imwrite(d1,'Gamma0.2.gif')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histogram of gamma = 5 image
g=imread('Gamma5.gif');

[M,N]=size(g);

t=1:256;
n=0:255;
count=0;

for z=1:256
    for i=1:M
        for j=1:N
            
            if g(i,j)==z-1
                count=count+1;
            end
        end
    end
            t(z)=count;
            count=0;
end
figure(4);
plot(t)
stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE GAMMA=5.0 IMAGE')


% CDF of gamma = 5 image
tsum = sum(t);
n_sum = t/tsum;
cdf=t;

for i = 1:length(t)
    cdf(i) = sum(n_sum(1:i));
end
figure(5);
plot(cdf);
title('CDF OF GAMMA=5.0 IMAGE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histogram of gamma = 0.2 image
g=imread('Gamma0.2.gif');

[M,N]=size(g);

t=1:256;
n=0:255;
count=0;

for z=1:256
    for i=1:M
        for j=1:N
            
            if g(i,j)==z-1
                count=count+1;
            end
        end
    end
            t(z)=count;
            count=0;
end
figure(6);
plot(t)
stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE GAMMA=0.2 IMAGE')


% CDF of gamma = 0.2 image
tsum = sum(t);
n_sum = t/tsum;
cdf=t;

for i = 1:length(t)
    cdf(i) = sum(n_sum(1:i));
end
figure(7);
plot(cdf);
title('CDF OF GAMMA=0.2 IMAGE');
