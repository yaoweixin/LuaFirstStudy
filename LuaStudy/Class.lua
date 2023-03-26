
--[[
    这个是最简单的类
]]
student = {id = 0,score = 0,preSen = 0,name = "YaoWeiXin"}

function student:new(o,id,score,name)
    o = o or {}
    --O是我们的一个对象，self则是我们的元表，我们把所有的属性都存在了元表里面
    setmetatable(o,self)
    self._index = self
    self.id = id or 0
    self.name = name or ""
    self.score = score or 0
    return o
end

function student:GetPass()
    self.preSen = self.score / 100;
    if self.preSen >= 0.6 then
        print("Congratuation!You pass the exam")
    elseif self.preSen < 0.6 then
        print("I am sorry,you dont pass the exam")
    end
end

student_A = student:new(nil,1,33,"LittleYao")
print(getmetatable(student_A).id)
getmetatable(student_A):GetPass()


