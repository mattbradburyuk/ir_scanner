% modify to take matrix of vectors

close all;
clear all;
clc;

app = AppWindow();

A = [-2,-2,-3,-1, 1; ....
     -1, 1, 3, 4, 3];

sA = size(A,2); 

a_line = plot(app.main_axes, A(1,:), A(2,:));
a_line.Color = 'black';


B = [-2,-3,-2,-2, 0, 2 ;...
     -2, 0, 2, 4, 3, 4 ];

sB = size(B,2); 

b_line = plot(app.main_axes, B(1,:), B(2,:));
b_line.Color = 'red';
 
b_shift = [.5;0];
B = B + repmat(b_shift,1,sB);

b_line = plot(app.main_axes, B(1,:), B(2,:));
b_line.Color = 'green';

cum_error = 0;
for i = 1:(sA-1)

%     fprintf('Line: %d\n',i);
    [ode, minod] = orth_dist(A(:,i:i+1),B);
    if ode == 1
        cum_error = cum_error + abs(minod);
    end

end

cum_error