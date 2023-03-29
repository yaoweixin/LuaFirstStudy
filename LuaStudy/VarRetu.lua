
--在我们的可变参数(...)中，我们会把这些长度可变的参数，放到我们函数自带的arg表当中，这样我们就可以访问这些可变参数的内容
function printt(...)
    arg = {...}
    for index, value in ipairs(arg) do
        print(value)
    end
end


--aa = {112,12312,41241}
--a,b,c = unpack(a)
--print(a,b,c)

printt("111","222","333")

--[[print(string.find("hello hello"," hel"))
print(select(1,string.find("hello hello"," hel")))
print(select(2,string.find("hello hello"," hel")))
]]
print(string.find("hello hello", " hel"))         --> 6  9
print(select(1, string.find("hello hello", " hel"))) --> 6
print(select(2, string.find("hello hello", " hel"))) --> 9

function plus_mul(a,b,...)
    local ans = 0
    ans = ans + a
    ans = ans + b
    arg = {...}
    for i, v in ipairs(arg) do
        ans = ans + tonumber(v)
    end 
    return ans
end

aannss = plus_mul(3,6,3,4)
print(aannss)

