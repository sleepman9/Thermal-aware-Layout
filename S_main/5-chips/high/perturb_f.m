% 扰动函数
%不同概率的扰动方式
function perturbed_components = perturb_f(components,PCB)
    perturbed_components = copy(components); 

    % 获取PCB的尺寸
    pcbL = PCB{1}.pcbL;
    pcbW = PCB{1}.pcbW;

    for i = 1:length(perturbed_components)
%     i = randi(length(perturbed_components));
    % 获取组件的当前位置
    x_i0 = perturbed_components{i}.pos(1);
    y_i0 = perturbed_components{i}.pos(2);

    % 生成随机步长
    R_x = (rand() - 0.5);
    R_y = (rand() - 0.5);

    % 设置DL和DW为各自边长1倍，调整以适应随机移动的幅度
    DL = 1 * perturbed_components{i}.size(1);
    DW = 1 * perturbed_components{i}.size(2);

    % 计算新的位置
    x_i = x_i0 + R_x * DL;
    y_i = y_i0 + R_y * DW;

    % 确保组件在PCB内
    gap =5;
    x_i = max(x_i, 0); % 确保x坐标不小于基准
    y_i = max(y_i, 0); % 确保y坐标不小于基准
    x_i = min(x_i, pcbL - perturbed_components{i}.size(1)-gap); % 确保组件不会超出PCB的长度
    y_i = min(y_i, pcbW - perturbed_components{i}.size(2)-gap); % 确保组件不会超出PCB的宽度

    % 更新组件的位置信息
    perturbed_components{i}.pos = [x_i, y_i];
    end

    % 检查新位置是否有重叠
    if isAnyOverlap(perturbed_components)
%         perturbed_components = components; 
        fprintf("There has overlap！！！\n");
        perturbed_components = perturb_f(components,PCB);
    else
        fprintf("Successful perturbation without overlap.\n");
    end
    
end


