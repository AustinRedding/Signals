function [Y] = convolution(x1, x2)

% Force column vector
x1 = x1(:);
x2 = x2(:);

X = [x1;zeros(length(x2),1)];
H = [x2;zeros(length(x1),1)];

Y = zeros((length(x1)+length(x2)),1);
for ii=1:( length(Y)-1 )
    for jj=1:length(x2)
        if (ii-jj+1>0)
        Y(ii) = Y(ii) + ( X(jj) * H(ii - jj +1) );
        end
    end
end

Y(end) = [];

end

