
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


