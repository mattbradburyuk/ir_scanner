function [od_exists, min_orth_dist ] = orth_dist(A,B)
%ORTH_DIST Summary of this function goes here
%   Detailed explanation goes here

% Calculates if there exists an a orth distance between an input vector a
% (described by start end end point vectors in A) and a path of vectors
% described by B

%  If there is the function calculates the minimum orthagonal distance

% A contains two column vectors representing the starting position and
% ending position of the vector a. Vector a is the line which form part of
% the path which need to be compared to each of the steps on the path in B

%  B continas multiple 2x1 vectors representing the positions on the path
%  traced out by the sensor readings which approximates to position of an
%  obsticle.


    % error checking on inputs
    if (size(A,1) ~= 2) 
        fprintf('Error: Size of A: %dx%d. Expecting 2xn\n',size(A))
        return; 
    elseif (size(B,1) ~= 2)
        fprintf('Error: size of B: %dx%d. Expecting 2xn\n',size(A))
        return;
    end

    % initialise orth_dists to zeros
        
    sB = size(B,2);  % horizontal size of B
    orth_dists = zeros(2,sB-1);
    min_orth_dist = 0;
    od_exists = 0;

    
    % calculate translation and rotation to take vector a to the origin
    % pointing in x direction
    
    a1 =A(:,1);
    a2 =A(:,2);
    
    trans = - a1; % translation  
    
    a_t = a2 + trans; % translated path section
    
    theta = atan2(a_t(2),a_t(1)); % angle of a_p against the x axis
    
    % matrix to rotate a_p to line up against the x axis
    R = [cos(-theta), - sin(-theta); sin(-theta), cos(-theta)];
    

    % apply same translation and rotation to B matrix
    
    % translation
    
    B_t = B + repmat(trans,1,sB); 
    
    % rotation
    
    B_tr = R * B_t;
    

    for i = 1:(sB -1) % itterates through each start/end pair in the list of points
        
        % if the start of the translated and rotated b vectors is a
        % different sign to the tail then the vector must cross the y axis
        % (x = 0), this means that the b vector crosses the orthoganal line
        % to the start of the a vector
        
        if sign(B_tr(1,i)) ~= sign(B_tr(1,i+1)) 
            
            orth_dists(1,i) = 1; % mark up as true that a ortoganal cross exists
            
            % use geometry to calculate distance from start of a vector to
            % crossing point of b vector across x=0
            
            % if start coord => x1,y1 and end coords => x2,y2
            % y1 + (y2 - y1) * |x1| / (|x1| + |x2|)
            
            orth_dists(2,i) =abs( B_tr(2,i) + (B_tr(2,i+1) - B_tr(2,i)) * abs(B_tr(1,i)) / (abs(B_tr(1,i)) + abs(B_tr(1,i+1))));
            
        else
            orth_dists(1,i) = 0; % mark up as true that a ortoganal cross exists
            orth_dists(2,i) = Inf; % mark up distance for non crossing as infinity
            
            
        end
        
%         fprintf('Orthaganol cross: %d, distance: %0.3f\n',orth_dists(1,i),orth_dists(2,i));
    end
    
    if sum(orth_dists(1,:)) >= 1
        od_exists = 1;   
        min_orth_dist = min(orth_dists(2,:));
    
    end
    
end

