function [ orth_dist ] = orth_dist(A,B)
%ORTH_DIST Summary of this function goes here
%   Detailed explanation goes here


    % error checking on inputs
    if (size(A,1) ~= 4) || (size(A,2) ~= 1)
        fprintf('Error: Size of A: %dx%d. Expecting 4x1\n',size(A))
        return; 
    elseif (size(B,1) ~= 4)
        fprintf('Error: size of B: %dx%d. Expecting 4xn\n',size(A))
        return;
    end

    orth_dist = 0;

a1 =A(1:2,1);
a2 =A(3:4,1);

b1 = B(1:2,1);
b2 = B(3:4,1);


% translate to origin

a = a2 - a1;
theta = -atan2(a(2),a(1));

% rotate by theta

R = [cos(theta), - sin(theta); sin(theta), cos(theta)];

R*a;

b1_t = b1 - a1;
b2_t = b2 - a1;

b1_tr = R*b1_t;
b2_tr = R*b2_t;

if (b1_tr(1) < 0 && b2_tr(1) > 0) || (b1_tr(1) > 0 && b2_tr(1) < 0)
    
    orth_dist = b1_tr(2) + (b2_tr(2) - b1_tr(2)) * abs(b1_tr(1)) / (abs(b1_tr(1)) + abs(b2_tr(1)));
    fprintf('Orthaganol cross, distance: %0.3f\n',orth_dist);
else
    fprintf('Not an orthagonal cross\n')
    orth_dist = -1;
end



end

