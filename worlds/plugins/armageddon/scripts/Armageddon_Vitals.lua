--|————————————————————————————————————————————————————————————————————————————————————————|
--| DESCRIPTION
--|————————————————————————————————————————————————————————————————————————————————————————|

-- Contributors: RiftTalon

--[[
Handles the display of vitals.
--]]

--|————————————————————————————————————————————————————————————————————————————————————————|
--| SETTINGS
--|————————————————————————————————————————————————————————————————————————————————————————|

GAUGE_HEIGHT      = 16

WINDOW_WIDTH      = 320

WINDOW_HEIGHT     = 224

WINDOW_OFFSET     = 0

BACKGROUND_COLOUR = ColourNameToRGB("#343434")

--|————————————————————————————————————————————————————————————————————————————————————————|
--| VARIABLES
--|————————————————————————————————————————————————————————————————————————————————————————|



--|————————————————————————————————————————————————————————————————————————————————————————|
--| FUNCTIONS
--|————————————————————————————————————————————————————————————————————————————————————————|

function DoGauge (percent, color, index)
	local fraction = tonumber(percent)
	local wSize    = WINDOW_WIDTH
	local hSize    = GAUGE_HEIGHT + (WINDOW_HEIGHT - (GAUGE_HEIGHT * index)) + 6
	
	if wSize < 1 or wSize > WINDOW_WIDTH then wSize = 1 end
	
	if     fraction > 1 then fraction = 1
	elseif fraction < 0 then fraction = 0 end
	
	WindowRectOp(win, 2, 6, hSize - GAUGE_HEIGHT,     wSize + 6,              hSize,     BACKGROUND_COLOUR)
	WindowRectOp(win, 2, 7, hSize - GAUGE_HEIGHT + 1, (wSize + 5) * fraction, hSize - 1, color)
	
	WindowDrawImageAlpha(win, "vitalback", 7,     hSize - GAUGE_HEIGHT + 1, wSize + 5,  hSize - 1,                0.75, 0, 0)
	WindowDrawImageAlpha(win, "corners2",  6,     hSize - GAUGE_HEIGHT,     12,         hSize - GAUGE_HEIGHT + 6, 1,    0, 0)
	WindowDrawImageAlpha(win, "corners2",  wSize, hSize - GAUGE_HEIGHT,     wSize + 12, hSize - GAUGE_HEIGHT + 6, 1,    6, 0)
	WindowDrawImageAlpha(win, "corners2",  6,     hSize - 6,                12,         hSize,                    1,    0, 6)
	WindowDrawImageAlpha(win, "corners2",  wSize, hSize - 6,                wSize + 12, hSize,                    1,    6, 6)
end

function DoPrompt (name, line, wildcards)
	local wSize   = WINDOW_WIDTH  + 12
	local hSize   = WINDOW_HEIGHT + 12
	
	WindowLoadImage(win, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win, "corners2",   "worlds/plugins/Armageddon/Images/arma_corners_small.png"    )
	WindowLoadImage(win, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	WindowLoadImage(win, "vitalback",  "worlds/plugins/Armageddon/Images/arma_vitalback.png"        )
	
	WindowDrawImage(win, "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	WindowDrawImageAlpha(win, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	local hp, max_hp     = tonumber (wildcards [4]), tonumber (wildcards [5])
	local stam, max_stam = tonumber (wildcards [8]), tonumber (wildcards [9])
	local stun, max_stun = tonumber (wildcards [6]), tonumber (wildcards [7])
	local hp_percent     = hp / max_hp
	local stun_percent   = stun / max_stun
	local stam_percent   = stam / max_stam
	
	DoGauge(hp_percent,    ColourNameToRGB "#FF0000", 3)
	DoGauge(stam_percent,  ColourNameToRGB "#FFFF00", 2)
	DoGauge(stun_percent,  ColourNameToRGB "#00c5ff", 1)
	--DoGauge(mana_percent,  ColourNameToRGB "mediumblue", 1)
	
	WindowShow (win, true)
end


function Setup() -- ()
	win           = GetPluginID()
	local wCenter = GetInfo(250)  / 2
	local hCenter = GetInfo(280)  / 2
	local wSize   = WINDOW_WIDTH  + 12
	local hSize   = WINDOW_HEIGHT + 12
    
	-- make miniwindow
	WindowCreate(win, 
		wCenter + 174 + 62, (hCenter - 400) + WINDOW_OFFSET, wSize, hSize, -- pos/size
		0, -- docked to
		2, -- flags
		BACKGROUND_COLOUR)
	
	WindowLoadImage(win, "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win, "corners2",   "worlds/plugins/Armageddon/Images/arma_corners_small.png"    )
	WindowLoadImage(win, "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	WindowLoadImage(win, "vitalback",  "worlds/plugins/Armageddon/Images/arma_vitalback.png"        )
	
	WindowDrawImage(win, "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	WindowDrawImageAlpha(win, "corners", 0,           0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16,  0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,           hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16,  hSize - 16, wSize, hSize, 1,  16, 16)
	
	WindowShow(win, true)
end

function OnPluginDisable() -- ()
	WindowShow(win, false)
end

--|————————————————————————————————————————————————————————————————————————————————————————|
--| CALLS
--|————————————————————————————————————————————————————————————————————————————————————————|

DoAfterSpecial(1, "Setup()", 12)