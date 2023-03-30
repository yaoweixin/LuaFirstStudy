--这是一个简单迭代器的实现
--迭代器本质其实就是一个闭包，用上了外部局部变量
function iter_list(t,num)
    local ind = 0;
    local n = num;
    return function ()
        ind = ind + 1;
        if ind <= n then
            return t[ind];
        end
    end
end

ExamTable = {12,32,122};

iter =  iter_list(ExamTable,3)

while true do
    local element = iter()
    if element == nil then break end
    print(element)
end
--这个是迭代器最合适的写法
for element in iter_list(ExamTable,3) do
    print(element)
end

---------------------------------------------------

--来个高级点的迭代器
function allWord()
    local line = io.read()
    local pos = 1
    return function ()
        while line do
            local s,e = string.find(line,"%w+",pos)
            if s then
               pos = e + 1
               return string.sub(line,s,e)
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
    
end

for word in allWord() do
    print(word)
end  

--for 结构的第一步是求解 in 后面的表达式。这些表达式应该返回 for 所需的三个值：迭代器函数、不变状态和控制变量的初始值
--我们在上述的for循环中使用的是自己定义的迭代器，本质上来说其实我们的迭代器都是返回三个值，在上个函数中，不变状态相当于line，pos其实就相当于控制变量，仅仅用于初始化的时候获得这个值
--然后我们执行迭代器函数，执行迭代器函函数其实就是传入我们的不变状态，和控制变量初始化的值

--[[
    for <var-list> in <exp-list> do
      <body>
    end
]]

--执行过程等价于
--for var_1, ..., var_n in explist do block end
--[[
    do
      local _f, _s, _var = explist
      while true do
        local var_1, ... , var_n = _f(_s, _var)
        _var = var_1
        if _var == nil then break end
        block
      end
    end
]]


--------------------------------------------------------------


--接着我们来说说无状态迭代器（不会产生新的闭包）

a = {111,222,333}

for index, value in ipairs(t) do
    print(index,value)
end

--接着来看看ipairs的底层实现

function iter(aa,i)
    i = i + 1
    local v = aa[i]
    if v then
        return i,v
    end
end
--当我们调用ipairs的时候，会返回三个值，迭代器函数、不变状态和控制变量的初始值
--在这里面分别就是iter,tt(table),0
--接着开始调用iter（tt,0）,返回1，tt[1]，直到返回num,nil结束
function ipairs(tt)
    return iter,tt,0
end

--pairs同理

function pairs(tt)
    return next,tt,0
end

--同时也可以这样调用
for key, value in pairs(t) do
    print(value)
end

----------------------------------------------------------------
--Frequently, an iterator needs to keep more state than fits into a single invariant state and a control variable. 
--The simplest solution is to use closures. An alternative solution is to pack all it needs into a table and use this table as the invariant state for the iteration. 
--Iterator with complex state
local iterator   -- to be defined later
    
function allwords ()
  local state = {line = io.read(), pos = 1}
  return iterator, state
end

function iterator (state)
    while state.line do        -- repeat while there are lines
      -- search for next word
      local s, e = string.find(state.line, "%w+", state.pos)
      if s then                -- found a word?
        -- update next position (after this word)
        state.pos = e + 1
        return string.sub(state.line, s, e)
      else    -- word not found
        state.line = io.read() -- try next line...
        state.pos = 1          -- ... from first position
      end
    end
    return nil                 -- no more lines: end loop
  end

for word in allwords() do
    print(word)
end

--如果有特殊的需求需要使用迭代器，最好还是使用闭包，因为：
--First, it is cheaper to create a closure than a table; second, access to upvalues is faster than access to table fields.

---------------------------------------------------------------------------