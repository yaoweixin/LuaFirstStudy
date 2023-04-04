-- 定义一个表
local originalTable = {
    name = "John",
    age = 30,
    hobbies = {"reading", "sports"}
}

-- 使用深拷贝函数复制表
local copiedTable = table.deepcopy(originalTable)

-- 修改原始表
originalTable.age = 31
table.insert(originalTable.hobbies, "music")

-- 输出两个表的内容
print("Original Table: ")
for k, v in pairs(originalTable) do
    if type(v) == "table" then
        print(k .. ": {" .. table.concat(v, ", ") .. "}")
    else
        print(k .. ": " .. tostring(v))
    end
end

print("Copied Table: ")
for k, v in pairs(copiedTable) do
    if type(v) == "table" then
        print(k .. ": {" .. table.concat(v, ", ") .. "}")
    else
        print(k .. ": " .. tostring(v))
    end
end
