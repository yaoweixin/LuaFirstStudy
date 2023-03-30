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

