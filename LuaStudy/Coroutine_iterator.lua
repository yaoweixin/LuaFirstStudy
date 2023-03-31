--原本我们实现全排列函数是这样的
function permgen (a, n)
    if n == 0 then
      printResult(a)
    else
        for i=1,n do
  
        -- put i-th element as the last one
        a[n], a[i] = a[i], a[n]
  
        -- generate all permutations of the other elements
        permgen(a, n - 1)
  
        -- restore i-th element
        a[n], a[i] = a[i], a[n]
  
        end
    end
end

function printResult (a)
    for i,v in ipairs(a) do
      io.write(v, " ")
    end
    io.write("\n")
end
  
permgen ({1,2,3,4}, 4)

--如果但是这个递归函数其实可以用协程加迭代器去实现

function Ipermgen (a, n)
    if n == 0 then
        --a作为返回值
      coroutine.yield(a)
    else
        for i=1,n do
  
        -- put i-th element as the last one
        a[n], a[i] = a[i], a[n]
  
        -- generate all permutations of the other elements
        Ipermgen(a, n - 1)
  
        -- restore i-th element
        a[n], a[i] = a[i], a[n]
  
        end
    end
end

--定义我们的迭代器
function perm (a)
    local n = table.getn(a)
    local co = coroutine.create(function () permgen(a, n) end)
    return function ()   -- iterator
        local code, res = coroutine.resume(co)
        return res
    end
end

for p in perm{"a", "b", "c"} do
    printResult(p)
end