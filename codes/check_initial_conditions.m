function check_initial_conditions(a,P)
size_P = size(P);
if size_P(1) ~= 3 || size_P(2) ~= 1
    msg = 'Initial Conjugate Momentum is not a 3x1 vector';
    error(msg);
end
if ~isnumeric(P)
    msg = 'Initial Conjugate Momentum is not numeric';
    error(msg);
end
if ~isreal(P)
    msg = 'Initial Conjugate is not real';
    error(msg);
end

size_a = size(a);
if size_a(1) ~= 1 || size_a(2) ~= 4
    msg = 'Direction and angle vector is not a 1x4 vector';
    error(msg);
end
if ~isnumeric(a)
    msg = 'Direction and angle vector is not numeric';
    error(msg);
end
if ~isreal(P)
    msg = 'Direction and angle vector is not real';
    error(msg);
end
end