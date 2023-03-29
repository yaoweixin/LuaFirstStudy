function enCounter()
    i = 0
    return function ()
        i = i + 1
        return i
    end
end

c1 = enCounter()



print(c1())
print(c1())

i = i + 1
print(i)