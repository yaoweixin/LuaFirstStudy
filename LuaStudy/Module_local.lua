local module1 = {}

local function module1_print1()
    print("I am module1_print1")
end

local function module1_print2()
    print("I am module1_print2")
end

module1.module1_print1 = module1_print1
module1.module1_print2 = module1_print2

local module2 = {}

local function module2_print1()
    print("I am module2_print1")
end

local function module2_print2()
    print("I am module2_print2")
end

module2.module2_print1 = module2_print1
module2.module2_print2 = module2_print2

return{
    module1,
    module2
}