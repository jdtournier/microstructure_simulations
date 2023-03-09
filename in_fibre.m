function A = in_fibre (X, axon_radius)

A = nan(2,size(X,2));
x = X([1 2],:);
c = round(x./[1 sqrt(3)]');
p = x-c.*[1 sqrt(3)]';
k = sum(p.^2,1) < axon_radius^2;
A(:,k) = c(:,k).*[1 sqrt(3)]';

x = x - [0.5 sqrt(3)/2]';
c = round(x./[1 sqrt(3)]');
p = x-c.*[1 sqrt(3)]';
k = sum(p.^2,1) < axon_radius^2;
A(:,k) = c(:,k).*[1 sqrt(3)]' + [0.5 sqrt(3)/2]';
