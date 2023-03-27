--[[metaTable = {}

--解释一下，我们首先先给，也就是mytable添加了一个键key1
--接着我们在元表里，让__newIndex指向我们的元表

mytable = setmetatable({key1 = "aaaa"},{})

mytable.newkey = "bbbbb"


--没有设置newIndex
print(mytable.newkey,metaTable.newkey)
--输出结果为bbbbb   nuil
--当我们并没有使用我们的__newindex的时候，这个key还是会放在我们的表当中，但不是防在元表
print(mytable.key1,metaTable.key1)
--输出结果为aaaa    nil
--这就说明了如果是在我们初始话定义的值里面(已经定义好了的值)，会自动赋值而不是调用元方法

--我们在这边定义一个类
]]

--[[metaTable = {}

--解释一下，我们首先先给，也就是mytable添加了一个键key1
--接着我们在元表里，让__newIndex指向我们的元表

mytable = setmetatable({key1 = "aaaa"},{__newindex = metaTable})

mytable.newkey = "bbbbb"


--因为已经设置了newIndex
print(mytable.newkey,metaTable.newkey)
--输出结果为nil   bbbbb
--这说明其实我们如果并未声明这个key的话，这个key会存储在元表当中
print(mytable.key1,metaTable.key1)
--输出结果为aaaa    nil
--这就说明了如果是在我们初始话定义的值里面(已经定义好了的值)，会自动赋值而不是调用元方法

--我们在这边定义一个类
]]


Teacher = {} 

function Teacher:new(o,id,subjecT,name)
    o = o or {}
    --[[
    __newindex字段指向一个函数的时候，则给表创建一个新字段的时候，则会执行该函数，且对本表创建不成功
    setmetatable(o,{__newindex = function (o,key,value)
        rawset(o,key,value);        
    end})
    ]]
    --[[
    __newindex字段指向一个表格的时候，那么如果创建一个新字段的时候，会对该表创建这个字段，并且对本表格创建不成功
    setmetatable(o,{__newindex = self})
    ]]
    --[[
        当我们单纯使用__newindex的时候，其实是无法使用getmetatable这个方法的，所以无法访问到我们的元表
    ]]
    --self = {}
    --self是作为隐藏参数传入，也就是，把我们的teacher对象作为隐藏参数传入
    setmetatable(o,self)
    --因为我们一开始定义了元表self，所以我们的赋值操作是有效的，但是我们并没有定义__index导致我们用对象去访问的时候无法访问到元表的值
    self.__newindex = self;
    self.__index = self;
    o.id = id or 0
    o.subjecT = subjecT or ""
    o.name = name or ""
    return o
end

Teacher_a = Teacher:new(nil,2,"English","YaoTeacher")
Teacher_b = Teacher:new(nil,1,"Chinese","YaoTTeacher")

print(getmetatable(Teacher_b).name)
print(getmetatable(Teacher_a).name)

print(Teacher_a.id,Teacher_a.name,Teacher_a.subjecT)
print(Teacher_b.id,Teacher_b.name,Teacher_b.subjecT)
