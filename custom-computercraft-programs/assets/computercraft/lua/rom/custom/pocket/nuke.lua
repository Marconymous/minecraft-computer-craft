rednet.open("back")
term.clear()
term.setCursorPos(1,1)
io.write("Enter the Computer ID of your army > ")
id = io.read()

io.write("Enter the length > ")
length = io.read()

rednet.send(tonumber(id), "launch")
print("Your army has received it's signal to start!")
rednet.send(tonumber(id), length)
sleep(3)
rednet.close("back")

