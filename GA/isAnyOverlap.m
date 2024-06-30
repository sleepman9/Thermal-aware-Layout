% 所有组件是否重叠
function overlap = isAnyOverlap(components)
    overlap = false;
    for i = 1:length(components)
        for j = i+1:length(components)
            if isOverlapping(components{i}.pos, components{i}.size(1), components{i}.size(2), ...
                             components{j}.pos, components{j}.size(1), components{j}.size(2))
                overlap = true;
                return;
            end
        end
    end
end