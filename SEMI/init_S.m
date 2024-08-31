function [S] = init_S(X, beta, lbd)
% INIT_S: Initializes the subspace representation matrix S in the SEMI algorithm
% Inputs:
%   X - Cell array containing multi-view data
%   beta - Weights for each view
%   lbd - Regularization parameter
% Outputs:
%   S - Initialized subspace representation matrix

V = length(X); % Number of views
n = size(X{1}, 2); % Number of data samples

% Initialize the D matrix
D = zeros(n, n);
D = D + lbd * diag(ones(n, 1)); % Adding regularization term

% Aggregate view contributions
for v = 1:V
  D = D + beta(v) * X{v}' * X{v};
end

% Calculate inverse of D
D_inv = inv(D);

% Initialize S by normalization
S = -D_inv ./ diag(D_inv)';
S = S - diag(diag(S)); % Zeroing the diagonal

% Symmetrize S
S = (S + S') / 2;

end
