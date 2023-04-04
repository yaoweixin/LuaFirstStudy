--注意一点，我们的全局环境表是所有lua文件共享的，也就是说我们在本文件运行了其他文件的代码的时候，里面的全局变量也会放到我们的全局变量表当中，所以我们可以调用
--如果声明的是局部变量则不会有这样的烦恼

module1 = {}

module1.constant = 1

function module1.func1()
    print("Print constant: " .. tostring(module1.constant))
end

local function func2()
    print("This is a private funx")
end

function module1.func3()
    func2()
end
---------------------------------------------------

--module2

--局部变量在这里的作用就是，可以不被其他的文件调用
local function checkComplex(c)
    if not (type(c) == "table") and tonumber(c.r) and tonumber(c.i) then
        error("bad complex number", 3)
    end
end

local function new(r,i)
    return{r = r,i = i}
end

local function add(c1,c2)
    checkComplex(c1)
    checkComplex(c2)
    return new(c1.r + c2.r,c1.i + c2.i)
end

local function sub(c1,c2)
    checkComplex(c1)
    checkComplex(c2)
    return new(c1.r - c2.r,c1.i - c2.i)
end

private_complex = {
    new = new,
    add = add,
    sub = sub
}

return private_complex


