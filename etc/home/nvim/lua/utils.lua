local utils = {}

-- check if a variable is not empty nor nil
utils.isNotEmpty = function(s)
    return s ~= nil and s ~= ""
end

return utils