% ¸´ÖÆº¯Êý
function copied_components = copy(components)
    copied_components = cell(size(components));
    for i = 1:length(components)
        copied_components{i} = components{i};
    end
end