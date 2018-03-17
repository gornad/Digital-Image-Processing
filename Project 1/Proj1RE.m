clear;
clc;

% Q 1
f=imread('walkbridge.tif');
f = f(:,:,1);

%256x256 f1
[M, N] = size(f);
a=0;
b=0;

for x = 1:2:M 
    a = a+1;
    b = 0;
    for y = 1:2:N
        b= b+1;
        f1(a,b) = f(x,y);
    end
end

%imwrite(f1,'f1.tif');           

%128x128 f3
[M, N] = size(f1);
a=0;
b=0;

for x = 1:2:M 
    a = a+1;
    b = 0;
    for y = 1:2:N
        b= b+1;
        f3(a,b) = f1(x,y);
    end
end

%imwrite(f3,'f3.tif');            

%64x64 f4
[M, N] = size(f3);
a=0;
b=0;

for x = 1:2:M 
    a = a+1;
    b = 0;
    for y = 1:2:N
        b= b+1;
        f4(a,b) = f3(x,y);
    end
end

%imwrite(f4,'f4.tif');

%32x32 f5
[M, N] = size(f4);
a=0;
b=0;

for x = 1:2:M 
    a = a+1;
    b = 0;
    for y = 1:2:N
        b= b+1;
        f5(a,b) = f4(x,y);
    end
end

imwrite(f5,'f_bilinear_input.tif');

%UPSAMPLE CODE From 256X256 to 512x512

scale = [2 2];              
oldSize = size(f1);                   
newSize = max(floor(scale.*oldSize(1:2)),1); 

rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

f_256_to_512 = f1(rowIndex,colIndex,:);
imtool(f_256_to_512)
imwrite(f_256_to_512,'f_256_to_512.tif');

%UPSAMPLE CODE From 128X128 to 512x512

scale = [4 4];              
oldSize = size(f3);                   
newSize = max(floor(scale.*oldSize(1:2)),1); 

rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

f_128_to_512 = f3(rowIndex,colIndex,:);
imtool(f_128_to_512)
imwrite(f_128_to_512,'f_128_to_512.tif');

%UPSAMPLE CODE FROM 32X32 to 512X512

scale = [16 16];              
oldSize = size(f5);                
newSize = max(floor(scale.*oldSize(1:2)),1);  

rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

f_32_to_512 = f5(rowIndex,colIndex,:);
imtool(f_32_to_512)
imwrite(f_32_to_512,'f_32_to_512.tif');


% Q 2
f_bilinear = bilinear_interpolation(f5,16);
imtool(f_bilinear); 
imwrite(f_bilinear, 'f_bilinear.tif');


% Q 3
f=imread('walkbridge.tif');
f = f(:,:,1);
[M, N] = size(f);
a=0;
b=0;

%7bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y)-1,2)==0)
            g7(x,y) = f(x,y) -1;
        else
            g7(x,y) = f(x,y);
        end
    end
end   


imwrite(g7,'g7.tif'); 
imtool(g7);   


%6bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y),4)==0)
            g6(x,y) = f(x,y);
        elseif (rem(f(x,y),4) >=2 && (f(x,y) <= 192))
            g6(x,y) = f(x,y) + 4 - rem(f(x,y),4);
        else
            g6(x,y) = f(x,y) - rem(f(x,y),4);
        end
    end
end   


imwrite(g6,'g6.tif'); 
imtool(g6); 

%5bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y),8)==0)
            g5(x,y) = f(x,y);
        elseif (rem(f(x,y),8) >=4 && (f(x,y) <= 192))
            g5(x,y) = f(x,y) + 8 - rem(f(x,y),8);
        else
            g5(x,y) = f(x,y) - rem(f(x,y),8);
        end
    end
end   


imwrite(g5,'g5.tif'); 
imtool(g5); 

%4bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y),16)==0)
            g4(x,y) = f(x,y);
        elseif (rem(f(x,y),16) >=8 && (f(x,y) <= 192))
            g4(x,y) = f(x,y) + 16 - rem(f(x,y),16);
        else
            g4(x,y) = f(x,y) - rem(f(x,y),16);
        end
    end
end   


imwrite(g4,'g4.tif'); 
imtool(g4); 

%3bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y),32)==0)
            g3(x,y) = f(x,y);
        elseif (rem(f(x,y),32) >=16 && (f(x,y) <= 192))
            g3(x,y) = f(x,y) + 32 - rem(f(x,y),32);
        else
            g3(x,y) = f(x,y) - rem(f(x,y),32);
        end
    end
end   


imwrite(g3,'g3.tif'); 
imtool(g3); 

%2bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(rem(f(x,y),64)==0)
            g2(x,y) = f(x,y);
        elseif ((rem(f(x,y),64) >= 32) && (f(x,y) <= 192))
            g2(x,y) = f(x,y) + 64 - rem(f(x,y),64);
        else
            g2(x,y) = f(x,y) - rem(f(x,y),64);
        end
    end
end   


imwrite(g2,'g2.tif'); 
imtool(g2);

%1bit grey
for x = 1:1:M 
    for y = 1:1:N
        if(f(x,y)>= 128)
            g1(x,y) = 255;
        else
            g1(x,y) = 0;
        end
    end
end   


imwrite(g1,'g1.tif'); 
imtool(g1); 

%Q 4
%6bit grey on 256x256

[M, N] = size(f1);

for x = 1:1:M 
    for y = 1:1:N
        if(rem(f1(x,y),4)==0)
            g6_256(x,y) = f1(x,y);
        elseif (rem(f1(x,y),4) >=2 && (f1(x,y) <= 192))
            g6_256(x,y) = f1(x,y) + 4 - rem(f1(x,y),4);
        else
            g6_256(x,y) = f1(x,y) - rem(f1(x,y),4);
        end
    end
end   

imwrite(g6_256,'g6_256.tif'); 
imtool(g6_256); 

