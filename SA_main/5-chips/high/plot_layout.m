
function plot_layout(components, PCB)
    % �����ǰͼ��
    cla;
    
    % ����PCB�߽�
    rectangle('Position', [-5, -5, PCB{1}.pcbL, PCB{1}.pcbW], 'EdgeColor', 'k', 'LineWidth', 2);
    hold on;
    
    % ��������������������ǵ�λ�úͳߴ�
    for i = 1:length(components)
        pos = components{i}.pos;
        size = components{i}.size;
        temp = components{i}.temp;
        
        % ʹ����ɫ����ʾ�¶�
        % �����¶ȷ�Χ��0��100֮�䣬���Ը���ʵ���������
        % ��ȷ����ɫֵ��0��1�ķ�Χ��
        color = [min(1, max(0, 1 - temp / 100)), 0, min(1, max(0, temp / 100))];
        
        % �������
        rectangle('Position', [pos(1), pos(2), size(1), size(2)], 'FaceColor', color, 'EdgeColor', 'b');
        
        % ������ʵ������С
        % �����С���������С�ߴ�ɱ���
        fontSize = min(size(1), size(2))/2;
        
        % �����������ʾ�¶�ֵ
        text(pos(1) + size(1) / 2, pos(2) + size(2) / 2, sprintf('%.2f', temp), ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
             'Color', 'w', 'FontSize', fontSize, 'FontWeight', 'bold');
    end
    
    % ����ͼ������
    axis equal;
    xlim([-15, PCB{1}.pcbL + 15]);
    ylim([-15, PCB{1}.pcbW + 15]);
    xlabel('X Position');
    title('PCB Layout');
    ylabel('Y Position');
    grid on;
    hold off;
end