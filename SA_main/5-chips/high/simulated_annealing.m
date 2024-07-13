% SA
function best_components = simulated_annealing(components, initial_temp,final_temp, alpha, max_steps,PCB)
    current_components = copy(components);
    best_components = copy(components);
    
    step = 1;
    [current_components, current_cost] = cost(current_components,PCB,step);
    
%     plot original layout
    figure(1);
    plot_layout(current_components, PCB);
    title('Original PCB Layout');
    
    best_cost = current_cost;
    cost_values = [current_cost]; %���ڴ��ÿ���ĳɱ��?
    
    current_temp = initial_temp;
    

%     for step = 1:max_steps
    while current_temp > final_temp && step <= max_steps 
        s = rand();
        if s > 0.5
            new_components = perturb_f(current_components,PCB);
        else
            new_components = perturb_c(current_components,PCB);
        end
        
        % ����������ĳɱ��͸�������¶�
        [new_components, new_cost] = cost(new_components,PCB,step);
        
        cost_diff = new_cost - current_cost;

        accepted = false;

        %����³ɱ����ͻ����SA׼����ܽϲ��
        if cost_diff < 0 || rand() < exp(-cost_diff / current_temp)
            current_components = new_components;
            current_cost = new_cost;  % ���µ�ǰ�ɱ�
            fprintf('���� %d Accept!!!',step);
            accepted = true;  % �������Ŷ�������
            cost_values = [cost_values, current_cost]; % �����ܵĳɱ����ӵ��б�
        else
            fprintf('���� %d Unaccept!!!',step);
            cost_values = [cost_values, current_cost];
        end
        
        % �ж��Ƿ��ҵ����µ����Ž�
        if current_cost < best_cost
            best_components = copy(current_components);
            best_cost = current_cost;
%             fprintf('���� %d ��Ϊ�µ���Ѳ��֣���ǰ��ѳɱ�: %.2f\n', step, best_cost);
        end

        % ��ȴ
        current_temp = current_temp * alpha;
        if accepted 
            % ��ӡ��ǰ������Ϣ
            fprintf('���� %d, ��ǰ�¶�: %.2f, ��ǰ�ɱ�: %.2f\n', step, current_temp, current_cost);
        end
            % ��ͼ��ʵʱ��ʾ���ܵ�cost_valuesֵ
            figure(2);
            subplot(2, 1, 1);
            plot(cost_values, 'LineWidth', 2);
            title('High cost Change');
            xlabel('Steps');
            ylabel('Cost');
            grid on;

            % ʵʱ��ʾ��ǰ����
            subplot(2, 1, 2);
            plot_layout(current_components, PCB);
            drawnow;
        
        
            step = step + 1;
    end
end

