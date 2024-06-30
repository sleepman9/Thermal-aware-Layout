function main()
    % �???始计�???
    tic;
    
    PCB = struct('pcbL',215,'pcbW',155,'pcbH',15);
    components = {
        struct('temp', 0, 'pos', [30, 75], 'size', [30, 30, 20]),   % 芯片1
        struct('temp', 0, 'pos', [135, 120], 'size', [20, 25, 20]), % 芯片2
        struct('temp', 0, 'pos', [75, 120], 'size', [30, 25, 20]),  % 芯片3
        struct('temp', 0, 'pos', [90, 30], 'size', [35, 35, 10]),   % 芯片4
        struct('temp', 0, 'pos', [75, 75], 'size', [40, 20, 15]),   % 芯片5
    };
    
    num_components = numel(components); % 设置组件数量与芯片数量相�???
    max_generations = 20;     % 设置�???大迭代次�???
    pop_size = 10; % 设置种群大小
    
    % 使用GA算法优化芯片布局
    best_pos = GA_self(@get_temp, num_components, max_generations, pop_size,PCB,components);
    
    disp('best_layout:');
    for i = 1:size(best_pos, 1)
        disp(['chip', num2str(i), 'position: [', num2str(best_pos(i, :)), ']']);
    end
    
    % 结束计时并显示运行时�???
    elapsed_time = toc;
    disp(['time:', num2str(elapsed_time), 's']);
end


% function temperature = get_temp(pos)
% 
%     % 计算给定布局的结�???
%     % pos为芯片的位置矩阵，每�???行代表一个芯片的位置，例如[pos1; pos2; ...]
%     % 返回结温�???
%     
%     % �???单示例：假设结温与芯片之间的距离成反�???
%     distance = pdist(pos); % 计算芯片间的欧几里得距离
%     % temperature = sum(1 ./ distance); % 结温为距离的倒数之和
%     rng('shuffle'); % 使用当前时间作为种子
%     temperature = rand()* 10000; % 使用 rand 函数生成�???个随机数作为结温 代替
%     
%     % 这里可以根据实际情况修改计算结温的方�???
% 
% end



function temperature = get_temp(pos)

    PCB1 = {struct('pcbL',215,'pcbW',155,'pcbH',15)};

    components1 = {
    struct('temp', 0, 'pos', [30, 75], 'size', [30, 30, 20]),   % 组件1
    struct('temp', 0, 'pos', [135, 120], 'size', [20, 25, 20]),   % 组件2
    struct('temp', 0, 'pos', [75, 120], 'size', [30, 25, 20]),   % 组件3
    struct('temp', 0, 'pos', [90, 30], 'size', [35, 35, 10]),   % 组件4
    struct('temp', 0, 'pos', [75, 75], 'size', [40, 20, 15]),   % 组件5
};

    [num_components, ~] = size(pos);

%     num_components = length(components); % ��ȡ�������????

    % �ռ����������λ������????
    positions = cell(1, num_components * 2);
    for i = 1:num_components
%         positions(2*i-1:2*i) = num2cell(components{i}.pos);
    positions(2*i-1:2*i) = num2cell(pos(i,:));
    end
%     positions(num_components * 2+1) = num2cell(PCB{1}.pcbL);
%     positions(num_components * 2+2) = num2cell(PCB{1}.pcbW);
%     positions(num_components * 2+3) = num2cell(PCB{1}.pcbH);
%     for i = 1:num_components
%         positions((num_components * 2 +3)+3*i-2:(num_components * 2 +3)+3*i) = num2cell(components{i}.size);
%     end
%     positions(num_components*5+4) = num2cell(9);
    positions(num_components * 2+1) = num2cell(PCB1{1}.pcbL);
    positions(num_components * 2+2) = num2cell(PCB1{1}.pcbW);
    positions(num_components * 2+3) = num2cell(PCB1{1}.pcbH);
    for i = 1:num_components
        positions((num_components * 2 +3)+3*i-2:(num_components * 2 +3)+3*i) = num2cell(components1{i}.size);
    end
    positions(num_components*5+4) = num2cell(1);
    
    

    % ʹ��cell���������ձ䳤�����????
      [T1,T2,T3,T4,T5] =  CHIP5_20240606_SAtest(positions{:});
%       filename = sprintf('op-origin05151825.mph');
%       mphsave(filename);
      T = [T1,T2,T3,T4,T5]; 
      temperature = max(T);
    
end




function best_pos = GA_self(obj_func, num_components, max_generations, pop_size,PCB,components)
    % 使用GA算法进行优化
    % obj_func为目标函�???  也就是上面的get_temp
    % num_components为组件数�???
    % max_generations为最大迭代次�???
    % pop_size为种群大�???
    
    % 设置参数
    pc = 0.8;  % Crossover probability
    pm = 0.05;  % Mutation probability
    pm_star = 0.1;  % Mutation probability - rotation bit
    
    % 初始化种�???
    population = initialize_population(pop_size, num_components);  %10x10
    
    best_fitness = zeros(max_generations, 1);
    best_pos_all = zeros(max_generations, num_components * 2);

    for generation = 1:max_generations
        % 计算适应�???
        fitness = evaluate_population(population, obj_func,PCB,components);   %10x1

        % 打印每个个体的芯片位置和对应的�?�应度�??
