clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q1.a)
input=imread('checker.gif');
[M, N] = size(input);

imtool(input);
% Get |F|
F = uint8(abs(fft2(double(input))));
imtool(F,[ ]);
% Get log(1+|F|)
LF = log(1+abs(fft2(double(input))));
imtool(LF,[ ]);

f = input;
% Modulate f 
for x = 1: M
    for y = 1: N
        f_m(x,y)=f(x,y)*((-1)^(x+y));
    end
end
imtool(f_m,[ ]);
% Get |Fm|
F_m  = uint8(abs(fft2(double(f_m))));
imtool(F_m,[ ])
% Get log(1+|Fm|)
LF_m = log(1+abs(fft2(double(f_m))));
imtool(LF_m,[ ]);

% Get g(x,y) and set F(1,1) to 0
F = fft2(double(input));
F(1,1)= 0.0;
imtool(F);
g = ifft2(F,M,N);
imtool(g,[ ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q1.b)
input=imread('checker.gif');
[M, N] = size(input);
F = fft2(input,M,N);
sig = 15.0;
H1 = lpfilter('gaussian', M, N, sig);
G2 = zeros(M,N);
mesh(H1(1:M, 1:N));
for u = 1 : M
    for v = 1 : N
        G2(u,v) = H1(u,v)*F(u,v);
    end
end
g2   = real(ifft2(G2));
imtool(g2,[ ]);

%Get g2(x,y)*(-1)^(x+y)
for x = 1 : M
    for y = 1 : N
        g2_m(x,y)=g2(x,y)*((-1)^(x+y));
    end
end
imtool(g2_m,[ ]);

%Get |G2(u,v)|
G2_abs = uint8(abs(fft2(double(g2_m))));
imtool(G2_abs)
%Get log(1+|G2(u,v)|)
LG2_m = log(1+abs(fft2(double(g2_m))));
imtool(LG2_m,[ ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.c)
% Zero Padding
input=imread('checker.gif');
[M, N] = size(input);
P = 2 * M;
Q = 2 * N;
F   = fft2(double(input), P, Q);
sig = 15;
H   = lpfilter('gaussian', P, Q, sig);
mesh(H(1:P, 1:Q))
imtool(log(1+H), [ ])
for u = 1 : P
    for v = 1 : Q
        G(u,v) = double(H(u,v))*double(F(u,v));
    end
end
g   = real(ifft2(G));
imtool(g,[ ]);

% Get g(x,y)*(-1)^(x+y)
for x = 1 : M
    for y = 1 : N
        g_m(x,y)=g(x,y)*((-1)^(x+y));
    end
end
imtool(g_m,[ ]);

%Get |G(u,v)|
G_abs = uint8(abs(fft2(double(g_m))));
imtool(G_abs)
%Get log(1+|G(u,v)|)
LG_m = log(1+abs(fft2(double(g_m))));
imtool(LG_m,[ ]);

