% �Ŷ�����
%��ͬ���ʵ��Ŷ���ʽ
function perturbed_components = perturb_f(components,PCB)
    perturbed_components = copy(components); 

    % ��ȡPCB�ĳߴ�
    pcbL = PCB{1}.pcbL;
    pcbW = PCB{1}.pcbW;

    for i = 1:length(perturbed_components)
%     i = randi(length(perturbed_components));
    % ��ȡ����ĵ�ǰλ��
    x_i0 = perturbed_components{i}.pos(1);
    y_i0 = perturbed_components{i}.pos(2);

    % �����������
    R_x = (rand() - 0.5);
    R_y = (rand() - 0.5);

    % ����DL��DWΪ���Ա߳�1������������Ӧ����ƶ��ķ���
    DL = 1 * perturbed_components{i}.size(1);
    DW = 1 * perturbed_components{i}.size(2);

    % �����µ�λ��
    x_i = x_i0 + R_x * DL;
    y_i = y_i0 + R_y * DW;

    % ȷ�������PCB��
    gap =5;
    x_i = max(x_i, 0); % ȷ��x���겻С�ڻ�׼
    y_i = max(y_i, 0); % ȷ��y���겻С�ڻ�׼
    x_i = min(x_i, pcbL - perturbed_components{i}.size(1)-gap); % ȷ��������ᳬ��PCB�ĳ���
    y_i = min(y_i, pcbW - perturbed_components{i}.size(2)-gap); % ȷ��������ᳬ��PCB�Ŀ��

    % ���������λ����Ϣ
    perturbed_components{i}.pos = [x_i, y_i];
    end

    % �����λ���Ƿ����ص�
    if isAnyOverlap(perturbed_components)
%         perturbed_components = components; 
        fprintf("There has overlap������\n");
        perturbed_components = perturb_f(components,PCB);
    else
        fprintf("Successful perturbation without overlap.\n");
    end
    
end


