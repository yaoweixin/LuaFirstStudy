-- Lua interpreter, take advantage of this fact and actually do not use any extra stack space when doing a tail call

function g(x)
    print("ssss" .. tostring(x));
end

function f(x)
    return g(x);
end
--This is call Tail Call


