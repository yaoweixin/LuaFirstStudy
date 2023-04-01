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
--让我们来实现一个队列
List = {}
function List.new ()
  return {first = 0, last = -1}
end
