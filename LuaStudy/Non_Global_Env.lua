--这一节呢，我们在讲述如何改变我们函数的环境，也就是函数可以调用的数据属于什么表
--因为我们原本的全局变量也是放在我们的全局环境表

--[[
    a = 1   -- create a global variable
    -- 把环境替换为一个空表，啥都没有
    setfenv(1, {})
    print(a)
]]

--You can change the environment of a function with the setfenv function (set function environment). It receives the function and the new environment.
--Instead of the function itself, you can also give a number, meaning the active function at that given stack level. Number 1 means the current function
--number 2 means the function calling the current function (which is handy to write auxiliary functions that change the environment of their caller), and so on.

--[[
    你可以用setfenv函数（设置函数环境）改变函数的环境。它接收函数和新环境。
    --除了函数本身，你还可以给一个数字，表示在给定堆栈级别上的活动函数。
    --数字1表示当前函数，数字2表示调用当前函数的函数（这对于编写更改其调用者环境的辅助函数非常方便），以此类推。
]]

--[[

--Once you change your environment, all global accesses will use this new table. If it is empty, you lost all your global variables, even _G. 
--So, you should first populate it with some useful values, such as the old environment:
    a = 1   -- create a global variable
    -- change current environment
    --注意如果是要改变全局的环境，注意要给新建的表格加入我们原本的全局环境表，避免整体环境出问题
    --动态语言即时编译
    setfenv(1, {_G = _G})
    _G.print(a)      --> nil
    _G.print(_G.a)   --> 1
]]

--[[
    a = 1
    local newgt = {}        -- create new environment
    --同时可以采用元表的方式，简化我们的访问
    setmetatable(newgt, {__index = _G})
    setfenv(1, newgt)    -- set it
    print(a)          --> 1
]]

--[[
    -- continuing previous code
    a = 10
    print(a)      --> 10
    print(_G.a)   --> 1
    _G.a = 20
    print(_G.a)   --> 20
]]