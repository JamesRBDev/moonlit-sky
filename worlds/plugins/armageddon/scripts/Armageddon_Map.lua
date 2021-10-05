--|————————————————————————————————————————————————————————————————————————————————————————|
--| DESCRIPTION
--|————————————————————————————————————————————————————————————————————————————————————————|

-- Contributors: RiftTalon

--[[
Runs the entire minimap system.
--]]

--|————————————————————————————————————————————————————————————————————————————————————————|
--| SETTINGS
--|————————————————————————————————————————————————————————————————————————————————————————|

local TILE_FILL        = {
	["Dunes"]          = 12;
	["Plains"]         = 13;
	["Salt"]           = 17;
	["Wasteland"]      = 14;
	["Arid"]           = 18;
	["Road"]           = 10;
	["Alley"]          = 15;
	["Ravine"]         = 19;
}

local GRID_PX          = 32

local WINDOW_SIZE      = 7

local WINDOW_OFFSET    = 0

local MAP_LIST         = {}

local SIZE             = {}

local PORTS            = {}

local PORT_COMMANDS    = {}

local MAPS             = {}

local LANDMARKS        = {}

--|————————————————————————————————————————————————————————————————————————————————————————|
--| VARIABLES
--|————————————————————————————————————————————————————————————————————————————————————————|

local entryLength = 10

local mapping     = false
local palette     = false

local moveList    = {}

local lastMove
local currentTile
local exits
local origPos

--|————————————————————————————————————————————————————————————————————————————————————————|
--| FUNCTIONS
--|————————————————————————————————————————————————————————————————————————————————————————|

function FindSpritePos(tile) -- ()
	tile        = tile / 10
	local tileY = math.floor(tile)
	local tileX = math.floor(((tile - tileY) * 10) + 0.5)
	
	return {X = tileX, Y = tileY}
end

