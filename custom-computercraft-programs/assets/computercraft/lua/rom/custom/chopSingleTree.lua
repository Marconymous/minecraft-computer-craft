turtle.refuel()

while turtle.detect() do
    turtle.dig()
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end

while turtle.detectDown() == false do
    turtle.down()
end
