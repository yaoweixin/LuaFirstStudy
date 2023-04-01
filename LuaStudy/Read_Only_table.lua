--家人们！！！！！
--今儿咱们来接触一下只读表的概念！！！

function readOnly(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function (t,k,v)
            error("attempt to access the readOnly_table",2)
        end
    }
    setmetatable(proxy,mt)
    return proxy
end

--创建一个只读表
days = readOnly{"Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}

print(days[1])
days[2] = "sss" --我们error的第二个参数是2，说明我们会把错误信息定向到尝试更新的位置
