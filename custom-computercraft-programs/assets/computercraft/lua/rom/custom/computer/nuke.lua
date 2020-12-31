local message = "null"
local length = "null"

rednet.open("left")

while message ~= "launch" do
    id, message = rednet.receive()
end

while length == "null" do
	id, length = rednet.receive()
end

run = "rom/custom/computer/launch " .. length

shell.run(run)