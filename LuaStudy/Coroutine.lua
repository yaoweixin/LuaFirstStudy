--今天来学习一下协程捏
co = coroutine.create(function (...)
    print("I am coroutine")
end)
--创建一个协程，并且运行，create后面跟的一般是匿名方法
--A coroutine can be in one of three different states: suspended, running, and dead.

print(coroutine.status(co));
coroutine.resume(co);
print(coroutine.status(co));

--真的让协程牛逼的是他的yiele功能，能让协程先停下来，方便下一次resume

co2 = coroutine.create(function (...)
    for i = 1, 10 do
        print(coroutine.status(co2),i)
        coroutine.yield()
    end
end)

for i = 1,10 do
    coroutine.resume(co2)
    print(coroutine.status(co2))
end

------------------------------------------------------------------
co1 = coroutine.create(function (a,b,c)
    print("co",a,b,c)
end)
coroutine.resume(co1,2,4,23)

------------------------------------------------------------------
co3 = coroutine.create(function (a,b)
    coroutine.yield(a * b,a - b,10)
end)
print(coroutine.resume(co3,34,21))

---------------------------------------------------------------------
--yield是会返回传递进去的参数的
co4 = coroutine.create(function (...)
    print(coroutine.status(co4))
    print("co",coroutine.yield())
    print("Dead")
    --print(coroutine.status(co4))
end)

--简单来说，我们每一次resume都会运行到yield的位置，，下一次resume运行一次yield,并且执行之后的内容(比如for的下一次循环)，直到协程挂掉
coroutine.resume(co4)
print(coroutine.status(co4))
coroutine.resume(co4,21,21,34)
print(coroutine.status(co4))
coroutine.resume(co4)--这个时候协程已经挂了，无法再次运行   

--------------------------------------------------------------------------
co5 = coroutine.create(function (...)
    return 4,5
end)

print(coroutine.resume(co5))--输出三个返回值，一个是resume本身运行成功的true，还有一个是协程返回的两个值（4,5）
print(coroutine.resume(co5))--这个时候协程挂了，会返回false