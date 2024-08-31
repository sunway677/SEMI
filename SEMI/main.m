clear
clc
warning off

% Setup project path and add to MATLAB path
proj_path = './';
addpath(genpath(proj_path));

% Load dataset
data_path = '';
data_name = 'bbcsport4vbigRnSp.mat';
load([data_path, data_name]); 

% Initialize missing data patterns
per{1} = miss10;
per{2} = miss20;
per{3} = miss30;
per{4} = miss40;
per{5} = miss50;

% Prepare data and labels
X = data'; 
Y = truth - min(truth) + 1;
k = length(unique(Y));
V = size(X, 1);

% Normalize data
X = normalize_data(X);

% Define missing data ratios
missing_ratios = [0.1:0.1:0.5];
iters = 1; % Number of iterations for each missing data ratio

% Iterate over different missing data ratios
for iter = 1:iters
    for mr = 1:length(missing_ratios)
        
        fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter);
        
        % Identify missing data indices for each view
        for v = 1:size(per{mr}{iter}, 2)
            Im{v} = find(per{mr}{iter}(:,v) == 0);
        end
        
        % Set hyperparameters for SEMI algorithm
        lbd_set = 2.^[-10:5:10];
        gamma_set = 2.^[-10:5:10];

        num_iters_eval = 5; % Iterations for k-means to reduce randomness

        % Loop over selected hyperparameters
        for il = 3 % Example: fix lambda
            for ig = 4 % Example: fix gamma
                % Execute SEMI algorithm
                [S, obj] = SEMI(X, Im, k, lbd_set(il), gamma_set(ig));
                S = (abs(S) + abs(S)') / 2; % Symmetrize S

                % Perform spectral clustering
                [U] = baseline_spectral_onkernel(S, k);
                
                % Evaluate clustering result
                evals = zeros(num_iters_eval, 10);
                for i = 1:num_iters_eval
                    [y] = my_lite_kmeans(U, k);
                    [evals(i,:)] = my_eval_y(y, Y);
                end
                eval = mean(evals, 1);
                
                % Print clustering performance
                fprintf(['\nil: %d, ig: %d, acc: %.4f, nmi: %.4f, pur: %.4f\n'], il, ig, eval(1), eval(2), eval(3));
            end
        end
    end
end


