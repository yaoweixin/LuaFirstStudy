Window = {}
Window.prototype = {x = 1,y = 0,height = 0,width = 0}
Window.mt = {}
function Window.new(o)
    setmetatable(o,Window.mt)
    return o
end

Window.mt.__index = function (table,key)
    return Window.prototype[key]
end

--When Lua detects that w does not have the requested field, but has a metatable with an __index field,
--Lua calls this __index metamethod, with arguments w (the table) and "width" (the absent key).
--The metamethod then indexes the prototype with the given key and returns the result.

w = Window.new({x =10,y = 20,height = 80})
print(w.width)

--还有另一个用法
Window.mt.__index = Window.prototype --会自动在index指向的表格寻找呀（如果在window里面的属性找不到呀）
-- it executes the equivalent of ：Window.prototype["width"]

--__index本质其实是元表的一个键，与他配套的自然就是一个值，那么当键指向表格的时候，我们就会在表格中寻找元素
--如果键指向函数，那我们就会执行这个函数，并且传进对应的参数
--一个表里面只能有一个元表，但是元表里面还可以嵌套另一个元表

--接着来看一个优化