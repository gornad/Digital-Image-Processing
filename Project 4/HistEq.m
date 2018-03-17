%%%%%%%%%%%%% The HistEq.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Equalizes image and provides histogram and cdf of that image
%
% Input Variables:
%      Input 2D image
%      
% Returned Results:
%      Equalized image
%      Histogram and CDF of image
%
%  Date:        11/1/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

b=imread('truck.gif');
figure(1);
imshow(b), title('ORIGINAL IMAGE');

% Perform histogram equalization
for i=1:256
    a(i)=0;
end
row=size(b,1);
col=size(b,2);
for k=1:row
    for m=1:col
        for i=1:256
            if b(k,m)==(i)-1
                a(i)=a(i)+1;
           
            end
        end
    end
end

for i=1:256
    if i==1
        c(i)=a(i);
    else
        c(i)=c(i-1)+a(i);
    end
end


for i=1:256
    d(i)=round((c(i)/c(256))*255);
end

        
for k=1:row
    for m=1:col
                img(k,m)=d(b(k,m)+1);
    end
end
figure(2);
imshow(uint8(img)), title('EQUALIZED IMAGE');
imwrite(img,'HistEqImg.gif');

g=imread('HistEqImg.gif');

% Histogram of equalized image
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
figure(3);
plot(t)
stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE EQUALIZED IMAGE')


% CDF of equalized image
tsum = sum(t);
n_sum = t/tsum;
cdf=t;

for i = 1:length(t)
    cdf(i) = sum(n_sum(1:i));
end
figure(4);
plot(cdf);
title('CDF OF EQUALIZED IMAGE');