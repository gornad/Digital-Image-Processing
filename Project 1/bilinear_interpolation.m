function [im1] = bilinear_interpolation(file,factor)

im=imread('f_bilinear_input.tif');

[height,width,depth]=size(im);
factor = 16;
for i=1:height
    for j=1:width
      im1(1+(i-1)*factor,1+(j-1)*factor,:)=im(i,j,:); 
    end
end

i=1;
j=1;
while i<1+(height-1)*factor
    j=1;
    while j<1+(width-1)*factor
        
       if (~((rem(i-1,factor)==0) && (rem(j-1,factor)==0)))  
           h0=im1( ceil(i/factor)*factor-factor+1,ceil(j/factor)*factor-factor+1,:); 
           h1=im1( ceil(i/factor)*factor-factor+1+factor,ceil(j/factor)*factor-factor+1,:);
           h2=im1( ceil(i/factor)*factor-factor+1,ceil(j/factor)*factor-factor+1+factor,:);
           h3=im1( ceil(i/factor)*factor-factor+1+factor,ceil(j/factor)*factor-factor+1+factor,:);
           
           x=rem(i-1,factor); 
           y=rem(j-1,factor);  
          
           dx=x/factor; 
           dy=y/factor;
          
           b1=h0;    
           b2=h1-h0;
           b3=h2-h0;
           b4=h0-h1-h2+h3;           
           im1(i,j,:)=b1+b2*dx+b3*dy+b4*dx*dy; 
       end
       j = j+1;
    end
    i = i+1;
  %imshow(cast(im1,'uint8')); 
end
