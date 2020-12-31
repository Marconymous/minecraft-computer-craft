-- function to restock TNT
function restock()
	turtle.select(15)
	turtle.placeUp()
	turtle.select(1)
	turtle.suckUp()
	turtle.select(15)
	turtle.digUp()
end

-- function to refuel
function refuel()
	turtle.select(16)
	turtle.placeUp()
	turtle.select(2)
	turtle.suckUp()
	turtle.select(16)
	turtle.digUp()
end

function checkRestock()
	turtle.select(1)
	if turtle.getItemCount() == 0 then
		restock()
	end
	turtle.select(2)
	if turtle.getItemCount() == 0 then
		refuel()
	end
	turtle.refuel()
	turtle.select(1)
end

function main()
	print("NUKE HAS STARTET!")
	redstone.setOutput("bottom", true)
	checkRestock()
	for i = 1, tonumber(arg[1]), 1 do
		checkRestock()
   	 	turtle.forward()
   		turtle.placeDown()
	end
sleep(3)
end

main()