function DrawMap() -- ()
	if not GetVariable("map") then
		SetVariable("map",     "None")
		SetVariable("grid_x",  5     )
		SetVariable("grid_y",  5     )
		SetVariable("explore", "on"  )
	end
	
	local map        = GetVariable("map") or "None"
	local mSize      = WINDOW_SIZE
	win              = GetPluginID()
	local locX, locY = tonumber(GetVariable("grid_x")), tonumber(GetVariable("grid_y"))
	local wCenter    = GetInfo(250) / 2
	local hCenter    = GetInfo(280) / 2
	
	if mSize > SIZE[map][1] then
		mSize =  math.max(SIZE[map][1], 7)
	end
	
	local wSize = (mSize * GRID_PX) + 12
	
	if not origPos then
		origPos    = {}
		origPos[1] = wCenter
		origPos[2] = (hCenter - 400) + WINDOW_OFFSET
	end
	
	-- make miniwindow
	WindowCreate(win,
		origPos[1], origPos[2], wSize, wSize, -- pos/size
		0, -- docked to
		2, -- flags
		ColourNameToRGB "#343434")
	
	WindowSetZOrder(win, 40)
	
	WindowLoadImage(win, "background", "worlds/plugins/armageddon/images/arma_window_background.png")
	WindowLoadImage(win, "corners",    "worlds/plugins/armageddon/images/arma_corners.png"          )
	WindowLoadImage(win, "tilesheet",  "worlds/plugins/armageddon/images/map/Tiles.png"             )
	WindowLoadImage(win, "grid",       "worlds/plugins/armageddon/images/map/Grid.png"              )
	WindowLoadImage(win, "exits",      "worlds/plugins/armageddon/images/map/Exits.png"             )
	
	if not GetVariable("token") then
		SetVariable("token", "Default")
	end
	
	WindowLoadImage(win, "marker", "worlds/plugins/armageddon/images/tokens/"..GetVariable("token")..".png")
	
	WindowDrawImage(win, "background", 2, 2, wSize - 2, wSize - 2, 2, 0, 0, 0, 0)
	
	if PORTS[map] and PORTS[map][locX..","..locY] then
		local port2 = PORTS[map][locX..","..locY]
		
		if port2[1] ~= map then
			SetVariable("map", port2[1])
		end
		
		SetVariable("grid_x", port2[2])
		SetVariable("grid_y", port2[3])
		
		return DrawMap()
	end
	
	local startX, startY = math.max(locX - (mSize / 2), 0), math.max(locY - (mSize / 2), 0)
	local endX, endY = math.min(SIZE[map][1], locX + (mSize / 2)) - 1, math.min(SIZE[map][2] - 1, locY + (mSize / 2) - 1)
	
	startX, startY, endX, endY = math.floor(startX + 0.5), math.floor(startY + 0.5), math.floor(endX + 0.5), math.floor(endY + 0.5)
	
	local map = MAPS[map]
	
	local myX, myY
	
	for y = startY, endY do
		local info = map[y + 1]
		
		for x = startX, endX do
			local tile = info[x + 1]
			
			if tile then
				local exploreTable = {}
				
				if not GetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_")) then
					SetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_"), "0,0")
				end
				
				if GetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_")) then
					for word in string.gmatch(GetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_")), "%S+") do
						exploreTable[word] = true
					end
				end
				
				local on = false
				
				if x == locX and y == locY then
					on = true
					
					if not exploreTable[x..","..y] then
						SetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_"), GetVariable("explored_"..string.gsub(GetVariable("map"), " ", "_")).." "..x..","..y)
					end
				end
				
				for sprite in string.gmatch(tile, "%d+") do
					coord = FindSpritePos(sprite)
					if coord and tile ~= " " and (exploreTable[x..","..y] or on or GetVariable("explore") == "off") then
						WindowDrawImageAlpha(win, "tilesheet", ((x - startX) * GRID_PX) + 6, ((y - startY) * GRID_PX) + 6, (((x - startX) + 1) * GRID_PX) + 6, (((y - startY) + 1) * GRID_PX) + 6, 1, coord.X * GRID_PX, coord.Y * GRID_PX)
					end
				end
				
				if tile ~= "" and tile ~= " " then
					WindowDrawImageAlpha(win, "grid", ((x - startX) * GRID_PX) + 6, ((y - startY) * GRID_PX) + 6, (((x - startX) + 1) * GRID_PX) + 6, (((y - startY) + 1) * GRID_PX) + 6, 1, 0, 0)
				else
					WindowDrawImageAlpha(win, "grid", ((x - startX) * GRID_PX) + 6, ((y - startY) * GRID_PX) + 6, (((x - startX) + 1) * GRID_PX) + 6, (((y - startY) + 1) * GRID_PX) + 6, 1, GRID_PX, 0)
				end
				
				if on then
					myX, myY = x, y
				end
			end
		end
	end
	
	if GetVariable("token") and myX and myY then
		--WindowDrawImageAlpha(win, "marker", ((myX - startX) * GRID_PX) - 12, ((myY - startY) * GRID_PX) - 28, (((myX - startX) + 1) * GRID_PX) + 20, (((myY - startY) + 1) * GRID_PX) + 20, 1, 0, 0)
		WindowDrawImageAlpha(win, "marker", ((myX - startX) * GRID_PX) - 10, ((myY - startY) * GRID_PX) - 10, (((myX - startX) + 1) * GRID_PX) + 38, (((myY - startY) + 1) * GRID_PX) + 38, 1, 0, 0)
	elseif myX and myY then
		WindowDrawImageAlpha(win, "marker", ((myX - startX) * GRID_PX) + 6, ((myY - startY) * GRID_PX) + 6, (((myX - startX) + 1) * GRID_PX) + 6, (((myY - startY) + 1) * GRID_PX) + 6, 1, 0, 0)
	end
	
	WindowDrawImageAlpha(win, "corners", 0,           0,          16,    16,    1, 0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16,  0,          wSize, 16,    1, 16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,           wSize - 16, 16,    wSize, 1, 0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16,  wSize - 16, wSize, wSize, 1, 16, 16)
	
	if exits then
		if string.find(exits, "N") then
			WindowDrawImageAlpha(win, "exits", (wSize / 2) - 4, 0, (wSize / 2) + 4, 8, 1, 0, 0)
		end
		
		if string.find(exits, "E") then
			WindowDrawImageAlpha(win, "exits", wSize - 8, (wSize / 2) - 4, wSize, (wSize / 2) + 4, 1, 8, 0)
		end
		
		if string.find(exits, "S") then
			WindowDrawImageAlpha(win, "exits", (wSize / 2) - 4, wSize - 8, (wSize / 2) + 4, wSize, 1, 0, 8)
		end
		
		if string.find(exits, "W") then
			WindowDrawImageAlpha(win, "exits", 0, (wSize / 2) - 4, 8, (wSize / 2) + 4, 1, 8, 8)
		end
	end
	
	WindowShow(win, true)
end

function PrintGrid() -- ()
	Note("You are at: " .. GetVariable("grid_x") .. ", " .. GetVariable("grid_y"))
end

function MoveMade(move) -- ()
	if mapping then
		moveList[#moveList + 1] = move
	end
end

function StopMove() -- ()
	moveList = {}
end

function ChangeGridX(inc, override) -- (number, boolean)
	currentTile = nil
	if mapping or override then
		inc = GetVariable("grid_x") + inc
		if inc > tonumber(GetVariable("grid_x")) then
			lastMove = "E"
		elseif inc < tonumber(GetVariable("grid_x")) then
			lastMove = "W"
		end
		SetVariable("grid_x", inc)
		--PrintGrid()
		DrawMap()
	end
end

function ChangeGridY(inc, override) -- (number, boolean)
	currentTile = nil
	if mapping or override then
		inc = GetVariable("grid_y") + inc
		if inc > tonumber(GetVariable("grid_y")) then
			lastMove = "S"
		elseif inc < tonumber(GetVariable("grid_y")) then
			lastMove = "N"
		end
		SetVariable("grid_y", inc)
		--PrintGrid()
		DrawMap()
	end
end

function SetGrid(incx, incy) -- (number, number)
	currentTile = nil
	if GetVariable("grid_x") ~= tostring(incx) or GetVariable("grid_y") ~= tostring(incy) then
		SetVariable("grid_x", incx)
		SetVariable("grid_y", incy)
		PrintGrid()
		DrawMap()
	end
end

function ChangeMap(newMap) -- (string)
	if GetVariable("map") ~= newMap then
		if MAPS[newMap] then
			SetVariable("map", newMap)
			Note(newMap, " loaded.")
			SetGrid(0, 0)
			ActivateNotepad("Map_"..GetVariable("map"))
			DrawMap()
		else
			Note("No such map found, check your capitalization.")
		end
	end
end

function ListMaps() -- ()
	for map, _ in pairs(MAPS) do
		Note(map)
	end
end

function UndoMove() -- ()
	if mapping then
		table.remove(moveList, 1)
	end
end

function ToggleMapping(state) -- (boolean)
	if state == nil then
		mapping = not mapping
		
		if mapping then
			Note("Mapping toggled on.")
		else
			Note("Mapping toggled off.")
		end
	else
		mapping = state
	end
end

function ToggleExplore() -- ()
	if GetVariable("explore") == "off" then
		SetVariable("explore", "on")
		Note("Exploration toggled on.")
	else
		SetVariable("explore", "off")
		Note([[WARNING! YOU HAVE TOGGLED EXPLORATION OFF!
DOING THIS CAN GET YOU PERMANENTLY BANNED FROM ARMAGEDDON!
USE AT YOUR OWN RISK!]])
	end
	
	DrawMap()
end

function MapSize(newSize) -- (number)
	if type(newSize) == "number" and tonumber(newSize) >= 7 then
		WINDOW_SIZE = 7--tonumber(newSize)
		Note("Changed map window size to: ", newSize)
	else
		Note("Map window size must be set to a number at or above 7.")
	end
	DrawMap()
end

function Add(selected, x, y) -- (string, number, number)
	local override = false
	local map      = MAPS[GetVariable("map")]
	
	if not x or not y then
		x, y = GetVariable("grid_x") + 1, GetVariable("grid_y") + 1
	else
		x, y = x + 1, y + 1
		override = true
	end
	
	if map[y] and map[y][x] and (not string.find(map[y][x], selected, 1, true) or override) then
		if #map[y][x] < 1 then
			map[y][x] = map[y][x]..selected
		else
			map[y][x] = map[y][x].."/"..selected
		end
		
		DrawMap()
		ReplaceNotepad("Map_"..GetVariable("map"), GetMapText(true))
	end
end

function SetCurrentTile(tileName) -- (string)
	currentTile = tileName
	local x, y  = GetVariable("grid_x"), GetVariable("grid_y")
	local map   = MAPS[GetVariable("map")]
	
	if map[x+1] == " " and map[y+1] == " " then
		AutoTile()
	end
end

function AutoTile() -- ()
	local x, y = GetVariable("grid_x") + 1, GetVariable("grid_y") + 1
	local map  = MAPS[GetVariable("map")]
	local fill = TILE_FILL[currentTile]
	
	if fill then
		if map[y] and map[y][x] then
			map[y][x] = fill
			DrawMap()
		end
		Note("Filled ", currentTile, " with: ", fill)
		ReplaceNotepad("Map_"..GetVariable("map"), GetMapText(true))
	else
		Note("Tile is not auto-tile compatible.")
	end
end

function Clear(x, y) -- (number, number)
	local map = MAPS[GetVariable("map")]
	
	if not x or not y then
		x, y = GetVariable("grid_x"), GetVariable("grid_y")
	end
	
	if map[y+1] and map[y+1][x+1] then
		map[y+1][x+1] = ""
		DrawMap()
		ReplaceNotepad("Map_"..GetVariable("map"), GetMapText(true))
	end
end

function GetMapText(whitespace) -- (boolean)
	local newMap = "{"
	local map    = MAPS[GetVariable("map")]
	
	local function append(text)
		newMap = newMap..text
	end
	
	for y = 1, #map do
		if whitespace then
			append("\r")
		end
		
		append("\n{ ")
		
		for x = 1, #map[y] do
			if map[y][x] == "" or map[y][x] == " " then
				append([[(" "     )]])
			else
				local dupeList = ""
				
				for char in string.gmatch(map[y][x], ".") do
					if not string.find(dupeList, char, 1, true) and char ~= " " then
						dupeList = dupeList..char
					end
				end
				
				map[y][x] = dupeList
				
				local toAppend = [[("]]..map[y][x]..[["]]
				
				for i = 1, entryLength - (#map[y][x] + 4) do
					toAppend = toAppend.." "
				end
				
				append(toAppend..")")
			end
			
			if x ~= #map[y] then
				append(",")
			end
		end
		
		append(" }; -- "..y - 1)
		
		if whitespace then
			append("\r")
		end
	end
	
	append("\n}")
	
	return newMap
end

function Port(pType) -- ()
	local newPort = PORT_COMMANDS[GetVariable("map")]
	if newPort and newPort[pType]  then
		newPort = newPort[pType]
		if newPort[GetVariable("grid_x")..","..GetVariable("grid_y")] then
			newPort = newPort[GetVariable("grid_x")..","..GetVariable("grid_y")]
			SetVariable("map", newPort[1])
			SetVariable("grid_x", newPort[2])
			SetVariable("grid_y", newPort[3])
			DrawMap()
			
			return true
		end
	end
	
	return false
end

function SetToken(token) -- (string)
	SetVariable("token", token)
	Note("Map token was set to ["..token.."]")
	DrawMap()
end

function TokenList() -- ()
	local importList = loadfile("worlds/plugins/armageddon/images/tokens/TokenList.lua")()
	
	Note("")
	Note("List of Map Tokens:")
	
	for _, token in ipairs(importList) do
		Note(token)
	end
	
	Note("")
end

function TogglePalette() -- ()
	if not palette then
		WindowShow(win2, true)
		palette = true
	else
		WindowShow(win2, false)
		palette = false
	end
end

function AddAutoPort(match, map, x, y)
	-- todo
end

function AddRows(num, anchor, optMap)
	local map = MAPS[GetVariable("map")]
	
	if optMap then
		map = MAPS[optMap]
	end
	
	for i = 1, num do
		local row = {}
			
		for n = 1, SIZE[GetVariable("map")][1] do
			table.insert(row, " ")
		end
		
		if anchor == "start" then
			table.insert(map, 1, row)
		elseif anchor == "end" then
			table.insert(map, #map + 1, row)
		end
	end
	
	SIZE[GetVariable("map")][2] = SIZE[GetVariable("map")][2] + num
	
	if anchor == "start" then
		ChangeGridY(num)
	end
	
	DrawMap()
end

function AddColumns(num, anchor, optMap)
	local map = MAPS[GetVariable("map")]
	
	if optMap then
		map = MAPS[optMap]
	end
	
	for i = 1, num do
		for _, tileSet in pairs(map) do
			if anchor == "start" then
				table.insert(tileSet, 1, " ")
			elseif anchor == "end" then
				table.insert(tileSet, #tileSet + 1, " ")
			end
		end
	end
	
	SIZE[GetVariable("map")][1] = SIZE[GetVariable("map")][1] + num
	
	if anchor == "start" then
		ChangeGridX(num)
	end
	
	DrawMap()
end

function Import(map, overrideMessages) -- (table/string, boolean)
	local loadedMap
	
	if map and type(map) == "string" then
		loadedMap = loadfile("worlds/plugins/armageddon/maps/"..map..".lua")
	end

	if loadedMap then
		local p, pc, m, l  = loadedMap()
		SIZE[map]          = {#m[1], #m}
		PORTS[map]         = p
		PORT_COMMANDS[map] = pc
		MAPS[map]          = m
		
		for title, info in pairs(l) do
			LANDMARKS[title] = info
		end
		
		if not overrideMessages then
			Note("Map Imported: ", map)
		end
	elseif type(map) == "table" then
		MAPS[GetVariable("map")] = map
		
		if not overrideMessages then
			Note("Map Imported: ", GetVariable("map"))
		end
		DrawMap()
	elseif not overrideMessages then
		Note("Map Failed: ", map)
	end
end

function Compass(name, line, wildcards)
	local foundLandmark
	for title, info in pairs(LANDMARKS) do
		if line:match(title) or line:sub(1, #title) == title then
			foundLandmark = info
		end
	end
	
	if foundLandmark then
		table.remove(moveList, 1)
		ChangeMap(foundLandmark[1])
		SetGrid(foundLandmark[2], foundLandmark[3])
	else
		if #moveList > 0 then
			local move    = table.remove(moveList, 1)
			local didPort = Port(move)
			
			if not didPort then
				if     move == "North" then SetVariable("grid_y", GetVariable("grid_y") - 1)
				elseif move == "East"  then SetVariable("grid_x", GetVariable("grid_x") + 1)
				elseif move == "South" then SetVariable("grid_y", GetVariable("grid_y") + 1)
				elseif move == "West"  then SetVariable("grid_x", GetVariable("grid_x") - 1)
				end
			end
		end
		
		exits = wildcards[0]
		DrawMap()
		exits = nil
	end
end

function MakeMoves() -- ()
	for i = 1, #moveList do
		local move = table.remove(moveList, 1)
		
		if     move == "North" then SetVariable("grid_y", GetVariable("grid_y") - 1)
		elseif move == "East"  then SetVariable("grid_x", GetVariable("grid_x") + 1)
		elseif move == "South" then SetVariable("grid_y", GetVariable("grid_y") + 1)
		elseif move == "West"  then SetVariable("grid_x", GetVariable("grid_x") - 1)
		end
	end
end

function Setup() -- ()
	-- make palette window
	win2 = GetPluginID().."1"
	
	-- make miniwindow
	WindowCreate(win2,
		0, 0, 352, 352, -- pos/size
		4, -- docked to
		4, -- flags
		ColourNameToRGB "lightgray")
	
	WindowLoadImage(win2, "ref", "worlds/plugins/armageddon/images/map/Tiles_Palette.png")
	WindowRectOp(win2, 2, 0, 0, 0, 0, ColourNameToRGB "lightgray")
	WindowDrawImage(win2, "ref", 0, 0, 0, 0, 1, 0, 0, 0, 0)
	WindowSetZOrder(win2, 40)
	
	MAP_LIST = loadfile("worlds/plugins/armageddon/maps/MapList.lua")()
	
	-- load maps
	for _, map in pairs(MAP_LIST) do
		Import(map, true)
	end
	
	DoAfterSpecial(1, "DrawMap()", 12)
end

function OnPluginDisable() -- ()
  WindowShow (win, false)
  WindowShow (win2, false)
end

--|————————————————————————————————————————————————————————————————————————————————————————|
--| CALLS
--|————————————————————————————————————————————————————————————————————————————————————————|

Setup()