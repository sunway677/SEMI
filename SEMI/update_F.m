function [F] = update_F(Z, k)
% UPDATE_F: Updates the feature matrix F in the SEMI algorithm
% Inputs:
%   Z - Current subspace representation
%   k - Number of clusters or dimensions for subspace
% Outputs:
%   F - Updated feature matrix

% Size of the input matrix Z
n = size(Z, 1);

% Options for the eigenvalue decomposition
opts.disp = 0;

% Perform eigenvalue decomposition to obtain the top k eigenvectors
% These eigenvectors form the columns of F, representing the subspace
[Ftmp, ~] = eigs(Z + Z', k, 'la', opts);
F = Ftmp';

end



