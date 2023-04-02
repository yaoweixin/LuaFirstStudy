local file = io.open("tteexxtt.txt","r+")

io.input(file)
file:write("aaa\n")
file:write("bbb\n")

io.close(file)