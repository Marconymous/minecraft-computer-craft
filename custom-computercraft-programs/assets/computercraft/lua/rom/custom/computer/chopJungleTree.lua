function cc()
  term.clear()
  term.setCursorPos(1,1)
end

function setWorking()
  term.setBackgroundColor(colors.yellow)
  term.setTextColor(colors.black)
end

function setCompleted()
  term.setBackgroundColor(colors.green)
  term.setTextColor(colors.black)
end

function setError()
  term.setBackgroundColor(colors.red)
  term.setTextColor(colors.black)
end

function checkAlignment()
  cc()
  setWorking()

  isJungle = false
  while isJungle == false do
    io.write("Please put jungle wood in the second slot!")
    io.read()
    turtle.select(2)
    if turtle.getItemDetail().name == "minecraft:log" then
      isJungle = true
    end
  end

  local isAligned = false
  turtle.turnRight()
  turtle.forward()
  turtle.turnLeft()
  if turtle.compare() then
    isAligned = true
  else
    isAligned = false
  end
  turtle.turnLeft()
  turtle.forward()
  turtle.turnRight()
  return isAligned
end

function endRun()
  cc()
  setCompleted()
  io.write("The turret completed it's job!")
end

function chop()
  -- Turtle goes up and breaks blocks above and in front
  turtle.dig()
  turtle.forward()
  while turtle.detectUp() do -- first col
    turtle.dig()
    turtle.digUp()
    turtle.up()
  end -- endwhile
  turtle.dig()


  -- Turtle changes position and breaks blocks down and in front
  turtle.turnRight()
  turtle.dig()
  turtle.forward()
  turtle.turnLeft()
  while turtle.compare() do
    turtle.dig()
    turtle.digDown()
    turtle.down()
  end -- endwhile
  endRun()
end -- endfunc

function checkFuel()
  canFuel = false
  fuelSelector = 0
  cc()
  setWorking()
  for i = 1, 16, 1 do
    turtle.select(i)
    if turtle.refuel(0) then
      canFuel = true
      fuelSelector = i
      break
    end -- endif
  end -- endfor
  if canFuel == false then
    cc()
    setWorking()
    io.write("Please add fuel to the turtles inventory!")
    io.read()
    return false
  else
    turtle.select(fuelSelector)
    turtle.refuel()
    return true
  end --endif
end -- endfunc

function start()
  local fueled = false
  while fueled == false do
    fueled = checkFuel()
  end
  cc()
  setWorking()
  io.write("Checking if your turret is correctly aligned ...")
  if checkAlignment() then
    cc()
    setCompleted()
    io.write("Your turtle is correctly aligned and will begin felling the tree once you press enter!")
    io.read()
    chop()
  else
    cc()
    setError()
    io.write("Please place your turret on the left block of the jungle tree and rerun the program!")
  end -- endif
end --endfunc

start()
