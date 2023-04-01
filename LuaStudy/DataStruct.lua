a = {}
for i = -5,5 do
    a[i] = i
end
print(a[-2])

--[[
    a = {}    -- new array
    for i=1, 1000 do
      a[i] = 0
    end
]]

--------------------------------------------
--接下来介绍一下矩阵的实现
mt = {}
for i = 1,10 do
    mt[i] = {}
    for j = 1,7 do
        mt[i][j] = j
    end
end

-----一维矩阵
mmtt = {}

for i = 1,10 do
    mmtt[i] = {}
    for j = 1,7 do
        mmtt[(i - 1) * 10 + j] = j
    end
end

--------------------------------------------

----实现一下链表
list = nil
list = {next = list,value = v}

--[[
    1.local head = list
    2.local node = list
    3.node.v = 1
    4.node.next = head
    5.head = next
    重复2-4步
]]


local l = list
while l do
    print(l.value)
    l = l.next
end

--------------------------------------------
--让我们来实现一个双向队列捏
List = {}
function List.new ()
  return {first = 0, last = -1}
end

function List.pushleft (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function List.pushright (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function List.popleft (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil        -- to allow garbage collection
    list.first = first + 1
    return value
end

function List.popright (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil         -- to allow garbage collection
    list.last = last - 1
    return value
end

------------------------------------------------------
--让我们实现一个集合
--讲下lua当中set的定义
--In Lua, an efficient and simple way to represent such sets is to put the set elements as indices in a table. 
--Then, instead of searching the table for a given element, you just index the table and test whether the result is nil or not. 
reserved = {
    ["while"] = true,     ["end"] = true,
    ["function"] = true,  ["local"] = true,
}

function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

reserved = Set{"while", "end", "function", "local", }
