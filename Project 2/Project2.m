%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Perform connected-component processing and logical set operations  
%
% Input Variables:
%      A, B    rows and columns
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      num     number of connected components
%  
%      
% Returned Results:
%      fthresh, fRGB, fRGB1, fRGB2, fRGB3, fRGB4, ANDimages, ORimages,
%      NOTimages, XORimages, E
%
% Processing Flow:
%      Described in report
%
%  Authors:      Ritvik Muralidharan, Georges Junior Naddaf, Zian Wang
%  Date:        09/22/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


% 1(a) 
% We simply iterate over the image and set a threshold of 190. 
% Whenever we detect a pixel that is bright (grey value>=190), we make it completely bright (=255) and if the pixel is not bright, 
% we darken it completely (grey value=0). This will result in an image with distinct bright pixels and will allows us 
%to perform connected-component analysis of the image.

f = imread('wheelnoise.gif');
[A,B]= size(f);
for x=1:A
    for y=1:B
        if f(x,y)>= 190;
            fthresh(x,y)=255;
        else
            fthresh(x,y)=0;
        end
    end
end

imtool(fthresh)
imwrite(fthresh, 'fthresh.tif');

% 1(b)
% We use the functions specified in the prompt. 
% Bwlabel() labels the image and colors all connected components in unique colors and assigns each a unique integer. 
% Then we use label2rgb() to output and display the image.

[flabel,num] = bwlabel(fthresh,8)
fRGB = label2rgb(flabel);
imtool(fRGB);
imwrite(fRGB, 'fRGB.jpg');

% 1(c)
% Explained in detail in report
% Produces largest connected compoenents

qwe = num;
store = 0;
store1 = 0;
store2 = 0;
store3 = 0;
fnew = flabel(:,:,1);

% Largest
for z=1:qwe
    for x=1:A
        for y=1:B
            if fnew(x,y)==z;
                ftest(x,y)=fnew(x,y);
            else
                ftest(x,y)=0;
            end
        end
    end
    counter = 0;
    x=1;
    y=1;
    for x=1:A
        for y=1:B
            if ftest(x,y)~= 0;
                counter=counter+1;
            end
        end
    end
    temp = counter;
    if temp > store;
        codenum = z;
        store = temp;
    end
end
%
    for x=1:A
        for y=1:B
            if fnew(x,y)==codenum;
                f1stbw(x,y)=fnew(x,y);
            else
                f1stbw(x,y)=0;
            end
        end
    end


fRGB1 = label2rgb(f1stbw);

[r c z] = size(fRGB1);

for i=1:r
      for j=1:c
          if ((fRGB1(i,j,1)==0 && fRGB1(i,j,2)==255 && fRGB1(i,j,3)==255)) 
          fRGB1(i,j,1)=0; fRGB1(i,j,2)=0; fRGB1(i,j,3)=128;
          else
          fRGB1(i,j,1)=255; fRGB1(i,j,2)=255; fRGB1(i,j,3)=255;
          end
      end
end

imtool(fRGB1);
imwrite(fRGB1, 'fRGB1.jpg');
%%%Second Largest


for z=1:qwe
    for x=1:A
        for y=1:B
            if (fnew(x,y)==z && fnew(x,y)~=codenum);
                ftest(x,y)=fnew(x,y);
            else
                ftest(x,y)=0;
            end
        end
    end
    counter1 = 0;
    x=1;
    y=1;
    for x=1:A
        for y=1:B
            if ftest(x,y)~= 0;
                counter1=counter1+1;
            end
        end
    end
    temp1 = counter1;
    if temp1 > store1;
        codenum1 = z;
        store1 = temp1;
    end
end
%
    for x=1:A
        for y=1:B
            if fnew(x,y)==codenum1;
                f2ndbw(x,y)=fnew(x,y);
            else
                f2ndbw(x,y)=0;
            end
        end
    end


fRGB2 = label2rgb(f2ndbw);

[r c z] = size(fRGB2);

for i=1:r
      for j=1:c
          if ((fRGB2(i,j,1)==128 && fRGB2(i,j,2)==0 && fRGB2(i,j,3)==0)) 
          fRGB2(i,j,1)=255; fRGB2(i,j,2)=144; fRGB2(i,j,3)=0;
          else
          fRGB2(i,j,1)=255; fRGB2(i,j,2)=255; fRGB2(i,j,3)=255;
          end
      end
end

imtool(fRGB2);
imwrite(fRGB2, 'fRGB2.jpg');

