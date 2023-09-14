clc;
close all;

A = [1 2 0; 3 5 4];
[M_r,I_r] = min(max(A));
[M_c,I_c] = max(max(A));

[y,in] = max(A);
[value,column] = max(y);
[~,row] = max(A(:,column));

[I_r, I_c];
[row, column]