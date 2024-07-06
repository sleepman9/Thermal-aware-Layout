function cur_pos = perturb(num_particles,w,vel,c1,c2,best_pos,p_best_pos,cur_pos,components)
        r1 = rand(num_particles, 2)-0.5;
        r2 = rand(num_particles, 2)-0.5;
%         r_star1 = rand(num_particles, 1);
%         r_star2 = rand(num_particles, 1);

        pcbL = 215;
        pcbW = 155;
        

%         vel = w * vel + c1 * r1 .* (best_pos - cur_pos) + c2 * r2 .* (best_pos - cur_pos) ...
%             + c_star1 * r_star1 .* (best_pos - cur_pos) + c_star2 * r_star2 .* (best_pos - cur_pos);
%         vel = w * vel + c1 * r1 .* (best_pos - cur_pos);
        vel = w * vel + c1 * r1 .* (p_best_pos - cur_pos) + c2 * r2 .* (best_pos - cur_pos);

        % Clamping constant
%         for i = 1:num_particles
%             vel(i,1) = min(vel(i,1) , Vmax_x);
%             vel(i,1) = max(vel(i,1) , -Vmax_x);
%             vel(i,2) = min(vel(i,2) , Vmax_y);
%             vel(i,2) = max(vel(i,2) , -Vmax_y);
% 
% %             vel(vel(i,1) > Vmax_x, 1) = Vmax_x;
% %             vel(vel(i,1) < -Vmax_x, 1) = -Vmax_x;
% %             vel(vel(i,2) > Vmax_y, 2) = Vmax_y;
% %             vel(vel(i,2) < -Vmax_y, 2) = -Vmax_y;
%         end


        cur_pos = cur_pos + vel;
        
        for i = 1:num_particles
            gap =5;
            
            cur_pos(i,1) = max(cur_pos(i,1), 0); % 确保x坐标不小于基准
            cur_pos(i,2) = max(cur_pos(i,2), 0); % 确保y坐标不小于基准
            cur_pos(i,1) = min(cur_pos(i,1), pcbL - components{i}.size(1)-gap); % 确保组件不会超出PCB的长度
            cur_pos(i,2) = min(cur_pos(i,2), pcbW - components{i}.size(2)-gap); % 确保组件不会超出PCB的宽度
        end

        for i = 1:num_particles
            components{i}.pos = cur_pos(i,:);
        end
    
        if isAnyOverlap(components)
        fprintf("There has overlap！！！\n"); 
        
        cur_pos = perturb(num_particles,w,vel,c1,c2,best_pos,p_best_pos,cur_pos,components);
%         cur_pos = perturb(num_particles,w,vel,c1,best_pos,cur_pos,c2,c_star1,c_star2,Vmax_x,Vmax_y,components);

        end
end

