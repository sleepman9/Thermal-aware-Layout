function max_T = update_temperature(components,PCB,step)
    updated_components = copy(components); % �������״�?
    num_components = length(components); % ��ȡ�������?

    % �ռ����������λ������?
    positions = cell(1, num_components * 2);
    for i = 1:num_components
        positions(2*i-1:2*i) = num2cell(components{i}.pos);
    end
    positions(num_components * 2+1) = num2cell(PCB{1}.pcbL);
    positions(num_components * 2+2) = num2cell(PCB{1}.pcbW);
    positions(num_components * 2+3) = num2cell(PCB{1}.pcbH);
    for i = 1:num_components
        positions((num_components * 2 +3)+3*i-2:(num_components * 2 +3)+3*i) = num2cell(components{i}.size);
    end
    positions(num_components*5+4) = num2cell(1);
    
    

    % ʹ��cell���������ձ䳤�����?
      [T1,T2,T3,T4,T5] =  CHIP5_20240606_SAtest(positions{:});
%       filename = sprintf('op-origin05151825.mph');
%       mphsave(filename);
      T = [T1,T2,T3,T4,T5]; 
      max_T = max(T);
    % ѭ����������ÿ��������¶�?
%     for i = 1:num_components
%         updated_components{i}.temp = T(i);
%     end
end



