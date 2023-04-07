package.path = "C:\\Users\\Admin\\Desktop\\LuaFirstStudy\\LuaStudy\\Lua_Class\\?.lua"

require("Class_create")

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

test()