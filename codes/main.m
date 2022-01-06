clear;close all;clc;
%% Input the inertia tensor here
promptJ = 'Provide the Inertia Tensor (3x3 Symmetric Positive Definite) [press Enter for default values]: ';
J = input(promptJ);
if isempty(J)
    J = 100*[0.5 0 0;0 1 0;0 0 1.25];
end
promptm = 'Provide the mass of the object (positive scalar) [press Enter for default values]: ';
m = input(promptm);
if isempty(m)
    m = 1;
end

%% Check if the inertia matrix is symmetric positive definite
check_inertia(m,J);

%% Initial attitude and its conjugate momentum
promptR = 'Provide the initial orientation as an axis and angle pair \n (direction first and angle next as a 1x4 vector) [press Enter for default values]: ';
initial_orientation = input(promptR);
if isempty(initial_orientation)
    initial_orientation = [1 0 0 0];
end
promptP = 'Provide the initial Conjugate Momentum (a 3x1 real column vector) [press Enter for default values]: ';
initial_conjugate_momentum = input(promptP);
if isempty(initial_conjugate_momentum)
    initial_conjugate_momentum = [0 0 0]';
end

check_initial_conditions(initial_orientation,initial_conjugate_momentum)

R(:,:,1) = axang2rotm(initial_orientation);
P(:,1) = initial_conjugate_momentum;
%% Step Size
prompth = 'Provide the time step size for simulation (positive scalar) [press Enter for default values]: ';
h = input(prompth);
if isempty(h)
    h = 1e-1;
end
check_h(h)
%% Moment 
promptM = 'Provide the applied Moment  (3xN matrix) [press Enter for default values]: ';
M = input(promptM);
if isempty(M)
    M = zeros(3,1000);
    M(2,:) = ones(1,1000);
end

check_Moment(M)
%% Calculation of Jd from J
Jd = 0.5*trace(J)*eye(3)-J;

%% Principal Moment of Inertia
[eig_vec,eig_val] = eig(J);
vec = (5/m)*[0 1 1;1 0 1;1 1 0]\[eig_val(1,1);eig_val(2,2);eig_val(3,3)]; 
a = sqrt(vec(1)); b = sqrt(vec(2));c = sqrt(vec(3));
[X,Y,Z] = ellipsoid(0,0,0,a,b,c);
axang_init = rotm2axang(eig_vec);
direction_init = axang_init(1:3);
angle_init = rad2deg(axang_init(4));
max_graph_dim = max([a b c]);
%% Simulation
tol = 1e-7;
for i=1:size(M,2)
    F_k = SolveImplicitMatrixEqn(P(:,i),h,Jd,tol);
    R(:,:,i+1) = R(:,:,i)*F_k;
    P(:,i+1) = F_k'*P(:,i)+h*M(:,i);
%     P(:,i+1) = F_k'*P(:,i)+h*R(:,:,i)'*M(:,i); %use this equation if you
%     are applying moment in the spatial frame
end
%% Animation
for i = 1:size(R,3)

px = R(:,:,i)*[1.5*max_graph_dim;0;0];
py = R(:,:,i)*[0;1.5*max_graph_dim;0];
pz = R(:,:,i)*[0;0;1.5*max_graph_dim];

s=surf(X,Y,Z);
rotate(s,direction_init,angle_init);
axang = rotm2axang(R(:,:,i));
direction = axang(1:3);
rotate(s,direction,rad2deg(axang(4)));

hold all
axis equal
plot3([0,1.5*max_graph_dim],[0,0],[0,0],'-.k','LineWidth',1)
plot3([0,0],[0,1.5*max_graph_dim],[0,0],'-.k','LineWidth',1)
plot3([0,0],[0,0],[0,1.5*max_graph_dim],'-.k','LineWidth',1)

plot3([0,px(1)],[0,px(2)],[0,px(3)],'-r','LineWidth',2)
plot3([0,py(1)],[0,py(2)],[0,py(3)],'-b','LineWidth',2)
plot3([0,pz(1)],[0,pz(2)],[0,pz(3)],'-g','LineWidth',2)

xlim(2*[-max_graph_dim max_graph_dim]);
ylim(2*[-max_graph_dim max_graph_dim]);
zlim(2*[-max_graph_dim max_graph_dim]);
xlabel('x')
ylabel('y')
zlabel('z')
title("Inertia Ellipsoid with mass " + m + "")

grid on
hold off

pause(h) 
end

