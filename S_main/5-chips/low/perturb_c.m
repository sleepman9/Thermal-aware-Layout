function perturbed_components = perturb_c(components,PCB)
    indices = randperm(length(components), 2);
    temp_pos = components{indices(1)}.pos;
    components{indices(1)}.pos = components{indices(2)}.pos;
    components{indices(2)}.pos = temp_pos;
    perturbed_components = components;
    
        % 获取PCB的尺寸
    pcbL = PCB{1}.pcbL;
    pcbW = PCB{1}.pcbW;
    
    for i = 1:length(perturbed_components)
        % 获取组件的当前位置
        x_i = perturbed_components{i}.pos(1);
        y_i = perturbed_components{i}.pos(2);

        % 确保组件在PCB内
        gap =5;
        x_i = max(x_i, 0); % 确保x坐标不小于基准
        y_i = max(y_i, 0); % 确保y坐标不小于基准
        x_i = min(x_i, pcbL - perturbed_components{i}.size(1)-gap); % 确保组件不会超出PCB的长度
        y_i = min(y_i, pcbW - perturbed_components{i}.size(2)-gap); % 确保组件不会超出PCB的宽度
        
        % 更新组件的位置信息
        perturbed_components{i}.pos = [x_i, y_i];
    end
    

    
    if isAnyOverlap(perturbed_components)
%         perturbed_components = components; 
        fprintf("There has overlap！！！\n");
        perturbed_components = perturb_c(components,PCB);
    else
        fprintf("Successful perturbation without overlap.\n");
    end 
end



