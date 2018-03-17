%%%%%%%%%%%%% The Project5.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Perform morphological image processing
%
% Input Variables:
%      Input 2D image
%      
% Returned Results:
%      Final Image
%      Edge Detection
%
%  Date:        12/1/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear all; 
close all;
g=imread('proj5.gif');
binaryf=zeros(409);

[M,N]=size(g);

for i=1:M
        for j=1:N
            
            if g(i,j)<37.5 %Threshold half of 75
                binaryf(i,j)=0;
            else
                binaryf(i,j)=255;
            end
        end
end

imtool(uint8(binaryf));


% erosion: cross filter mask

blankf = 255*ones(409);

for M = 2:408
    for N =2:408     
        flag = 0;
        if ((binaryf(M,N) == 0)&& ...
            (binaryf(M-1,N) == 0)&& ...
            (binaryf(M,N-1) == 0)&& ...
            (binaryf(M+1,N)==0)&& ...
            (binaryf(M,N+1)==0))
              flag = 1;
        end
        if flag ~= 1
            blankf(M,N) = 255;
        else
            blankf(M,N) = 0;
        end  
    end
end

% dilation : 3x3 mask

dilationf = 255*ones(409);

for M = 2:408
    for N = 2:408
        flag = 0;
        for i = -1:1
            for j = -1:1
                if blankf(M+i,N+j) == 0
                    flag = flag +1;
                end
            end
        end
        if flag <= 0
            dilationf(M,N) = 255;
        else
            dilationf(M,N) = 0;
        end
    end
end

imtool(uint8(dilationf));
imwrite(uint8(dilationf),'uncorrupted.gif')

g = 255-dilationf;

%erosion: 255*ones(45, 1)

erosion = zeros(409);

for M = 23:386
    for N =1:408
        flag = 0;
        for i = -22:22
            if g(M+i,N) == 255
              flag = flag + 1;
            end
        end
        if flag < 45
            erosion(M,N) = 0;
        else
            erosion(M,N) = 255;
        end  
    end
end

imtool(255-erosion);
imwrite(uint8(255-erosion),'open.gif');

% opening: 255*ones(45, 1)

openg = zeros(409);

for M = 23:386
    for N = 1:408
        flag = 0;
        for i = -22:22
            if erosion(M+i,N) == 255
                flag = flag + 1;
            end
        end
        if flag >= 1
             openg(M,N) = 255;
        else
             openg(M,N) = 0;
        end
    end
end

imtool(255-openg);
imwrite(uint8(255-openg),'erosion.gif');

%reconstruction: 255*ones(45, 1); 


recong = reconstruct(openg, g);
recongtemp = reconstruct(recong, g);
i = isequal(recongtemp, recong);

while i == 0
    recong = recongtemp;
    recongtemp = reconstruct(recongtemp, g);
    i = isequal(recongtemp, recong);
end

recong = 255 - recong;

imtool(recong);
imwrite(uint8(recong),'clearletters.gif');  

% erosion: boundary detection

erosionboundaryg = 255*ones(409);

for M = 4:406
    for N =4:406
        flag = 0;
        for i = -1:1
            for j = -1:1
               if recong(M+i,N+j) == 0
               flag = flag + 1;
               end
            end
        end
        if flag >= 9
           erosionboundaryg(M,N) = 0;
        else
           erosionboundaryg(M,N) = 255;
        end  
    end
end

boundaryg = erosionboundaryg-recong;
boundaryg = 255 - boundaryg;

imtool(uint8(boundaryg));
imwrite(uint8(boundaryg),'boundrydetection.gif')




