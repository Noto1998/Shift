local const = {}
local _const = {}
function newIndex(t, k, v)
    if not _const[k] then
        _const[k] = v
    else
        error("try to def const." .. k)
    end
end
local mt = {
    __newindex = newIndex,
    __index = _const
}
setmetatable(const, mt)

return const