% Third Largest
for z=1:qwe
    for x=1:A
        for y=1:B
            if (fnew(x,y)==z && fnew(x,y)~=codenum && fnew(x,y)~=codenum1 );
                ftest(x,y)=fnew(x,y);
            else
                ftest(x,y)=0;
            end
        end
    end
    counter2 = 0;
    x=1;
    y=1;
    for x=1:A
        for y=1:B
            if ftest(x,y)~= 0;
                counter2=counter2+1;
            end
        end
    end
    temp2 = counter2;
    if temp2 > store2;
        codenum2 = z;
        store2 = temp2;
    end
end
%
    for x=1:A
        for y=1:B
            if fnew(x,y)==codenum2;
                f3rdbw(x,y)=fnew(x,y);
            else
                f3rdbw(x,y)=0;
            end
        end
    end

fRGB3 = label2rgb(f3rdbw);

[r c z] = size(fRGB3);

for i=1:r
      for j=1:c
          if ((fRGB3(i,j,1)==130 && fRGB3(i,j,2)==0 && fRGB3(i,j,3)==0)) 
          fRGB3(i,j,1)=255; fRGB3(i,j,2)=219; fRGB3(i,j,3)=0;
          else
          fRGB3(i,j,1)=255; fRGB3(i,j,2)=255; fRGB3(i,j,3)=255;
          end
      end
end

imtool(fRGB3);
imwrite(fRGB3, 'fRGB3.jpg');

% Fourth Largest
for z=1:qwe
    for x=1:A
        for y=1:B
            if (fnew(x,y)==z && fnew(x,y)~=codenum && fnew(x,y)~=codenum1 && fnew(x,y)~=codenum2 );
                ftest(x,y)=fnew(x,y);
            else
                ftest(x,y)=0;
            end
        end
    end
    counter3 = 0;
    x=1;
    y=1;
    for x=1:A
        for y=1:B
            if ftest(x,y)~= 0;
                counter3=counter3+1;
            end
        end
    end
    temp3 = counter3;
    if temp3 > store3;
        codenum3 = z;
        store3 = temp3;
    end
end

    for x=1:A
        for y=1:B
            if fnew(x,y)==codenum3;
                f4thbw(x,y)=fnew(x,y);
            else
                f4thbw(x,y)=0;
            end
        end
    end

fRGB4 = label2rgb(f4thbw);

[r c z] = size(fRGB4);

for i=1:r
      for j=1:c
          if ((fRGB4(i,j,1)==137 && fRGB4(i,j,2)==0 && fRGB4(i,j,3)==0)) 
          fRGB4(i,j,1)=0; fRGB4(i,j,2)=0; fRGB4(i,j,3)=250;
          else
          fRGB4(i,j,1)=255; fRGB4(i,j,2)=255; fRGB4(i,j,3)=255;
          end
      end
end

imtool(fRGB4);
imwrite(fRGB4, 'fRGB4.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Q2(b)

% AND images
I = imread('match1.gif');
J = imread('match2.gif');

[A2,B2]= size(I);
for x2=1:A2
    for y2=1:B2
        if I(x2,y2) + J(x2,y2) == 2;
            ANDimages(x2,y2) = 1;
        else
            ANDimages(x2,y2) = 0;
        end
      % ANDimages(x2,y2) = I(x2,y2)& J(x2,y2);
    end
end

imtool(ANDimages);
imwrite(ANDimages, 'ANDimages.jpg');

%OR images

for x2=1:A2
    for y2=1:B2
        if I(x2,y2) + J(x2,y2) == 0;
            ORimages(x2,y2) = 0;
        else
            ORimages(x2,y2) = 1;
       %ORimages(x2,y2) = I(x2,y2)| J(x2,y2);
        end
    end
end

imtool(ORimages);
imwrite(ORimages, 'ORimages.jpg');

%XOR images

for x2=1:A2
    for y2=1:B2
        if I(x2,y2) + J(x2,y2) == 1;
            XORimages(x2,y2) = 1;
        else
            XORimages(x2,y2) = 0;
        end
    end
end

imtool(XORimages);
imwrite(XORimages, 'XORimages.jpg');

%NOT images

for x2=1:A2
    for y2=1:B2
        if I(x2,y2) == 1;
            NOTimages(x2,y2) = 0;
        else
            NOTimages(x2,y2) = 1;
        end
    end
end

imtool(NOTimages);
imwrite(NOTimages, 'NOTimages.jpg');


% Q2(C)

D = imread('cameraman.tif');
C = imread('mandril_gray.tif');
[A3,B3] = size(C)
for x3=1:A3
    for y3=1:B3
        if C(x3,y3) < D(x3,y3);
           E(x3,y3) = C(x3,y3); 
        else 
           E(x3,y3) = D(x3,y3);
        end
    end
end

imtool(E);
imwrite(E, 'E.tif');