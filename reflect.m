function X = reflect (X, axon_radius, assignments)

A = in_fibre (X, axon_radius);

k = find(~isnan(assignments(1,:)) & any(A~=assignments,1));
if ~isempty(k)
    x = X(1:2,k) - assignments(:,k);
    n = sqrt(sum(x.^2,1));
    x = x.* (2*axon_radius./n - 1);
    X(1:2,k) = x + assignments(:,k);
end

k = find(isnan(assignments(1,:)) & any(~isnan(A),1));
if ~isempty(k)
    x = X(1:2,k) - A(:,k);
    n = sqrt(sum(x.^2,1));
    x = x.* (2*axon_radius./n - 1);
    X(1:2,k) = x + A(:,k);
end
