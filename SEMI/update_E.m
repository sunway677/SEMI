function [E] = update_E(Z, F, miu, C1, lambda2)
% UPDATE_E: Updates the error matrix E in the SEMI algorithm
% Inputs:
%   Z - Current subspace representation
%   F - Feature matrix
%   miu - Parameter controlling the update rate
%   C1 - Auxiliary variable for convergence
%   lambda2 - Regularization parameter
% Outputs:
%   E - Updated error matrix

% Calculate temporary variables for the update
temp1 = Z - F' * F + C1 / miu;
temp2 = lambda2 / miu;

% Soft-thresholding to update E
E = temp1+temp2;
% E = 0;
% E = max(0, temp1 - temp2) + min(0, temp1 + temp2);
end
