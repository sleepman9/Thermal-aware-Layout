function main()
    tic;
    
    PCB = {struct('pcbL',215,'pcbW',155,'pcbH',15)};
    components = {
        struct('temp', 0, 'pos', [30, 75], 'size', [30, 30, 20]),   % 芯片1
        struct('temp', 0, 'pos', [135, 120], 'size', [20, 25, 20]), % 芯片2
        struct('temp', 0, 'pos', [75, 120], 'size', [30, 25, 20]),  % 芯片3
        struct('temp', 0, 'pos', [90, 30], 'size', [35, 35, 10]),   % 芯片4
        struct('temp', 0, 'pos', [75, 75], 'size', [40, 20, 15]),   % 芯片5
    };

    max_iter = 200;     
    
%     pos = initialize_particles(components)

    best_pos = PSO(@get_temp, components, max_iter);

    
    disp('best_pos:');
    for i = 1:size(best_pos, 1)
        disp(['chip', num2str(i), 'position: [', num2str(best_pos(i, :)), ']']);
    end
    
    elapsed_time = toc;
    disp(['time', num2str(elapsed_time), 's']);
end


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

%     num_components = length(components); % ��ȡ�������?

    % �ռ����������λ������?
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
    
    

    % ʹ��cell���������ձ䳤�����?
      [T1,T2,T3,T4,T5] =  Thermal_20240626_SAtest_5chip(positions{:});
%       filename = sprintf('op-origin05151825.mph');
%       mphsave(filename);
      T = [T1,T2,T3,T4,T5]; 
      temperature = max(T);
    
end

% function updated_components = update_temperature(components,PCB,step)


function best_pos = PSO(obj_func, components, max_iter)
%     current_components = copy(components);
    % 使用PSO算法进行优化
    % obj_func为目标函�?  也就是上面的get_temp
    % num_particles为粒子数�?
    % max_iter为最大迭代次�?
    num_particles = length(components);
    % 设置参数
    c1 = 1.5;  % Nostalgia
    c2 = 1.5;  % Envy
%     c_star1 = 0.1;  % Nostalgia-rotation bit
%     c_star2 = 0.1;  % Envy-rotation bit
    w = 0.9;  % Inertia
%     Vmax_x = 3;  % Clamping constant-x direction
%     Vmax_y = 5;  % Clamping constant-y direction
%     V_star_max = 0.3;  % Clamping constant-rotation bit
    
    % 初始化粒子位置和速度
    pos = initialize_particles(components); % 初始化粒子位�?
    vel = (rand(num_particles, 2)-0.5) * 8;    % 随机生成初始速度  5��2
    
    % 初始化最优位置和�?优�??
    best_pos = pos;
%     best_pos = initialize_particles(current_components);
    
    best_val = obj_func(best_pos);
    p_best_cost = best_val;
%     best_val = get_temp(current_components,PCB);

    cur_pos = pos;
    p_best_pos = pos;
    % �?始迭�?
    for iter = 1:max_iter
        % 更新粒子位置和�?�度
%         r1 = rand(num_particles, 2);
%         r2 = rand(num_particles, 2);
%         r_star1 = rand(num_particles, 1);
%         r_star2 = rand(num_particles, 1);
% 
%         vel = w * vel + c1 * r1 .* (best_pos - pos) + c2 * r2 .* (best_pos - pos) ...
%             + c_star1 * r_star1 .* (best_pos - pos) + c_star2 * r_star2 .* (best_pos - pos);
% 
%         Clamping constant
%         vel(vel(:,1) > Vmax_x, 1) = Vmax_x;
%         vel(vel(:,1) < -Vmax_x, 1) = -Vmax_x;
%         vel(vel(:,2) > Vmax_y, 2) = Vmax_y;
%         vel(vel(:,2) < -Vmax_y, 2) = -Vmax_y;
% 
%         % 更新粒子位置
%         cur_pos = pos + vel;

%          cur_pos = perturb(num_particles,w,vel,c1,best_pos,cur_pos,components);
         cur_pos = perturb(num_particles,w,vel,c1,c2,best_pos,p_best_pos,cur_pos,components);
        
%         cur_pos = perturb(num_particles,w,vel,c1,best_pos,cur_pos,c2,c_star1,c_star2,Vmax_x,Vmax_y,components);
        
%         for i = 1:num_particles
%             components{i}.pos = cur_pos(i,:);
%         end
%     
%         if isAnyOverlap(components)
% %         perturbed_components = components; 
%         fprintf("There has overlap������\n");
%         cur_pos = 
% %         perturbed_components = perturb_f(components,PCB);
% %     else
% %         fprintf("Successful perturbation without overlap.\n");
%         end
        
        

        % 边界处理
%         pos = bound_check(pos);
% 
%         % �?查芯片之间的距离
%         pos = check_min_distance(pos);

        % 更新�?优位置和�?优�??
        val = obj_func(cur_pos);
        if val < p_best_cost
           p_best_pos = cur_pos;
        end
        
        disp(['step: ', num2str(iter), ', cur_cost: ', num2str(val)]);
       if (val < best_val)
            best_val = val;
            best_pos= cur_pos;
        end

        % 打印当前位置
%         if mod(iter, 10) == 0
%             disp(['step: ', num2str(iter)]);
%             disp('当前粒子位置:');
%             disp(cur_pos);
%         end
        % 显示迭代进度
        disp(['step: ', num2str(iter), ', best_cost: ', num2str(min(best_val))]);
    end
end

function pos = initialize_particles(components)
    % 初始化粒子位�?
    
    % 随机生成每个芯片的横纵坐标，确保在PCB板内且不重叠
    num_particles = length(components);
    pos = zeros(num_particles, 2);
%     for i = 1:num_particles
%         pos(i, :) = rand(1, 2) * 50; % 随机生成位置
%     end
    for i = 1:num_particles
            pos(i, :) = components{i}.pos; % 随机生成位置
    end
    
    % 边界处理
%     pos = bound_check(pos);
end



function pos = bound_check(pos)
    % 边界处理，确保粒子位置在PCB板内
    
    % 确保粒子的横纵坐标在合理范围�?
    pos(pos < 0) = 0;
    pos(pos(:,1) > 215, 1) = 215;
    pos(pos(:,2) > 155, 2) = 155;
end

function pos = check_min_distance(pos)
    % �?查芯片之间的距离，确保至少相隔n个单位距�?
    dis = 1;
    % 计算每对芯片之间的距�?
    num_particles = size(pos, 1);
    for i = 1:num_particles-1
        for j = i+1:num_particles
            d = norm(pos(i,:) - pos(j,:)); % 计算欧氏距离
            if d < dis
                % 如果距离小于1，则调整位置使得距离至少�?1
                pos(j,:) = pos(i,:) + (pos(j,:) - pos(i,:)) / d;
            end
        end
    end
end
