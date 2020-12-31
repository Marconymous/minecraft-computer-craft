-- https://pastebin.com/0hUKaXKe

function cc()
  term.clear()
  term.setCursorPos(1,1)
end

cc()

-- Print infoOut
io.write("Chest left of turtle with fuel [enter anything to continue] : ")
io.read()
io.write("Chest behind of turtle [enter anything to continue] : ")
io.read()

-- Get the amount of rows
io.write("Rows    : ")
rows = io.read()
cc()
-- Get the amount of columns
io.write("Columns : ")
cols = io.read()
cc()

-- Get current Y level
io.write("Current Y : ")
initY = io.read()
cc()

-- Get info if turtle should toss away garbage blocks
io.write("Keep garbage [yes / no] : ")
keepGarbage = io.read()
cc()

posX = 0
posY = 0
posZ = 0
rotation = 0

fullSlots = 0

function infoOut()
  cc()
  print("------------------------------")
  print("Size : " .. rows .. " by " .. cols)
  print("Current distance : " .. posX + posY + posZ)
  print("Orientation: " .. rotation)
  print("X : " .. posX)
  print("Y : " .. posY)
  print("Z : " .. posZ)
end

function rotate()
  if rotation == 0 then
      turtle.turnLeft()
  elseif rotation == 1 then
      turtle.turnLeft()
      turtle.turnLeft()
  elseif rotation == 2 then
      turtle.turnRight()
  end
end

function recover()
  rotate()
  local currentAxisPos = 0

  for currentAxisPos = posY - 1, 0, -1 do
    turtle.up()
  end

  for currentAxisPos = posX - 1, 0, -1 do
    turtle.forward()
  end
  turtle.turnLeft()
  for currentAxisPos = posZ - 1, 0, -1 do
    turtle.forward()
  end
end

function resume()
    turtle.turnLeft()
    turtle.turnLeft()
    local step = 0
    for step = 0, posZ - 1, 1 do
        turtle.forward()
    end
    turtle.turnRight()
    for step = 0, posX - 1, 1 do
        turtle.forward()
    end
    for step = 0, posY - 1, 1 do
        turtle.down()
    end
    if rotation == 0 then
        turtle.turnLeft()
    elseif rotation == 2 then
        turtle.turnRight()
    elseif rotation == 3 then
        turtle.turnRight()
        turtle.turnRight()
    end
end

function checkFuelLevel()
    turtle.select(1)
    turtle.refuel()
    if turtle.getFuelLevel() <= posX + posY + posZ + 1 then
        refill = 1
        empty()
        refill = 0
    end
end

function empty()
    recover()
    local search = 0
    for search = 16, 1, -1 do
        turtle.select(search)
        turtle.drop()
    end
    if refill == 1 then
        turtle.turnRight()
        while turtle.getFuelLevel() <= posX + posY + posZ + 1 do
            if turtle.suck() == true then
                turtle.suck()
                turtle.select(1)
                turtle.refuel()
            elseif turtle.suck() == false then
                turtle.select(1)
                turtle.refuel()
                term.clear()
                term.setCursorPos(1,1)
                io.write("Please put more fuel into my first slot the or fuel chest!")
            end
        end
        turtle.turnLeft()
        resume()
    end
    if done ~= 1 then
        resume()
    end
end

function checkFull()
    fullSlots = 0
    local search = 0
    for search = 16, 1, -1 do
        turtle.select(search)
        if turtle.getItemCount() > 0 then
            if keepGarbage == "no" then
                if turtle.getItemDetail().name == "minecraft:cobblestone" then
                    turtle.drop()
                elseif turtle.getItemDetail().name == "minecraft:stone" then
                    turtle.drop()
                elseif turtle.getItemDetail().name == "minecraft:dirt" then
                    turtle.drop()
                elseif turtle.getItemDetail().name == "minecraft:gravel" then
                    turtle.drop()
                elseif turtle.getItemDetail().name == "minecraft:netherrack" then
                    turtle.drop()
                end
            end
        end
        if turtle.getItemCount() > 0 then
            fullSlots = fullSlots + 1
        end
    end
    if fullSlots == 16 then
        empty()
    end
end

function nextRow()
    if turn == 0 then
        turtle.turnRight()
        rotation = 1
        digStraight()
        turtle.turnRight()
        rotation = 2
        turn = 1
    elseif turn == 1 then
        turtle.turnLeft()
        rotation = 1
        digStraight()
        turtle.turnLeft()
        rotation = 0
        turn = 0
    elseif turn == 2 then
        turtle.turnRight()
        rotation = 3
        digStraight()
        turtle.turnRight()
        rotation = 0
        turn = 3
    elseif turn == 3 then
        turtle.turnLeft()
        rotation = 3
        digStraight()
        turtle.turnLeft()
        rotation = 2
        turn = 2
    end
end

function digDown()
    checkFuelLevel()
    local step = 0
    for step = 2, 0, -1 do
        turtle.digDown()
        if turtle.down() == true then
            posY = posY + 1
        end
        infoOut()
    end
end

function digStraight()
    checkFuelLevel()
    turtle.digDown()
    turtle.dig()
    turtle.dig()
    turtle.forward()
    if rotation == 0 then
        posZ = posZ + 1
    elseif rotation == 1 then
        posX = posX + 1
    elseif rotation == 2 then
        posZ = posZ - 1
    elseif rotation == 3 then
        posX = posX - 1
    end
    turtle.digUp()
    infoOut()
end

function quarry()
    turn = 0
    done = 0
    iniY = tonumber (iniY)
    checkFuelLevel()
    turtle.digUp()
    turtle.up()
    posY = posY - 1
    while posY < initY - 2 do
        digDown()
        for c = cols, 1, -1 do
            for r = rows, 2, -1 do
                digStraight()
            end
            checkFull()
            if c == 1 then
                turtle.turnRight()
                turtle.turnRight()
                if rotation == 0 then
                    rotation = 2
                elseif rotation == 2 then
                    rotation = 0
                end
                if turn == 0 then
                    turn = 2
                elseif turn == 1 then
                    turn = 3
                elseif turn == 2 then
                    turn = 0
                elseif turn == 3 then
                    turn = 1
                end
            elseif c > 1 then
                nextRow()
            end
        end
    end
    turtle.digDown()
    done = 1
    empty()
    term.clear()
    term.setCursorPos(1,1)
    print("Thank you for using Gambit's quarry program!")
    print("---------------------------------------")
end

quarry()