%         if mod(generation, 10) == 0
%             for i = 1:size(population, 1)
%                 % 从种群中提取当前个体的芯片位�???
%                 individual_pos = reshape(population(i, :), [num_components, 2]);
% 
%                 % 计算当前个体的�?�应度�??
%                 individual_fitness = fitness(i);
% 
%                 % 调用 get_temp 函数计算适应度�??
%                 individual_temp = obj_func(individual_pos);
% 
%                 % 打印当前个体的芯片位置和适应度�??
%                 disp(['Individual ', num2str(i), ' - Temperature: ', num2str(individual_temp)]);
%                 disp(['Position: ', num2str(individual_pos(1, :)), ', ', num2str(individual_pos(2, :))]);
%                 disp(['Fitness: ', num2str(individual_fitness)]);
%             end
%         end

        % 记录当前代的�???优解
        [best_fitness(generation), best_idx] = min(fitness);
        best_pos_all(generation, :) = population(best_idx, :);
        
        % 打印当前代数
        disp(['step: ', num2str(generation),'cur_cost:',num2str(best_fitness(generation))]);

        % 选择
        selected_parents = selection(population, fitness);

        % 交叉
        children = crossover(selected_parents, pc);

        % 变异
        mutated_children = mutation(children, pm, pm_star);

        % 更新种群
        population = [selected_parents; mutated_children];

        
    end

    % 在所有迭代中选择�???好的�???
    [op_cost, best_generation] = min(best_fitness);
    best_pos = reshape(best_pos_all(best_generation, :), [num_components, 2]);
    disp(['op_cost:', num2str(op_cost)]);
end



function population = initialize_population(pop_size, num_components)
    % 初始化种�???
    
    % 生成随机种群
    population = rand(pop_size, num_components * 2) * 170; % 生成0-215之间的随机位�???
end

function fitness = evaluate_population(population, obj_func,PCB,components)
    % 计算种群中每个个体的适应�???
    
    num_individuals = size(population, 1);
    num_components = size(population, 2) / 2;
    fitness = zeros(num_individuals, 1);     %10x1
    
    for i = 1:num_individuals
        % 提取个体的位�???
        pos = reshape(population(i, :), [num_components, 2]);
        
        %check overlap
        for j = 1:size(pos,1)
        gap =5;  
        pos(j,1) = max(pos(j,1), 0); % ȷ��x���겻С�ڻ�׼
        pos(j,2) = max(pos(j,2), 0); % ȷ��y���겻С�ڻ�׼
        pos(j,1) = min(pos(j,1), PCB.pcbL - components{j}.size(1)-gap); % ȷ��������ᳬ��PCB�ĳ���
        pos(j,2) = min(pos(j,2), PCB.pcbW - components{j}.size(2)-gap); % ȷ��������ᳬ��PCB�Ŀ���
        components{j}.pos = pos(j,:);
        end
    
        while isAnyOverlap(components)
%             fprintf("There has overlap������\n"); 
            
            population(i,:) = rand(1, num_components * 2) * 170;
            pos = reshape(population(i, :), [num_components, 2]);

            for h = 1:size(pos,1)
                gap =5;  
                pos(h,1) = max(pos(h,1), 0); % ȷ��x���겻С�ڻ�׼
                pos(h,2) = max(pos(h,2), 0); % ȷ��y���겻С�ڻ�׼
                pos(h,1) = min(pos(h,1), PCB.pcbL - components{h}.size(1)-gap); % ȷ��������ᳬ��PCB�ĳ���
                pos(h,2) = min(pos(h,2), PCB.pcbW - components{h}.size(2)-gap); % ȷ��������ᳬ��PCB�Ŀ���
                components{h}.pos = pos(h,:);           
            end

        end
        
        % 计算适应�???
        fitness(i) = obj_func(pos);
    end
end

function selected_parents = selection(population, fitness)
    % 选择
    
%     [~, sorted_idx] = sort(fitness, 'descend');
    [~, sorted_idx] = sort(fitness, 'ascend');
    selected_parents = population(sorted_idx(1:end/2), :);
end

function children = crossover(selected_parents, pc)
    % 交叉
    
    num_parents = size(selected_parents, 1);
    num_components = size(selected_parents, 2) / 2;
    
    children = zeros(num_parents, num_components * 2);
    
    for i = 1:num_parents
        parent1_idx = randi([1, num_parents], 1);
        parent2_idx = randi([1, num_parents], 1);
        
        parent1 = selected_parents(parent1_idx, :);
        parent2 = selected_parents(parent2_idx, :);
        
        if rand() < pc
            crossover_point = randi([1, num_components], 1);
            children(i, :) = [parent1(1:crossover_point), parent2(crossover_point+1:end)];
        else
            children(i, :) = parent1;
        end
    end
end

function mutated_children = mutation(children, pm, pm_star)
    % 变异
    
    num_children = size(children, 1);
    num_components = size(children, 2) / 2;
    
    mutated_children = children;
    
    for i = 1:num_children
        if rand() < pm
            mutation_point = randi([1, num_components * 2], 1);
            mutated_children(i, mutation_point) = rand() * 170;
        end
        
        if rand() < pm_star
            mutation_point = randi([1, num_components], 1);
            mutated_children(i, mutation_point) = rand() * 155;
        end
    end
end
