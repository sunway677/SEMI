function [X] = update_X(X, Im, S)
% UPDATE_X: Updates the multi-view data X in the SEMI algorithm
% Inputs:
%   X - Cell array containing multi-view data
%   Im - Indicator matrix for missing data
%   S - Current subspace representation
% Outputs:
%   X - Updated multi-view data

V = length(X); % Number of views
n = size(X{1}, 2); % Number of data samples

% Matrix B for updating missing data
B = eye(n) - S - S' + S * S';

% Loop over each view to update missing data
for v = 1:V
    % Indices of observed and missing data in view v
    Io{v} = setdiff([1:n], Im{v});
    
    % Update the missing data in view v
    X{v}(:, Im{v}) = -X{v}(:, Io{v}) * B(Io{v}, Im{v}) / B(Im{v}, Im{v});  
end

end


