function F_k = SolveImplicitMatrixEqn(P_k,h,J_d,tol)
% ----------------------------------------------------------------
% This function solves the implicit matrix equation arising in 
% Discrete Mechanics of rigid-body rotations evolving on SO(3) 
% using a Newton-Raphson type algorithm on the SO(3) manifold 
% to find the incremental rotation matrix F_k.
% ----------------------------------------------------------------
% skew(h*P_k) = F_k J_d - J_d F_k' 
% where P_k is the conjugate momentum at the kth time instant and 
% F_k is the incremental rotation matrix
% F_k = exp(skewfun(w));
% ----------------------------------------------------------------

w = [0 0 0]'; 
norm_f = 1e10;

dFdw1 = skewfun([1,0,0]);
dFdw2 = skewfun([0,1,0]);
dFdw3 = skewfun([0,0,1]);
count = 0;
while norm_f>=tol
    
    n = skewfun(w);
    F_k = expm(n);
    A  = F_k*J_d-J_d*F_k'-h*skewfun(P_k);
    f = veemap(A);
    dfdw1 = veemap(F_k*dFdw1*J_d+J_d*F_k'*dFdw1);
    dfdw2 = veemap(F_k*dFdw2*J_d+J_d*F_k'*dFdw2);
    dfdw3 = veemap(F_k*dFdw3*J_d+J_d*F_k'*dFdw3);

    Df = [dfdw1 dfdw2 dfdw3]';
    w = w-Df\f;
    norm_f = norm(f);
    count = count+1;
    if count>100
        msg = ['The Implicit Equation does not have a solution as the time step provided is too high. \n' ,...
               'Try reducing the time step'];
        error('u:stuffed:it',msg);
    end
end
F_k = expm(skewfun(w));
end