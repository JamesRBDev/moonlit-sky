--|————————————————————————————————————————————————————————————————————————————————————————|
--| DESCRIPTION
--|————————————————————————————————————————————————————————————————————————————————————————|

-- Contributors: RiftTalon

--[[
Handles the inventory and equipment screens.
--]]

--|————————————————————————————————————————————————————————————————————————————————————————|
--| SETTINGS
--|————————————————————————————————————————————————————————————————————————————————————————|

FONT_SIZE_OFFSET = 0

WINDOW_WIDTH     = 568

WINDOW_HEIGHT    = 313 + 62

WINDOW_OFFSET    = 0

--|————————————————————————————————————————————————————————————————————————————————————————|
--| VARIABLES
--|————————————————————————————————————————————————————————————————————————————————————————|



--|————————————————————————————————————————————————————————————————————————————————————————|
--| FUNCTIONS
--|————————————————————————————————————————————————————————————————————————————————————————|

items    = {}
equipped = {}
running  = false

function UpdateInventory() -- ()
	local wSize = WINDOW_WIDTH
	local hSize = WINDOW_HEIGHT - 124
	
	WindowLoadImage(win, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	
	WindowDrawImage(win, "background", 4, 2, wSize - 4, hSize - 70, 2, 0, 0, 0, 0)
	
	for i, item in ipairs(items) do
		i = i - 1
		if item:find("^You are carrying:") then
			--[[WindowText (win, "f", item,
				6, 6 + (13 * (i - 1)), WINDOW_WIDTH - 6, 19 + (13 * (i - 1)),  -- rectangle
				ColourNameToRGB ("#C0C0C0"),
				true) -- not Unicode]]
		elseif item:find("^a") or item:find("^some") or item:find("^few") or item:find("^several") or item:find("^many") or item:find("obsidian pieces") or item:find("^the body of") or item:find("^sleeves") then
			WindowText (win, "f", item,
				6, 6 + (13 * (i - 1)), WINDOW_WIDTH - 6, 19 + (13 * (i - 1)),  -- rectangle
				ColourNameToRGB ("#FFFF99"),
				true) -- not Unicode
		else
			DoAfterSpecial(0.1, "Note('') Simulate('"..item.."') Note('')", 12)
		end
	end
	
	WindowDrawImageAlpha(win, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	WindowShow(win, true)
end

function UpdateEquipment() -- ()
	local wSize = WINDOW_WIDTH
	local hSize = WINDOW_HEIGHT
	
	WindowLoadImage(win2, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win2, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	
	WindowDrawImage(win2, "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	for i, item in ipairs(equipped) do
		i = i - 1
		if item:find("^You are using:") then
			--[[WindowText (win2, "f", item,
				6, 6 + (13 * (i - 1)), WINDOW_WIDTH - 6, 19 + (13 * (i - 1)),  -- rectangle
				ColourNameToRGB ("#C0C0C0"),
				true) -- not Unicode]]
		elseif item:find("^<primary hand>") or item:find("^<secondary hand>") or item:find("^<both hands>") then
			WindowText (win2, "f", item,
				6, 6 + (13 * (i - 1)), WINDOW_WIDTH - 6, 19 + (13 * (i - 1)),  -- rectangle
				ColourNameToRGB ("#FF9600"),
				true) -- not Unicode
		elseif item:find("^<") then
			WindowText (win2, "f", item,
				6, 6 + (13 * (i - 1)), WINDOW_WIDTH - 6, 19 + (13 * (i - 1)),  -- rectangle
				ColourNameToRGB ("#FFFF99"),
				true) -- not Unicode
		else
			DoAfterSpecial(0.1, "Note('') Simulate('"..item.."') Note('')", 12)
		end
	end
	
	WindowDrawImageAlpha(win2, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win2, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win2, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win2, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	WindowShow(win2, true)
end

function Setup() -- ()
	win           = GetPluginID()
	win2          = win.."1"
	local wCenter = GetInfo(250)  / 2
	local hCenter = GetInfo(280)  / 2
	local wSize   = WINDOW_WIDTH
	local hSize   = WINDOW_HEIGHT
    
	-- make miniwindow 2 (equipment)
	WindowCreate(win2, 
		wCenter, (hCenter - 226 + 62) + WINDOW_OFFSET, wSize, hSize, -- pos/size
		0, -- docked to
		2, -- flags
		ColourNameToRGB "#343434")
	
	WindowLoadImage(win2, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win2, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	
	WindowDrawImage(win2, "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	WindowDrawImageAlpha(win2, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win2, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win2, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win2, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	WindowFont(win2, "f", GetInfo(20), GetInfo(243) + FONT_SIZE_OFFSET)
	
	hSize = (WINDOW_HEIGHT - 62) - 124
	
	-- make miniwindow 1 (inventory)
	WindowCreate(win, 
		wCenter, (hCenter - 226 + 62 + WINDOW_HEIGHT) + WINDOW_OFFSET, wSize, hSize, -- pos/size
		0, -- docked to
		2, -- flags
		ColourNameToRGB "#343434")
	
	WindowLoadImage(win, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	
	WindowDrawImage(win, "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	WindowDrawImageAlpha(win, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	WindowFont(win, "f", GetInfo(20), GetInfo(243) + FONT_SIZE_OFFSET)
	
	WindowShow(win, true)
	WindowShow(win2, true)
end

function OnPluginDisable() -- ()
	WindowShow(win,  false)
	WindowShow(win2, false)
end

--|————————————————————————————————————————————————————————————————————————————————————————|
--| CALLS
--|————————————————————————————————————————————————————————————————————————————————————————|

DoAfterSpecial(1, "Setup()", 12)