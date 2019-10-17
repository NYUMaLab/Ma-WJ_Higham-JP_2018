function decision = getdecision_nonlearner(mmt, T)
% Computes decision of naive male
% T is current day

X                = mmt.X;   % all measurements of all females
[~,ranking]      = sort(X(T,:),'ascend');
decision.ranking = ranking;
