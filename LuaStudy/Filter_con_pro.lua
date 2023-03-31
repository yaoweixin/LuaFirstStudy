--接下来我们写写关于生产者消费者模型的优化，使用过滤器进行优化（filter）
function receive(prod)
    local status,value = coroutine.resume(prod)
    return value
end

function send(x)
    coroutine.yield(x)
end

function producer()
    return coroutine.create(function (...)
        while true do
            local x = io.read()
            send(x)
        end
    end)
end

function filter(prod)
    return coroutine.create(function (...)
        local line = 1
        while true do
            local x = receive(prod)
            x = string.format("%5d %s",line,x)
            send(x) --发送给消费者
            line = line + 1
        end
    end)
    
end

function consumer(prod)
    while true do
        local x = receive(prod)
        io.write(x,"\n")
    end
end

--我们来捋一捋这个的调用过程
p = producer() --先获取一个producer协程
f = filter(p) --然后再获取一个filter协程
consumer(f) --最后调用消费者
--当我们消费者调用filter的时候，我们先会唤醒filter协程，
--再接着，filter运行过程中会唤醒producer协程，producer协程会创造产品并返回产品
--接着我们对产品进行处理，并发送给消费者，结束当前协程
--然后接着回到消费者，写入之后（io.write），我们再进行下一次协程的唤醒，依次循环一到三步