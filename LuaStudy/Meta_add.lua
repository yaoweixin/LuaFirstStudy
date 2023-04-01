--今天我们来介绍一下元表当中的元方法是如何使用的

Set = {}
Set.mt = {}

--首先定义一个集合的构造函数，为所有对象设置一个统一的元表，可以理解为我们给整个对象设置了一个统一的虚函数表
function Set.new(t)
    local set = {}
    setmetatable(set,Set.mt)
    for index, value in ipairs(t) do
        set[value] = true;
    end
    return set
end

--为什么我们要把值存储在key中呢，因为这样有利于我们判重
--这个是并集
function Set.union(a,b)
    if getmetatable(a) ~= Set.mt or getmetatable(b) ~= Set.mt then
        error("Not All Arguments Has Correct MetaMethod!",2)
    end
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = true
    end
    for k in pairs(b) do
        res[k] = true
    end
    return res
end
--这个是交集
function Set.intersection(a,b)
    local res = Set.new{}
    for key in pairs(a) do
        res[key] = b[key]
    end
    return res
end
--来定义一个输出函数
function Set.tostring(set)
    local s = "{"
    local seq = ""
    for key in pairs(set) do
        s = s .. seq .. key
        seq = ","
    end
    s = s .."}"
    return s
end

function Set.print(set)
    print(Set.tostring(set))
end

--做好准备工作，开始将元方法赋值
--先看看每个集合的元表是否相同
s1 = Set.new({1,2,3,4})
s2 = Set.new({2,5})

print(getmetatable(s1))
print(getmetatable(s2))

--开始赋值
Set.mt.__add = Set.union --Whenever Lua tries to add two sets, it will call this function, with the two operands as arguments.
s3 = s1 + s2
Set.print(s3)

Set.mt.__mul = Set.intersection

Set.print(s1 * s2)
--For each arithmetic operator there is a corresponding field name in a metatable. Besides __add and __mul, 
--there are __sub (for subtraction), __div (for division), __unm (for negation), and __pow (for exponentiation).
--We may define also the field __concat, to define a behavior for the concatenation operator.

--在我们的元方法中，只要有一个参数里面含有对应的元方法，我们就会执行，但是并不能保证另外一个参数也有元方法，所以很容易造成错误
s = Set.new{1,2,3}
--这样会导致我们运行的时候当我们的方法调用不含元方法的参数的时候会报错
--s = s + 8

--这个时候我们可以对元方法进行一个使用error的优化

--as Lua translates a ~= b to not (a == b), a > b to b < a, and a >= b to b <= a.

--接着我们来讲讲比较运算符的重载

Set.mt.__le = function (a,b)
    for k in pairs(a) do
        if not b[k] then
            return false
        end
    end
    return true
end

Set.mt.__lt = function (a,b)
    return a <= b and not (b <= a)
end

Set.mt.__eq = function (a,b)
    return a <= b and b <= a
end
--Unlike arithmetic metamethods, relational metamethods do not support mixed types.   
--If you try to compare a string with a number for order, Lua raises an error. 
--Similarly, if you try to compare two objects with different metamethods for order, Lua raises an error. 
--An equality comparison never raises an error, but if two objects have different metamethods, the equality operation results in false, 
s3 = Set.new{1,3,5}
s4 = Set.new{1,4,3,5}
print(s3 <= s4)
print(s3 > s4)
print(s3 < s4)
print((s3 * s4) == s3)



--只有当两个对象共享相同的元方法时，才会调用相应的元方法（这样才不会报错）


--接着我们来说说lua的库函数元方法
--当我们调用库函数的时候，比如调用print的时候，我们其实会默认调用tostring的方法
--接着tostring方法，会先检查对象是否有元表，元表里面是否有__tostring字段，有的话就会调用对应的方法，并且将对象作为参数传递
Set.mt.__tostring = Set.tostring

print(s2)

--比如我们想让我们的元表是被保护的，无法被外界访问，可以给我们的元表添加__metatable字段
--这样我们调用getmetatable的方法时，就会自动返回__metatable字段
Set.mt.__metatable = "Gun gun gun"

print(getmetatable(s2))
--这个会报错，“你不能改变一个被保护的元表”
setmetatable(s2,{})


