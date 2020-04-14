function [inliers] = interval_error(y1, y1_error, y2, y2_error)

Y1 = y1 + [-y1_error y1_error];
Y2 = y2 + [-y2_error y2_error];
 
[n, l] = size(Y1);
inliers = zeros(n,1);

for i = 1:n;
    Y11 = Y1(i,:);
    Y22 = Y2(i,:);
    if (Y11(1)<Y22(1)) && (Y22(1)<Y11(2)) || (Y11(1)<Y22(1)) && (Y22(1)<Y11(2));
        inliers(i) = 1;
    end
end
        