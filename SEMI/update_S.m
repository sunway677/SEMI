function [S] = update_S(X, F, E, Im, lbd, gamma, C1)
% UPDATE_S: Updates the subspace representation matrix S in the SEMI algorithm
% Inputs:
%   X - Cell array containing multi-view data
%   F - Feature matrix
%   E - Error matrix
%   Im - Indicator matrix for missing data
%   lbd, gamma - Regularization parameters
%   C1 - Auxiliary variable for convergence
% Outputs:
%   S - Updated subspace representation matrix

V = length(X);
n = size(X{1}, 2);
% Define the islocal flag
islocal = 1; % Set islocal to 1 to only update the similarities of neighbors
% Initialize matrices
K = zeros(n, n);
B = zeros(n, n);

% Loop over each view to construct K and B matrices
for v = 1:V
    K = K + X{v}' * X{v};
    Xo = X{v};
    Xo(:, Im{v}) = 0;
    B = B + L2_distance_1(Xo, Xo);
end
K = K / V;
B = 0.5 * 1 / V * B;
C = F' * F + E - C1 / gamma;

% Calculate terms for S update
term1 = K + (lbd + 0.5 * gamma) * eye(n);
term2 = K + 0.5 * gamma * C - 0.01 * B;

% Solve for S_hat
S_hat = term1 \ term2;

% Update S with constraints
S = zeros(n);
for i=1:n
    idx = zeros();
    s0 = S_hat(i,:);
    idx = find(s0>0);
    idxs = unique(idx(2:end));
    if islocal == 1
        idxs0 = idxs;
    else
        idxs0 = 1:n;
    end;
    s1 = S_hat(i,:);
    si = s1(idxs0);
    q(1,:) = si;
    S(i,idxs0) = SloutionToP19(q,1);
    clear q;
end

end




