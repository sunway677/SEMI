
function [S, obj] = SEMI(X, Im, k, lbd, gamma)

V = size(X, 1);
n = size(X{1}, 2);
max_iter = 100;

% init 
beta = ones(V,1)/V;
for v=1:V
    X{v}(:,Im{v}) = 0;
end
[S] = init_S(X, beta, lbd);

%A = Z; % initialize A
E = zeros(n,n);
C1 = zeros(n,n);

t = 0;
flag = 1;
miu = 0.01; % 0.01
rho = 1.1; % 1.1
lambda2  = 100000;%00000

h = 1;
while flag
    %% update F
    [F] = update_F(S-E, k);  %%% input is Z-E instead of Z
    %% update S
    if h == 1
       E = S - F'*F;
       h=0;
    end
    [S] = update_S(X, F, E, Im, lbd, gamma,C1);
    %% update X
    [X] = update_X(X, Im, S);
    %% update E
    [E] = update_E(S, F, miu, C1, lambda2);
    %% update C1
    leq1 = S-F'*F-E;
    C1 = C1 + miu*leq1;
    %% update beta 
%     [beta] = update_beta(X, Z);
    %% cal obj
    t = t+1;
    [obj(t),~,~,~] = cal_obj(X, S, F, E, beta, lbd, gamma, lambda2);
    if t>=2 && (abs((obj(t-1)-obj(t))/(obj(t)))<1e-4 || t>max_iter)
        flag =0;
    end
    % Update miu %
    miu = min(rho*miu,1e8);
end

end

%function [Z, obj] = IMSC(X, Im, Y, k, lbd, gamma, alpha)
% function [Z, obj] = IMSC(X, Im, k, lbd, gamma, Y)
% 
% V = size(X, 1);
% n = size(X{1}, 2);
% max_iter = 100;
% 
% % init 
% beta = ones(V,1)/V;
% for v=1:V
%     X{v}(:,Im{v}) = 0;
% end
% [Z] = init_Z(X, beta, lbd);
% 
% E = zeros(n,n);
% C1 = zeros(n,n);
% 
% t = 0;
% flag = 1;
% miu = 0.01; % 0.01
% rho = 1.1; % 1.1
% lambda2  = 10000;%00000
% 
% while flag
%     %% update F
%     %[F] = update_F(Z-E, k);  %%% input is Z-E instead of Z
%     [F] = update_F(Z-E, k, Y);  %%% input is Z-E instead of Z
% 
%     %% update Z
%     [Z] = update_Z(X, F, E, Im, beta, lbd, gamma, 1);
%    % [Z] = update_Z(X, F, E, Im, beta, lbd, gamma);
%     %% update X
%     [X] = update_X(X, Im, Z);
%     %% update E
%     [E] = update_E(Z, F, miu, C1, lambda2);
%     %% update C1
%     leq1 = Z-F'*F-E;
%     C1 = C1 + miu*leq1;
%     %% update beta 
%     % [beta] = update_beta(X, Z);
%     %% cal obj
%     t = t+1;
%     [obj(t),~,~,~] = cal_obj(X, Z, F, E, beta, lbd, gamma, lambda2);
%     if t>=2 && (abs((obj(t-1)-obj(t))/(obj(t)))<1e-4 || t>max_iter)
%         flag =0;
%     end
%     % Update miu %
%     miu = min(rho*miu,1e8);
% 
%     % Call label_propagation after each iteration
%     Y_propagated = label_propagation(Z, Y, alpha, 20);
% 
%     % Update clustering results (e.g., F) with propagated labels
%     % This step depends on your specific implementation and data representation
%     % For example, you can update F according to Y_propagated
% end
% end

