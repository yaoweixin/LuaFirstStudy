
--[[
    这个是最简单的类
]]
student = {id = 0,score = 0,preSen = 0,name = "YaoWeiXin"}

function student:new(o,id,score,name)
    o = o or {}
    --O是我们的一个对象，self则是我们的元表，我们把所有的属性都存在了元表里面
    setmetatable(o,self)
    --你好，下次index前面记得加两个下划线
    self.__index = self
    self.id = id or 0
    self.name = name or ""
    self.score = score or 0
    --一定要初始化完毕，不然就会造成空引用
    self.preSen = 0
    --为什么我们要使用元表，因为元表有__index这些方法可以实现面向对象的属性，如果我们使用的是

    --[[我们换一种初始化的方式，不设置元表
    o.id = id or 0
    o.score = score or 0
    o.name = name or ""
    o.preSen = 0]]
    return o
end


--self就是所谓的隐藏参数
function student:GetPass()
    self.preSen = self.score / 100;
    if self.preSen >= 0.6 then
        print("Congratuation!You pass the exam")
    elseif self.preSen < 0.6 then
        print("I am sorry,you dont pass the exam")
    end
end

student_A = student:new(nil,1,33,"LittleYao")
--如果我们没有添加元表的话，那么就会指向空
--print(getmetatable(student_A).id)
--如果我们实例化我们的返回值o，并为其赋值
print(student_A.name)
student_A:GetPass()


