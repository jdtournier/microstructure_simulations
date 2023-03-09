function X = random_step (X, step_size)

% update positions X by a random step of size step_size

arguments
    X (3,:) double
    step_size (1,1) double
end

s = randn(size(X));
s = s./sqrt(sum(s.^2,1));
X = X + step_size*s;
