Utils = {}

function Utils.dump(o, depth)
    if type(o) ~= 'table' then return tostring(o) end
    depth = depth or 0
    local indent = string.rep('  ', depth)
    local s = '{\n'
    for k,v in pairs(o) do
        s = s .. indent .. '  [' .. tostring(k) .. '] = ' .. Utils.dump(v, depth + 1) .. ',\n'
    end
    return s .. indent .. '}'
end

return Utils
