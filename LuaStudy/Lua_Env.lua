--在 Lua 中，每个函数都有一个环境表（也叫做上值或者_upvalue_），这个环境表决定了函数中可以访问的变量和函数。
--例如，下面的代码会在全局环境中定义一个变量 x，并在一个新的函数中访问它：
x = 10

function f()
  print(x)
end

f() -- 输出 10
--------------------------------------------------------------------------
--这是lua5.1之后的版本给函数设置环境的方式，env就是环境
local env = {}
setmetatable(env, {__index = _G, __newindex = function(t, k, v) print("forbidden global var ", k) end})
local fp = loadfile(path, nil, env)

------------------------------------------------------------------------