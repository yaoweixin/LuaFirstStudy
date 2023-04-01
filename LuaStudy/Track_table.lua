t = {}

local _t = t

t = {}

local mt = {
    __index = function (t,k)
        print("access to element " .. tostring(k))
        return _t[k]
    end,

    __newindex = function (t,k,v)
        print("Update the element" .. tostring(k) .. " to " .. tostring(v))
        _t[k] = v
    end
}
--我们的意义在于，__index 和 __newindex 只在索引不存在于表中时才起作用。要捕获表中所有访问的唯一方法是将其保持为空
--所以要创建一个空表，来观测（查看）我们对表格元素操作

setmetatable(t,mt)

t[2] = 'hello'

print(t[2])
---------------------------------------------------------------
--当我们需要给多个表创建代理的时候，我们不需要定义多个元表，我们只需要在一个元表里面使其可以访问多个原始表格就好了

local index = {}

local mt = {
    __index = function (t,k)
        print("access the element ".. tostring(k))
        return t[index][k]
    end,

    __newindex = function (t,k,v)
        print("Update the element " .. tostring(k) .. " to " .. tostring(v))
        t[index][k] = v
    end
}

function track(t)
    local proxy = {}
    proxy[index] = t
    setmetatable(proxy,mt)
    return proxy
end

--使用方法
t = track(t)