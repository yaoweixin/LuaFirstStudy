
--先定义一个局部表格，来存储我们的已经声明过得全局变量名称
local declareNames = {}

--我们只能通过这个方法来创建全局环境表里的键值对
--rawset可以绕过__index和__newindex，直接调用，这样就可以创建新的键值对
function declare(name,initval)
    rawset(_G,name,initval)
    declareNames[name] = true
end

--给全局环境表设置一个元表，避免我们访问未定义的数据，以及初始化未定义的数据
setmetatable(_G,{
    --当我们访问表中不存在的键的时候，就会报错
    __index = function (_,n)
        if not declareNames[n] then
            error("attempt to read undeclared var. ",2)
        else
            return nil
        end
    end,
    __newindex = function (t,n,v)
        if not declareNames[n] then
            error("attempt to write to undeclared var",2)
        else
            rawset(t,n,v)
        end
    end
})

------------------------------
--可以用rawget来判断我们表里是不是有这个值，同样也可以跳过__index和__newindex
if rawget(_G, var) == nil then
      -- `var' is undeclared
end