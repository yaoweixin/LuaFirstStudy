--这次让我们来介绍一下消费者和生产者模式吧
--首先先实现一个简单的消费者生产者模型，也就是只有当消费者需要的时候生产者才会生产，生产完马上被消费者使用
producer = coroutine.create(function ()
    while true do
        local x = io.read()
        send(x)
    end
end)

function consumer()
    while true do
        local x = receive()
        io.write(x,"\n")
    end
end

function receive()
    local status,value = coroutine.resume(producer)
    return value
end

function send(x)
    coroutine.yield(x)
end

--给大家伙捋一捋这个生产者消费者模型是怎么运行的
--第一步：我们消费者有需求了：consumer()
--第二步：我们需要接收生产者生产的产品：receive()
--第三步：在我们的receive函数中唤醒我们的producer，接收resume的返回值
--第四步：我们在producer中把产品生产出来，调用send函数，把值传过去
--第五步：我们的send函数调用yield，把x的值当做返回值返回，同时我们的producer协程被挂起
--第六步：consumer再次请求生产者，循环2-4步

