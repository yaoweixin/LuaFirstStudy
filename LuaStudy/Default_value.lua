function setDefault(t,d)
    local mt = {__index = function () return d end}
    setmetatable(t,mt)
end

tab = {x = 10,y = 10}
print(tab.x,tab.z)
setDefault(tab,2)
print(tab.x,tab.z)
--Now, whenever we access an absent field in tab, its __index metamethod is called and returns zero, which is the value of d for that metamethod.
print(tab.a,tab.b)
--注意，我们只是输出默认值，不代表我们元表里面有这个键啦

----------------------------------------------------------
--这样子我们就不会每次设置默认值的时候，都给我们的表格添加一个新的元表，用一个统一的元表管理默认值
local mt2 = {__index = function (t) return t.__ end}
function setDefault2(t,d)
    t.__ = d
    setmetatable(t,mt)    
end