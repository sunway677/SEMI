function [obj, term1, term2, term3] = cal_obj(X, S, F, E, beta, lbd, gamma, lambda2)
% CAL_OBJ: Calculates the objective function value for SEMI method
% Inputs:
%   X - Cell array of multi-view data
%   S - Coefficient matrix representing relationships among data samples
%   F - Embedding matrix for consistent structure representation
%   E - Error matrix capturing inconsistent information
%   beta, lbd, gamma, lambda2 - Regularization parameters
% Outputs:
%   obj - The value of the objective function
%   term1, term2, term3 - Components of the objective function for analysis

V = length(X); % Number of views in multi-view data

% Initializing the components of the objective function
term1 = 0;
term5 = 0;

% Loop over each view to calculate the terms of the objective function
for v = 1:V
    tmp = X{v} - X{v} * S;
    term1 = term1 + beta(v) * sum(sum(tmp.^2)); % Term related to the global structure learning

    D = L2_distance_1(X{v}, X{v}); % L2 distance for local structure learning
    term5 = term5 + sum(sum(D .* S)); % Adding local information
end

term2 = sum(sum(S.^2)); % Term related to the self-representation learning

tmp = S - F' * F - E; % Inconsistent structure representation
term3 = sum(sum(tmp.^2)); % Term related to the consistent and inconsistent structure learning

% Unused variable, can be removed if not used elsewhere
% term4 = norm(E, 1); % L1-norm of the error matrix E

% Regularization parameter for term5
lambda3 = 0.001;

% Objective function calculation
obj = lbd * term2 + gamma * term3 + lambda2 * norm(E, 1) + lambda3 * term5;
end
