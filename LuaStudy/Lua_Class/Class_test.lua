package.path = "C:\\Users\\Admin\\Desktop\\LuaFirstStudy\\LuaStudy\\Lua_Class\\?.lua"

require("Class_create")

--基类的实现
local Animal = class("Animal")

function Animal:ctor()    
end

function Animal:AMI()    
end

--继承类的实现
local Dog = class("Dog",Animal)

function Dog:ctor(weight,height)
    self.weight = weight
    self.height = height
end

function Dog:AMI()
    return self.weight / self.height
end



--形状基类
local Shape = class("Shape")

function Shape:ctor()
end

function Shape:size()
    return 0
end

--矩形类，继承自形状类
local Rect = class("Rect", Shape)

function Rect:ctor(w,h)
    Shape.ctor(self)    
    self.w = w
    self.h = h
end

function Rect:size()
    return self.w * self.h
end

--圆形类，继承自形状类
local Circle = class("Circle",Shape)

function Circle:ctor(r)
    Shape.ctor(self)
    self.r = r
end

function Circle:size()
    return 3.14 * self.r ^ 2
end


--正方形类，继承于矩形类
local Square = class("Square",Rect)

function Square:ctor(s)
    Rect.ctor(self,s,s)
end

--多继承实现
local Dog_Square = class("Dog_Square",Dog,Square)

function Dog_Square:ctor(weight,height,w)
    Dog.ctor(self,weight,height)
    Square.ctor(self,w)
end

local Dog_Rect = class("Dog_Rect",Dog,Rect)

function Dog_Rect:ctor(weight,height,w)
    Dog.ctor(self,weight,height)
    Rect.ctor(self,w)
end


function test()
    --这三个都是单继承，其中square体现了继承
    local s = Shape.new()
    local r = Rect.new(5,8)
    local Squ = Square.new(3)
    print(s:size())
    print(r:size())
    print(Squ:size())

    --这两个是多继承
    local ds = Dog_Square.new(12,13,4)
    local dr = Dog_Rect.new()
    --但是我们要在构造函数手动赋值，挺麻烦的
    print(ds:size() .. " " .. ds:AMI())
    print(dr:size() .. " " .. dr:AMI())
end

test()