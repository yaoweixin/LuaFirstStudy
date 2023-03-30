names = {"Peter","marry","Apple"}
grades = {marry = 10,Apple = 5,Peter = 4}

--使用闭包函数进行排序
table.sort(names,function (n1,n2)
    return grades[n1] < grades[n2]  
end)

for index, value in ipairs(names) do
    print(index .. value)
end


print("-------------------------------------------------------\n")

--有一句话很有道理，我们每一个值本质上其实就是一个闭包，函数其实就是闭包的原型

function enCounter()
    local i = 0
    return function ()
        i = i + 1
        return i
    end
end

--所以c1其实是一个闭包，然后我们会给我们的局部变量进行赋值
--我们会由内向外寻找i的定义，找到了定义再为其进行赋值，所以访问local变量会比访问全局速度更快
c1 = enCounter()
c2 = enCounter()

print(c1())
print(c1())
print(c2())

--如果是全局变量呢

function GloEnCounter()
    i = 0
    return function ()
        i = i + 1
        return i
    end
end
--因为我们没有给i定义，只有给i赋值，所以当我们的程序去由内向外寻找i的时候并没有找到，于是便在外部接着找，最后在外部分配了一块内存，所以他相当于是全局变量
a1 = GloEnCounter()
a2 = GloEnCounter()
print(a1())
print(a1())
print(a2())
print(i)

------------------------------------------------

--这段代码的意思其实就是想告诉我们，这个方法返回的其实也是一个闭包，为什么呢，It is actually a closure, because it accesses the upvalue digit.
--这就是闭包的含义，字面意思，digit相当于是一个局部变量，我们可以用我们的action去访问这个局部变量，又叫做，外部局部变量，等价于在函数里加个local digit
function digitButton (digit)
    return Button{ label = digit,
                   action = function ()
                              add_to_display(digit)
                            end
                 }
  end

------------------------------------------------------------------

--这个并未使用闭包概念，oldSin可以被全局访问，这不是我们想要的初衷，我们希望这个oldSin只属于我们每一个定义的Sin，
--[[oldSin = math.sin;
math.sin = function (x)
    return oldSin(x * math.pi /180)
end

print(math.sin(30))
print(oldSin(30))
]]

--所以就有了如下方法
--本质上是为了防止原本的代码被错误访问以及修改  
--Now, we keep the old version in a private variable; the only way to access it is through the new version.
do
    local OldSin = math.sin;
    local k = math.pi / 180;
    math.sin = function (x)
        return OldSin(x * k);
    end

    print(math.sin(30));
end

print(math.sin(30))

--Instead of a one-size-fits-all solution, Lua offers you a meta-mechanism, so that you can tailor your environment for your specific security needs.
do
    local oldOpen = io.open
    io.open = function (filename,mode)
        if access_OK(filename,mode) then
            return oldOpen(filename,mode)
        else
            return nil,"Access denied"
        end
    end

end
