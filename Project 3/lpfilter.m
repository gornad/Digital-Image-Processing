%  Gives an MxN lowpass filter function H(u,v) 
%     of type gaussian or ideal
%     parameter DO sets the passband width
%
%  Taken directly from Chapter 4 of
%     Digital Image Processing using MATLAB
%     by Gonzalez, Woods, and Eddins
%
function H = lpfilter(type, M, N, DO);
% lpfilter
[U, V] = dftuv(M, N);

D = sqrt(U.^2 + V.^2);
switch type
    case 'gaussian'
        H = exp(-(D.^2)./(2*(DO^2)));
    case 'ideal'
        H = double(D<=DO);
    otherwise
        error('unknown filter type');
end
