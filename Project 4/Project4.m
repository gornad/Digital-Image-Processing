%%%%%%%%%%%%% The Project4.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Produces histogram and cdf of original image
%      Performs contrast stretching
%
% Input Variables:
%      Input 2D image
%      
% Returned Results:
%      Streched image
%      Stretched CDF
%      CDF and histogram of original and stretched image 
%
%  Date:        11/1/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear all; 
close all;
g=imread('truck.gif');
figure(1);
imshow(g),title('ORIGINAL IMAGE')

% Histogram of original image
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
figure(2);
plot(t)
stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); 
title('HISTOGRAM OF THE ORIGINAL IMAGE');


% CDF of original image
tsum = sum(t);
n_sum = t/tsum;
cdf=t;

for i = 1:length(t)
    cdf(i) = sum(n_sum(1:i));
end
figure(3);
plot(cdf);
title('CDF OF ORIGINAL IMAGE');
L1=0;
L2=255;

% Question 3
cdfstretch = cdf;

% Find L1 and L2
for i = 1:length(cdfstretch)
    if(cdfstretch(i)<=0.1)
        if(i>L1)
            L1 = i+1;
        end
        cdfstretch(i)=0;
    elseif(cdfstretch(i)>=0.9)
        if(i<L2)
            L2 = i-1;
        end
        cdfstretch(i)=1;
    end
end

% Get stretched CDF
for i = 1:length(cdfstretch)
    m = 255/(L2-L1);
    if(cdfstretch(i) == 0 || cdfstretch(i) == 1)
        cdfstretch(i) = cdfstretch(i)*255;
    else
        cdfstretch(i) = m*i - m*L1;
    end
end

%disp(L1);
%disp(L2);
figure(4);
plot(cdfstretch);
title('STRETCHED CDF');
gstretched = g;

% Linearly stretch image
for i = 1:M
    for j = 1:N
        if(gstretched(i,j) <= L1)
            gstretched(i,j) = 0;
        elseif (gstretched(i,j) >= L2)
            gstretched(i,j) = 255;
        else
            gstretched(i,j)= round((gstretched(i,j)-L1)*m);
        end
    end
end
figure(5);
imshow(uint8(gstretched)),title('LINEARLY STRETCHED IMAGE');

% Histogram of stretched image
[M,N]=size(gstretched);
t=1:256;
n=0:255;
count=0;

for z=1:256
    for i=1:M
        for j=1:N
            
            if gstretched(i,j)==z-1
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
xlabel('intensity levels---->'); title('HISTOGRAM OF THE STRETCHED IMAGE')


% CDF of stretched image
tsum = sum(t);
n_sum = t/tsum;
cdf=t;

for i = 1:length(t)
    cdf(i) = sum(n_sum(1:i));
end
figure(7);
plot(cdf);ylim([0.0 1.0]);
title('CDF OF STRETCHED IMAGE');