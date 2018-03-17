%%%%%%%%%%%%% The mainproj3.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      (Incomplete) sample items pertaining to Project #3
%      on DFT-based image filtering
%
% Input Variables:
%      f       input 2D image
%      M, N    rows (M) and columns in f
%      
% Returned Results:
%      H       A filtered version of input image
%
%  The following functions are called:
%      lpfilter.m   
%      dftuv.m
%
%  Author:      William E. Higgins
%  Date:        10/5/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;      % Clear out all memory 

% Do M x N unpadded operations
% 1.  M x N FFT of f --> F
% 2.  Get Gaussian M x N LPF
% 3.  Filter f (F) with g (G)
% 4.  Do IFFT
% --> Clear wraparound errors at top, bottom
%     left, right visible in filtered checkers image

f=imread('checker.gif');
[M, N] = size(f);
imtool(f,[ ]);

F   = fft2(double(f));
F(1,1) = 0.0;
g   = real(ifft2(F));
imtool(g);

sig = 15.5;
H   = lpfilter('gaussian', M, N, sig);
% Plot Scaled version of |H(u,v)|
imtool(log(1+H),[]);
% Make 3D plot of H(u,v)
mesh(H(1:5:256, 1:5:256));
for u = 1 : M
    for v = 1 : N
        G(u,v) = H(u,v)*F(u,v);
    end
end
g   = real(ifft2(G));
imtool(g,[ ]);

% Do P x Q padded operations

P = 2 * M;
Q = 2 * N;
F   = fft2(double(f), P, Q);
sig = 7.5;
H   = lpfilter('gaussian', P, Q, 2*sig);
for u = 1 : P
    for v = 1 : Q
        G(u,v) = double(H(u,v))*double(F(u,v));
    end
end
g   = real(ifft2(G));
imtool(g,[ ]);

%%%%%%%%%%%%% End of the main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
