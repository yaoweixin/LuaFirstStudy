--require("module1")
require("complex") --我们同样也可以用一个局部变量来接收我们脚本的返回值  local complex = require("complex")
--可以输出我们这个lua文件已经调用的文件内容
--这些文件和key放在了package,loaded表下面
for k, value in pairs(package.loaded) do
    print(k,value)
end
--如果我们并没有给我们模块返回值，那我们默认给我们的模块键值是true
--require不区分大小写，而且我们寻找的时候是会寻找对应的文件后缀，也就是module2.lua，并不是去找有没有module2这个类
require("module2")
for k, value in pairs(package.loaded) do
    print(k,value)
end

c1 = private_complex.new(2,3)
c2 = private_complex.new(3,5)
c3 = private_complex.add(c1,c2)

print(c3.r,c3.i)

module1.func3()
--使用require可以防止我们在代码中重复运行文件，只需要运行一次就能调用
package.loaded["module2"] = nil --把我们的键值设置成nil，本质是没有变化的
module1.func3()
require("module2")
for k, value in pairs(package.loaded) do
    print(k,value)
end

------------------------------------------------------------

--同样我们也可以通过loadfile的方式，在本代码中运行别的代码的内容，从而调用别的文件的变量    
f = loadfile("C:/Users/Admin/Desktop/LuaFirstStudy/LuaStudy/FirstLua.lua")
f() --在require中我们会自动执行，并将其存入表中，这样下一次就不用再调用了
print(c,d)



--我们希望require进来的模块是不允许定义全局变量的，因为全局变量会污染我们整个环境，并可能造成意想不到的后果，
--在lua 5.1，我们可以使用setfenv函数来设置函数环境，而在lua 5.2以上版本，则可以通过修改env参数来解决

---------------------------------------------------------------------

--一个lua文件里只能有一个retrun，但是一个return里面可以返回多个模块
--把我们的模块全都定义为局部有个好处就是：
--这样我们运行别的文件的时候不会污染我们的全局环境表，使用局部变量，减少全局变量的使用
local modules = require("Module_local")

modules[1].module1_print1()
modules[2].module2_print2()
---------------------------------------------------------------
--lua里的赋值是浅拷贝！！！一个改了另一个也跟着改
local stu = require("InitClass")
stu.id = 10086
print(student_A.id,stu.id)
-----------------------------------------------------------------------
--可以把我们的函数所处的文件地址放在我们的定位表中
local location = {
    foo = "/usr/local/lua/lib/pack1_1.lua",
    goo = "/usr/local/lua/lib/pack1_1.lua",
    foo1 = "/usr/local/lua/lib/pack1_2.lua",
    goo1 = "/usr/local/lua/lib/pack1_3.lua",
}

-----设置元表，创建元方法，这样我们在文件中调用别的文件的函数就会自动执行对应文件并且返回对应函数
-----可以在元表中定义一个方法来加载整个包
pack1 = {}

setmetatable(pack1, {__index = function (t, funcname)
  local file = location[funcname]
  if not file then
    error("package pack1 does not define " .. funcname)
  end
  assert(loadfile(file))()     -- load and run definition
  return t[funcname]           -- return the function
end})

return pack1
