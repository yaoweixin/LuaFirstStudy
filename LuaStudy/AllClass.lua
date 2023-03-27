Shape = {area = 0}

function Shape:new(o,side)
    o = o or {}
    setmetatable(o,self);
    self.__index = self;
    --self.__newindex = self;
    side = side or 0
    self.area = side * side
    return o
end

function Shape:returnArea()
    print("The Area Is  " .. self.area)
end

myshape = Shape:new(nil,10)
myshape:returnArea()

Square = Shape:new()    

function Square:new(o,side)
    o = o or Shape:new(o,side)
    --这里有个语法，冒号：会把对象作为隐藏参数传入，也就是我们函数的第一个参数，就类似于我们里面的self，这里面的self就相当于我们的shape对象
    --所以我们把我们o，也就是square对象的元表设置成self，也就是shape对象，当我们去查找的时候，如果在square对象里面找不到的话，就要在他的元表：shape里面找
    --所以可以使用父类的对象
    setmetatable(o,self)
    self.__index = self
    return o
end

function Square:returnArea()
    print("The area of square is " .. self.area)
end

--在调用我们的square方法的时候我们就把我们的square对象，也就是shape对象传进去
mysquare = Square:new(nil,100)
mysquare:returnArea()

Rectangle = myshape:new()

function Rectangle:new(o,length,width)
    o = o or Shape:new(o)
    setmetatable(o,self)
    self.__index = self
    self.area = length * width
    return o
end

function Rectangle:returnArea()
    print("The area of Rectangle is " .. self.area)
end

myRectangle = Rectangle:new(nil,19,39)
myRectangle:returnArea()








