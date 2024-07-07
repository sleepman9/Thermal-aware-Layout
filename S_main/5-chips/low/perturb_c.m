function perturbed_components = perturb_c(components,PCB)
    indices = randperm(length(components), 2);
    temp_pos = components{indices(1)}.pos;
    components{indices(1)}.pos = components{indices(2)}.pos;
    components{indices(2)}.pos = temp_pos;
    perturbed_components = components;
    
        % ��ȡPCB�ĳߴ�
    pcbL = PCB{1}.pcbL;
    pcbW = PCB{1}.pcbW;
    
    for i = 1:length(perturbed_components)
        % ��ȡ����ĵ�ǰλ��
        x_i = perturbed_components{i}.pos(1);
        y_i = perturbed_components{i}.pos(2);

        % ȷ�������PCB��
        gap =5;
        x_i = max(x_i, 0); % ȷ��x���겻С�ڻ�׼
        y_i = max(y_i, 0); % ȷ��y���겻С�ڻ�׼
        x_i = min(x_i, pcbL - perturbed_components{i}.size(1)-gap); % ȷ��������ᳬ��PCB�ĳ���
        y_i = min(y_i, pcbW - perturbed_components{i}.size(2)-gap); % ȷ��������ᳬ��PCB�Ŀ��
        
        % ���������λ����Ϣ
        perturbed_components{i}.pos = [x_i, y_i];
    end
    

    
    if isAnyOverlap(perturbed_components)
%         perturbed_components = components; 
        fprintf("There has overlap������\n");
        perturbed_components = perturb_c(components,PCB);
    else
        fprintf("Successful perturbation without overlap.\n");
    end 
end



