s,e = string.find("hello Lua users", "Lua")
print (s)
print (e)

print("---------------------------------------------------------\n")

----------------------------------------------------------
function minnum(a)
    local mi = 1
    local m = a[mi]
    for i,val in pairs(a) do
        if val < m then
            m = val
            mi = i
        end
    end
    return m,mi
end

aaa = {12,23,13,4,5,3,6}

print(minnum(aaa))

print("---------------------------------------------------------\n")

----------------------------------------------------------
function foo() end
function foo1() return 'a' end 
function foo2() return 'a','b' end

--当我们将函数调用作为表达式时，Lua只保留第一个返回值。只有当函数调用是表达式列表中的最后一个（或唯一一个）表达式时，我们才会得到所有的返回值。
x,y = foo()
print(x,y)
x,y = foo1()
print(x,y)
x,y = foo2()
print(x,y)
x,y = foo2(),20
print(x,y)
x,y,z = 20,foo2()
print(x,y,z)
x,y,z = foo2(),20
print(x,y,z)

print("---------------------------------------------------------\n")

-----------------------------------------------------------

--当一个函数调用是另一个调用的最后一个（或唯一的）参数时，第一个调用的所有结果作为参数传递
print(foo())
print(foo1(),21)
print(foo2(),34)
print(foo2() .. 'ss')
print(foo2())
print('as',foo2())
print('aaa' .. foo2())

print("---------------------------------------------------------\n")

-----------------------------------------------------------

bb = {foo2(),'c'}
for index, value in ipairs(bb) do
    print(index .. value)
end
cc = {'c',foo2()}
for index, value in ipairs(cc) do
    print(index .. value)
end

print("---------------------------------------------------------\n")

----------------------------------------------------------

a = {foo1(),foo2(),44}

function fooC(i)
    if i == 1 then return foo()
    elseif i == 2 then return foo1()
    elseif i == 3 then return foo2()
    end
end

print("---------------------------------------------------------\n")

----------------------------------------------------------

--我们可以强制让我们的函数只返回第一个值

print((foo()))
print((foo1()))
print((foo2()))

--同理可以用这样限制我们table的赋值
--当一个函数调用作为表达式出现时，Lua会将结果数量自动调整为1,为一个函数调用加上括号，会强制变成表达式
a = {(foo2())}

for index, value in ipairs(a) do
    print(index .. value)
end

print("---------------------------------------------------------\n")

----------------------------------------------------------

t = {122,231,434}
--x,y,z = unpack(t)
--这边的unpack无法使用