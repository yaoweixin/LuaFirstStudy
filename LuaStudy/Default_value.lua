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
    setmetatable(t,mt2)    
end

tab2 = {x = 10,y = 10}
tab3 = {x = 12,y = 13}
--这样我们每次在寻找不存在的值的时候，我们会去查找元表有没有__index方法，
--发现__index方法对应的是一个函数，我们会去调用这个函数，并且产生返回值
--我们使用setfault2的目的是，让我们每个表格调用这个方法后，表格自身都会加上__属性
--然后用一个统一的元表，当我们访问不存在的键的时候，就返回我们的"__"值
print(tab2.x,tab2.z)
setDefault2(tab2,23)
setDefault2(tab3,12)
print(tab2.x,tab2.z)
print(tab3.x,tab3.z)

--------------------------------------------------------------------
--接着来看看解决默认值的键相同的问题(和我们自身table里面的键名称相同)

local key = {}
local mt3 = {__index = function (t) return t[key] end}

function setDefault3(t,d)
    t[key] = d
    setmetatable(t,mt3)
end
--我们默认值的key不应该和我们表格里面的其他元素起冲突，所以就使用了table作为key，独一无二

tabb2 = {x = 10,y = 10}
tabb3 = {x = 12,y = 13}
print(tabb2.x,tabb2.z)
setDefault3(tabb2,23)
setDefault3(tabb3,12)
print(tabb2.x,tabb2.z)
print(tabb3.x,tabb3.z)
