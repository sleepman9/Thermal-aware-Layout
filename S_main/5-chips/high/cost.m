% 计算成本函数
function [updated_components, cost_value] = cost(components,PCB,step)
    updated_components = update_temperature(components,PCB,step);
    
    % 预分配内存
    num_components = length(updated_components);
    A = zeros(1, num_components);
    
    for i = 1:num_components
        A(i) = updated_components{i}.temp;
    end
%     cost_value_1 = max(A);  
%     cost_value_2 = mean(A);  
%     cost_value = cost_value_1 * cost_value_2;
    cost_value = max(A); 
end 

