%%%%%%%%%%%%% The reconstruct.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Perform morphological image processing
%
% Input Variables:
%      openg, recong, recongtemp, g
%      
% Returned Results:
%      Reconstructed image
%
%  Date:        12/1/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [f] = reconstruct(og_ll,original)

    zero = zeros(409);

    for M = 4:406
        for N = 4:406
            flag = 0;
            for i = -1:1
                for j = -1:1
                    if og_ll(M+i,N+j) == 255
                        flag = flag + 1;
                    end
                end
            end            
            if ((original(M,N) ~= 255) || (flag <= 0))
                zero(M,N) = 0;
            else
                zero(M,N) = 255;
            end
        end
    end
    
    f = zero;
end