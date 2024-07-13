tic;
initial_temp = 50.0;
final_temp = 0.1;
alpha = 0.97; % ��ȴϵ��
max_steps =200; % ����������

% ��ʼ��PCB�����е����??
PCB = {struct('pcbL',215,'pcbW',155,'pcbH',15)};



components = {
    struct('temp', 0, 'pos', [30, 75], 'size', [30, 30, 20]),   % 缁勪�?1
    struct('temp', 0, 'pos', [135, 120], 'size', [20, 25, 20]),   % 缁勪�?2
    struct('temp', 0, 'pos', [75, 120], 'size', [30, 25, 20]),   % 缁勪�?3
    struct('temp', 0, 'pos', [90, 30], 'size', [35, 35, 10]),   % 缁勪�?4
    struct('temp', 0, 'pos', [75, 75], 'size', [40, 20, 15]),   % 缁勪�?5
};

   
% ��ʼģ���˻����??
optimized_components = simulated_annealing(components, initial_temp,final_temp, alpha, max_steps,PCB);
figure(3);
plot_layout(optimized_components, PCB);
title('Optimal PCB Layout');

% ����Ż���Ĳ��ֽ��??
%fprintf("�Ż���Ĳ��ֳɱ���?? %.2f\n", cost(optimized_components));

for i = 1:length(optimized_components)
    fprintf("λ��: [%d, %d], ��������¶�??: %.2f\n", optimized_components{i}.pos(1), optimized_components{i}.pos(2), optimized_components{i}.temp);
end

toc;





    

















