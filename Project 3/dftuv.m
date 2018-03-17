%  Gives an MxN array needed by
%     lowpass filter function lpfilter.m 
%
%  Taken directly from Chapter 4 of
%     Digital Image Processing using MATLAB
%     by Gonzalez, Woods, and Eddins
%
function [U, V] = dftuv(M, N);
% dftuv
u = 0:(M-1);
v = 0:(N-1);

idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;
[V, U] = meshgrid(v,u);
