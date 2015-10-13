% modify to take matrix of vectors

close all;
clear all;


app = AppWindow()

A = [-2,-2; ....
     -1, 1]


B = [-2,-3,-2,-2, -5 ;...
     -2, 0, 2, 4, -5 ]

[ode, minod] = orth_dist(A,B);

a_line = plot(app.main_axes, A(1,:), A(2,:));
a_line.Color = 'black'

b_line = plot(app.main_axes, B(1,:), B(2,:));
b_line.Color = 'red'
pause;
b_line.XData = b_line.XData + 1;




