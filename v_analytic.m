function V = v_analytic(x,y,N)

a = 1;
b = 0.75;
V0 = 1;

% initialize potential vector
V = zeros(1,length(x));
% intermediate function to be summed over odd n
fi = @(x,y,n) (cosh((n.*pi.*x)./a) .* sin((n.*pi.*y)./a)) ./ (n .* cosh((n.*pi.*b)./a));

for n = 1 : N
    k = 2*n - 1;
    V = V + fi(x,y,k);
end

V = ((4 * V0) / pi) .* V;

end