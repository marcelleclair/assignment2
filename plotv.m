x = linspace(-0.75,0.75,75);
y = transpose(linspace(0,1,50));
X = repmat(x,50,1);
Y = repmat(y,1,75);

V = v_analytic(X,Y,1);

for n = 2 : 100
    Vp = V;
    V = v_analytic(X,Y,n);
    surf(X,Y,V);
    xlabel('x');
    ylabel('y');
    pbaspect([1.5 1 1])
    pause(0.05);
    delta = (V - Vp)./Vp;
    if ~any(delta > 0.0001)
        break
    end
end
fprintf("Series truncated at %d terms (n = %d)\n", n, 2*n - 1);