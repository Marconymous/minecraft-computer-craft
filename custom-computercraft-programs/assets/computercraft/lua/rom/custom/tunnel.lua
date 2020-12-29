turtle.refuel()

local width = tonumber(arg[1])
local height = tonumber(arg[2])
local depth = tonumber(arg[3])

local currentWidth = 1
local currentHeight = 1
local currentDepth = 1

function ReturnToLineBeginning()
    turtle.turnLeft()
    i = 1
    while i < width do
        turtle.dig()
        turtle.forward()
        i = i + 1
    end
    turtle.turnRight()
    currentWidth = 1
    currentHeight = currentHeight + 1
end

function ReturnToDepthBeginning()
    i = 1
    while i < height do
        turtle.down()
        i = i + 1
    end
    currentWidth = 1
    currentHeight = 1
    currentDepth = currentDepth + 1
    turtle.forward()
end

while currentDepth <= depth do
    while currentHeight < height do
        while currentWidth < width do
            turtle.dig()
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            turtle.turnLeft()
            currentWidth = currentWidth + 1
            turtle.refuel()
        end
        turtle.digUp()
        turtle.up()
        turtle.refuel()
        ReturnToLineBeginning()
    end
    turtle.refuel()
    ReturnToDepthBeginning()    
end

