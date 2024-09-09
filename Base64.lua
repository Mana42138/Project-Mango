local Module = {}
local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function Module:encode(input)
    local result = {}
    local pad = 2 - ((#input - 1) % 3)
    input = input .. string.rep('\0', pad)
    
    for i = 1, #input, 3 do
        local n = (string.byte(input, i) << 16) + (string.byte(input, i + 1) << 8) + string.byte(input, i + 2)
        table.insert(result, string.sub(b64chars, (n >> 18) + 1, (n >> 18) + 1))
        table.insert(result, string.sub(b64chars, ((n >> 12) & 0x3F) + 1, ((n >> 12) & 0x3F) + 1))
        table.insert(result, string.sub(b64chars, ((n >> 6) & 0x3F) + 1, ((n >> 6) & 0x3F) + 1))
        table.insert(result, string.sub(b64chars, (n & 0x3F) + 1, (n & 0x3F) + 1))
    end
    
    for i = 1, pad do
        result[#result - i + 1] = '='
    end
    
    return table.concat(result)
end

function Module:decode(input)
    input = input:gsub('=', ''):gsub('[^'..b64chars..']', '')
    local result = {}
    
    for i = 1, #input, 4 do
        local n = (string.find(b64chars, string.sub(input, i, i)) - 1) << 18
            + (string.find(b64chars, string.sub(input, i + 1, i + 1)) - 1) << 12
            + (string.find(b64chars, string.sub(input, i + 2, i + 2)) - 1) << 6
            + (string.find(b64chars, string.sub(input, i + 3, i + 3)) - 1)
        
        table.insert(result, string.char((n >> 16) & 0xFF))
        table.insert(result, string.char((n >> 8) & 0xFF))
        table.insert(result, string.char(n & 0xFF))
    end
    
    return table.concat(result):gsub('%z+$', '')
end

return Module
