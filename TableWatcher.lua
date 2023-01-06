local function SpyOnTable(t)
    -- Create a proxy table to watch the original table
    local proxy = {}

    local mt = {
    __index = t,

    __newindex = function(t, k, v)
        print(string.format("Setting t[%s] to %s", tostring(k), tostring(v)))
        rawset(t, k, v)
    end
    }

    -- Set the metatable to the proxy table
    setmetatable(proxy, mt)
    return proxy
end

local TableToWatch = {}
TableToWatch = SpyOnTable(watched_table)

TableToWatch.x = 10
TableToWatch.y = 20
TableToWatch.z = 30

-- Should have logged all of these changes