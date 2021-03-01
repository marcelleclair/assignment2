set(0,'DefaultFigureWindowStyle','docked')

ny = 50;
nx = 1.5*ny;
G = zeros(nx*ny);
F = zeros(nx*ny,1);
F(1:ny) = 1;
% F((nx-1)*ny+1:nx*ny) = 1;

ds = 1/ny; % node separation, assumed dx = dy = ds
B = 1 / (ds^2); % coefficient for bulk nodes

% Conductivity Map
cMap = ones(ny,nx);
wb = 0.2;
lb = 0.2;
nby = floor(ny*(wb/1));
nbx1 = ceil(nx*((1.5 - lb)/3));
nbx2 = floor(nx*((1.5 + lb)/3));
cMap([1:nby],[nbx1:nbx2]) = 1e-2;
cMap([ny-nby:ny],[nbx1:nbx2]) = 1e-2;

%Build gradient matrix
for x = 1 : nx
  for y = 1 : ny
    n = (x-1)*ny + y;
    if x == 1
      % left edge
      G(n,n) = 1; % fixed BC
    elseif x == nx
      % right edge
      G(n,n) = 1; % fixed BC
    elseif y == 1
%       % bottom edge
%       G(n,n) = 1; % fixed BC
      % free BC (dV/dy = 0)
      G(n, n) = 1;
      G(n, n+1) = -1; 
    elseif y == ny
%       % top edge
%       G(n,n) = 1; % fixed BC
      % free BC (dV/dy = 0)
      G(n, n) = 1;
      G(n, n-1) = -1;
    else
      % bulk node
      cxm = (cMap(y,x) + cMap(y,x-1))/2;
      cxp = (cMap(y,x) + cMap(y,x+1))/2;
      cym = (cMap(y,x) + cMap(y-1,x))/2;
      cyp = (cMap(y,x) + cMap(y+1,x))/2;
      G(n,n) = -(cxm + cxp + cym + cyp);
      G(n,n-1) = cym;
      G(n,n+1) = cyp;
      G(n,n-ny) = cxm;
      G(n,n+ny) = cxp;
    end
  end
end

V = G\F;
% x and y values for plot axes
x = linspace(0, 1.5, nx);
y = linspace(0, 1, ny);

V_map = reshape(V,[ny,nx]);
[Ex,Ey] = gradient(V_map,ds);
Ex = -1.*Ex;
Ey = -1.*Ey;
Jx = cMap.*Ex;
Jy = cMap.*Ey;
% Plot Conductivity
figure(1)
pcolor(x,y,cMap);
xlabel('x');
ylabel('y');
xlim([0 1.5]);
ylim([0 1]);
colorbar
pbaspect([1.5 1 1]);
titlestring = strcat('Conductivity (W_b = ',string(wb),', L_b = ',string(lb),')');
title(titlestring);
% Plot Potential
figure(2)
surf(x,y,V_map);
pbaspect([1.5 1 1])
view([1 -2 1])
titlestring = strcat('Potential (W_b = ',string(wb),', L_b = ',string(lb),')');
title(titlestring)
% Plot Electric Fields
figure(3)
quiver(x,y,Ex,Ey, 3);
xlabel('x');
ylabel('y');
xlim([0 1.5]);
ylim([0 1]);
pbaspect([1.5 1 1]);
titlestring = strcat('Electric Field (W_b = ',string(wb),', L_b = ',string(lb),')');
title(titlestring);
% Plot Current Density
figure(4)
quiver(x,y,Jx,Jy, 3);
pbaspect([1.5 1 1])
xlabel('x');
ylabel('y');
xlim([0 1.5]);
ylim([0 1]);
pbaspect([1.5 1 1]);
titlestring = strcat('Current Density (W_b = ',string(wb),', L_b = ',string(lb),')');
title(titlestring);