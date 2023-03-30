-- Lua interpreter, take advantage of this fact and actually do not use any extra stack space when doing a tail call

function g(x,...)
    print("ssss" .. tostring(x));
end

function f(x)
    return g(x);
end
--This is call Tail Call


function foo(n)
    if n > 0 then return foo(n - 1) end
end

--This is not tail call
--after calling g, f still has to discard occasional results from g before returning
function fff()
    g(1)
    return
end

--[[
    Similarly, all the following calls fail the criteria:
    return g(x) + 1     -- must do the addition
    return x or g(x)    -- must adjust to 1 result
    return (g(x))       -- must adjust to 1 result
]]

--In Lua, only a call in the format return g(...) is a tail call.

function tailCall(n)
    return g(n,n + 1)

end
--简单来说其实就是，我们要返回的是这个函数，而不是这个函数的值，不能把g(x)当做一个表达式，或者放进表达式当中，这样就会失去尾调用的意义
--a tail call is a kind of goto


