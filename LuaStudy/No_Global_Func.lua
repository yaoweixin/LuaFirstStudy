funcc1 = {}
funcc1.f1 = function ()
    print("I am Func1")
end
funcc1.f2 = function ()
    print("I am Func2")
end

--------------------------------------------------------
funcc2 = {
    f1 = function ()
        print("I am Func1")
    end,
    f2 = function ()
        print("I am Func2")
    end
}
--------------------------------------------------------
funcc3 = {}
function funcc3.f1()
    print("I am Func1")
end
function funcc3.f2()
    print("I am Func2")
end

--This last fragment is exactly equivalent to the first example

--------------------------------------------------------------------

--we can use local Func in local Func
--Lexical scoping ensures that other functions in the package can use these local functions:
local function f()
    print("I am Func F")
end

local function G()
    f() -- external local `f' is visible here
    print("Look! I can use Func F!")
end

-----------------------------------------------------------------------
local f = function (n)
    if n == 0 then return 1
    else return n * f(n - 1) --这个会报错，因为当我们编译f(n - 1)的时候，我们的f并未定义完全，也就是还没定义，所以我们会去全局范围寻找f函数，那找不到，就会报错
    end
end

--To solve that problem, we must first define the local variable and then define the function:
local fact
fact = function (n)
    if n == 0 then return 1
    else return n * fact(n - 1)
    end
end
--Now the fact inside the function refers to the local variable. Its value when the function is defined does not matter
local function faact (n)
    if n == 0 then return 1
    else return n*faact(n-1)
    end
end

----------------------------------------------------------------------

local gg,ff

function gg()
    ff()
end

function ff()
    gg()
end


