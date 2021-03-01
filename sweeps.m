% % sweep current vs mesh size
% wb = 0.2;
% lb = 0.2;
% sigb = 1e-2;
% v_n = [];
% v_I1 = [];
% v_I2 = [];
% for n = 5 : 40
%     ny = 2*n;
%     [~,~,~,~,~,I1,I2] = v_fd(ny,wb,lb,sigb);
%     v_n = [v_n ny];
%     v_I1 = [v_I1 I1];
%     v_I2 = [v_I2 I2];
% end
% 
% rho = v_n ./ 1;
% hold on
% plot(rho,v_I1);
% plot(rho,v_I2);
% ylabel('I (A)');
% xlabel('Divisions per uint space')
% legend('Current In', 'Current Out');
% hold off

% sweep of current vs bottleneck size
sigb = 1e-2;
ny = 50;

dw = 0.1;
dl = 0.1;

wb = zeros(4,14);
lb = zeros(4,14);
Ii = zeros(4,14);
Io = zeros(4,14);

for n = 1 : 4
    for m = 1 : 14
        [~,~,~,~,~,I1,I2] = v_fd(ny,n*dw,m*dl,sigb);
        Ii(n,m) = I1;
        Io(n,m) = I2;
        wb(n,m) = n*dw;
        lb(n,m) = m*dl;
    end
end

% % sweep of current vs sigma
% wb = 0.2;
% lb = 0.2;
% ny = 50;
% 
% v_sigb = [];
% v_I1 = [];
% v_I2 = [];
% 
% for n = 0 : 24
%     sigb = 10^(-n/2);
%     [~,~,~,~,~,I1,I2] = v_fd(ny,wb,lb,sigb);
%     v_I1 = [v_I1 I1];
%     v_I2 = [v_I2 I2];
%     v_sigb = [v_sigb sigb];
% end
% 
% semilogx(v_sigb,v_I1);
% xlabel('Bottleneck Conductivity');
% ylabel('Current (A)');
% title('Current vs Bottleneck Conductivity (W_b = 0.2, L_b = 0.2)');
