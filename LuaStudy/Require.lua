--这些基本都是我们写代码会报错的时候应该如何解决，以及怎么预防我们程序运行异常

local lib = "/usr/local/lua/lib/sssss.so"
--local f = loadfile()

print("Please Enter the Num")
n = io.read("*number")
if not n  then
    error("Invalid input")
end

print("enter a number")
n = assert(io.read("*number"),"invalid input")

n = io.read()
assert(tonumber(n),"invalid input: " .. n .. "is not a number")

local file,msg
repeat
    print("enter a file name:")
    local name = io.read()  
    if not name then return end
    file,msg = io.open(name,"r")
    if not file then print(msg) end
until file

--such as
x = io.read() 
if not tonumber(x) then
    error("Not valid")
end

file = assert(io.open("no-file", "r"))

function foo()
    if not tonumber(x ) then
        error("Oh! Wrong!")
    end
end

--去检查一个方法运行是否正常
if pcall(foo) then
print("Right!!!")
else
print("Wrong")
end
--同样也可以用匿名函数

if pcall(function () print("I am niming") end) then print("Right!!!!!!")
else
    print("Wrongggggggg")
end
