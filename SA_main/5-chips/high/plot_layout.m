
function plot_layout(components, PCB)
    % 清除当前图形
    cla;
    
    % 绘制PCB边界
    rectangle('Position', [-5, -5, PCB{1}.pcbL, PCB{1}.pcbW], 'EdgeColor', 'k', 'LineWidth', 2);
    hold on;
    
    % 遍历所有组件并绘制它们的位置和尺寸
    for i = 1:length(components)
        pos = components{i}.pos;
        size = components{i}.size;
        temp = components{i}.temp;
        
        % 使用颜色来表示温度
        % 假设温度范围在0到100之间，可以根据实际情况调整
        % 并确保颜色值在0到1的范围内
        color = [min(1, max(0, 1 - temp / 100)), 0, min(1, max(0, temp / 100))];
        
        % 绘制组件
        rectangle('Position', [pos(1), pos(2), size(1), size(2)], 'FaceColor', color, 'EdgeColor', 'b');
        
        % 计算合适的字体大小
        % 字体大小与组件的最小尺寸成比例
        fontSize = min(size(1), size(2))/2;
        
        % 在组件中央显示温度值
        text(pos(1) + size(1) / 2, pos(2) + size(2) / 2, sprintf('%.2f', temp), ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
             'Color', 'w', 'FontSize', fontSize, 'FontWeight', 'bold');
    end
    
    % 设置图形属性
    axis equal;
    xlim([-15, PCB{1}.pcbL + 15]);
    ylim([-15, PCB{1}.pcbW + 15]);
    xlabel('X Position');
    title('PCB Layout');
    ylabel('Y Position');
    grid on;
    hold off;
end