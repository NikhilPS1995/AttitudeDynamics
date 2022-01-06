function check_h(h)
size_h = size(h);
if size_h(1)*size_h(2) ~= 1
    msg = 'time step is not a scalar';
    error(msg);
end
if ~isnumeric(h)
    msg = 'time step is not numeric';
    error(msg);
end
if h <= 0 
    msg = 'time step is not positive';
    error(msg);
end