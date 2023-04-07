--[[
local Shape = class("Shape")

function Shape:ctor()
end

function Shape:size()
    return 0
end

local Rect = class("Rect", Shape)

function Rect:ctor(w,h)
    Shape.ctor(self)    
    self.w = w
    self.h = h
end

function Rect:size()
    return self.w * self.h
end

local Square = class("Square",Rect)

function Square:ctor(s)
    Rect.ctor(self,s,s)
end

function test()
    local s = Shape.new()
    local r = Rect.new(5,8)
    local Squ = Square.new(3)
    print(s:size())
    print(r:size())
    print(Squ:size())
end


]]
--这个是单继承
function class(className, baseClass)
    --这里是实现了我们class中的面相对象，下面的new是用来返回对象
    local cls = {}
    --我们把我们的元表定义为我们自己
    cls.__index = cls
    cls.__name = className

    if baseClass then
        --如果有父类，就把元表定义为父类
        setmetatable(cls, { __index = baseClass })
    end

    function cls.new(...)
        --setmetatable返回了我们设置元表的对象，在这里我们就是返回了一个空表，这个空表的元表格是我们的父类
        local instance = setmetatable({}, {__index = cls}) 
        
        if instance.ctor then
            instance:ctor(...)
        end
        return instance
    end

    return cls
end
--[[
上述代码中，class函数接受两个参数：className和baseClass。className表示创建的类的名称，baseClass表示该类的父类（可选）。

该函数首先创建一个空表作为新的类，并设置元表为自身。接着，为该类设置一个名为__name的属性，其值为className。

如果baseClass参数存在，则使用metatable操作将新类的__index属性设置为父类的表。这意味着，当新类在自身表中找不到某个方法时，会在父类表中继续查找该方法。

然后，该函数定义了一个名为new的方法，用于创建该类的实例。该方法使用setmetatable函数将一个空表作为新实例，并将元表设置为该类本身。如果该类有一个名为ctor的构造函数，则调用该函数初始化实例。最后，返回创建的实例。
]]
