function check_Moment(M)
size_M = size(M);
if size_M(1)~=3 
    msg = 'Moment series is not a 3xN matrix';
    error(msg)
end

if ~isnumeric(M)
    msg = 'Moment series is not numeric';
    error(msg)
end

if ~isreal(M)
    msg = 'Moment series is not real';
    error(msg)
end

end