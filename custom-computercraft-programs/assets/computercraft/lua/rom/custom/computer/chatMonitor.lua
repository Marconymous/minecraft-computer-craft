rednet.open("left")
local monitor = peripheral.wrap("back")
local x = 1
monitor.setTextScale(0.5)
monitor.clear()
while true do
    monitor.setCursorPos(1,x)
    id, message = rednet.receive()
    monitor.write(id .. " : " .. message)
    x = x + 1
    sleep(1)
end
