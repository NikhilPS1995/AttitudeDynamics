function check_inertia(m,J)
size_m = size(m);
if size_m(1)*size_m(2) ~= 1
    msg = 'mass is not a scalar';
    error(msg);
end
if ~isnumeric(m)
    msg = 'mass is not numeric';
    error(msg);
end
if m <= 0 
    msg = 'mass is not positive';
    error(msg);
end

size_J = size(J);
if size_J(1)~=3 || size_J(2) ~= 3
    msg = 'The Inertia Matrix is not a 3x3 matrix';
    error(msg)
end

if ~isnumeric(J)
    msg = 'The Inertia Matrix is not numeric';
    error(msg)
end

tf = issymmetric(J);
d = eig(J);
isposdef = all(d > 0);
if tf == 0
    msg = 'The Inertia Matrix is not symmetric';
    error(msg)
end
if isposdef == 0
    msg = 'The Inertia Matrix is not Positive Definite';
    error(msg)
end
eps = 1e-14;
if d(3)>=d(1)+d(2) || 1-eps > min(d(3)/d(2),d(2)/d(1)) || min(d(3)/d(2),d(2)/d(1)) > 0.5*(1+sqrt(5))+eps
    msg = 'An Inertia Matrix with the given entries is not physically possible';
    error(msg)
end
    
end