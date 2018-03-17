%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input: 'lake.gif'p.
%Output:f(x,y),|F(u,v)|,c(x,y),|C(u,v)|
%       g(x,y),|G(u,v)|,h(x,y),diff(x,y)


clear
clc

imtool close all;
%import image and display f(x,y)
f=imread('lake.tif');
f = f(:,:,1);
[M,N]=size(f);
imwrite(uint8(f),'f.gif');

%modulation of f
for m=1:M
    for n=1:N
        f_mod(m,n) = f(m,n)*((-1)^(m + n));
    end
end
F_mod=fft2(f_mod);
F_mag = abs(F_mod);

%scaling and display |F|
F_disp=log(1+F_mag);
imwrite(uint8(F_disp*15),'F_mag.gif');


%Get corrupted image of f
for x=1:M
    for y=1:N
        c(x,y)=f(x,y)+32*cos((2*pi*32*x)/N);
    end
end
C = fft2(c);

%modulation of c
for m=1:M
    for n=1:N
        c_mod(m,n) = c(m,n)*((-1)^(m + n));
    end
end
C_mod=fft2(c_mod);
C_mag=abs(C_mod);

%scaling and display |C|
C_disp=log(1+C_mag);
imwrite(uint8(C_disp)*15,'C_mag.gif');
imwrite(uint8(c),'c.gif');

%Filtering the corrupted image using notch filter
for u=1:M
    for v=1:N
        H(u,v)=notchfilter(u,v);
        G(u,v)=double(H(u,v))*double(C(u,v));
    end
end

%modulation of g
g=ifft2(G);
for m=1:M
    for n=1:N
        g_mod(m,n) = g(m,n)*((-1)^(m + n));
    end
end
G_mod=fft2(g_mod);
G_mag = abs(G_mod);

%scaling and display |G|
G_disp=log(1+G_mag);
imwrite(uint8(G_disp)*15,'G_mag.gif');
imwrite(uint8(g),'g.gif');

%modulation of h
h=ifft2(H);
for m=1:M
    for n=1:N
        h_mod(m,n) = h(m,n)*((-1)^(m + n));
    end
end
H_mod=fft2(h_mod);
H_mag = abs(H_mod);

%scaling and display |H|
H_disp=log(1+H_mag)*500;
imwrite(uint8(H_disp),'H_mag.gif');


%The image and Fourier-transform magnitude of the difference image (f(x, y) - g(x, y)).
for x=1:M
    for y=1:N
        diff(x,y)=f(x,y)-g(x,y);
        diff_mod(x,y) = diff(x,y)*((-1)^(x + y));
    end
end
diff_disp=log(double(1+diff_mod))*500;
imwrite(uint8(diff),'diff.gif');
imtool(diff,[]);
