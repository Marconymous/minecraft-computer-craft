rednet.open("back")
term.clear()
term.setCursorPos(1,1)
io.write("Monitor ID > ")
id = tonumber(io.read())

while true do
    term.clear()
    term.setCursorPos(1,1)
    io.write("Enter your message : ")
    rednet.send(id, io.read())
end
