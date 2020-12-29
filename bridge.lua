turtle = turtle

local width = tonumber(arg[1])
local length = tonumber(arg[2])
local totalBlocks = width * length

local currentWidth = 1
local currentLength = 1
local currentBlockSlot = 2
local placedBlocks = 0


function PrintInfo()
    placedBlocks = placedBlocks + 1
    print(tostring(placedBlocks), " of ", tostring(totalBlocks), " blocks have been placed!")
end

function RefuelTurret()
    turtle.select(1)
    turtle.refuel()
    turtle.select(currentBlockSlot)
end

function CheckSlotEmpty()
    ItemCount = turtle.getItemCount(currentBlockSlot)
    if ItemCount == 0 then
        currentBlockSlot = currentBlockSlot + 1
        print("The current slot was empty so we changed it to ", currentBlockSlot)
    end
    turtle.select(currentBlockSlot)
end

function PlaceBlockMove() -- Moves and places Block
    turtle.placeDown()
    PrintInfo()
    turtle.forward()
    CheckSlotEmpty()
end


turtle.turnRight()
while currentLength <= length + 1 do
    while currentWidth < width do -- calls the function to move right and place blocks
        RefuelTurret()
        PlaceBlockMove()
        currentWidth = currentWidth + 1
    end
    currentLength = currentLength + 1

    if currentLength >= length + 1 then break end

    CheckSlotEmpty()
    turtle.placeDown()
    PrintInfo()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    while currentWidth > 1 do -- calls the function to move left and place blocks
        RefuelTurret()
        PlaceBlockMove()
        currentWidth = currentWidth - 1
    end
    currentLength = currentLength + 1
    CheckSlotEmpty()
    turtle.placeDown()
    PrintInfo()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
end
turtle.placeDown()
PrintInfo()