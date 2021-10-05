--|————————————————————————————————————————————————————————————————————————————————————————|
--| DESCRIPTION
--|————————————————————————————————————————————————————————————————————————————————————————|

-- Contributors: RiftTalon

--[[
Handles custom sdesc to name replacements.
--]]

--|————————————————————————————————————————————————————————————————————————————————————————|
--| SETTINGS
--|————————————————————————————————————————————————————————————————————————————————————————|



--|————————————————————————————————————————————————————————————————————————————————————————|
--| VARIABLES
--|————————————————————————————————————————————————————————————————————————————————————————|

local loaded = false
local names  = {}

local last

--|————————————————————————————————————————————————————————————————————————————————————————|
--| FUNCTIONS
--|————————————————————————————————————————————————————————————————————————————————————————|

function ClearLast() -- ()
	-- Clears the "last" variable.
	
	last = nil
end

function NameMatch(sdesc, name) -- (string, string)
	-- Matches on a name.
	
	for k, v in ipairs(TriggerStyleRuns) do
		if v.text:lower() ~= last and string.sub(v.text, 1, 6) ~= "PROMPT" then
			last       = v.text:lower()
			local text = string.gsub(v.text:lower(), "-", "_")
			
			for i, info in ipairs(names) do
				text = string.gsub(text, string.gsub(info[1], "-", "_"), string.gsub(info[2], "SPC", " "))
				text = string.gsub(text, string.gsub(info[1], "-", "_"), info[2])
			end
			
			text = string.gsub(text, "_", "-")
			text = text:sub(1, 1):upper() .. text:sub(2, #text)
			
			ColourTell(RGBColourToName(v.textcolour), RGBColourToName(v.backcolour), text)
			DoAfterSpecial(0.1, "ClearLast()", 12)
		end
	end
end

function AddName(sdesc, name) -- (string, string)
	-- Adds a name.
	
	sdesc            = sdesc:lower()
	local sdesc2     = string.gsub(sdesc, "-", "_")
	name             = string.gsub(name, " ", "SPC")
	local scriptText = 'NameMatch("'..sdesc2..'", "'..name..'")'
	
	AddTriggerEx(name, sdesc, scriptText, 61, custom_colour.NoChange, 0, "", "", 14, 100)
	
	table.insert(names, {sdesc, name})
	
	if loaded then
		SaveNames()
		Note("["..sdesc.."] will now be known as ["..string.gsub(name, "SPC", " ").."]")
	end
end

function SaveNames() -- ()
	-- Saves all names.
	
	local saveData = ""
	
	for i, info in ipairs(names) do
		saveData = saveData.."({"..info[1].."}{"..info[2].."})"
	end
	
	SetVariable("names", saveData)
	Save("")
end

function LoadNames() -- ()
	-- Loads all names.
	
	if GetVariable("names") then
		for word in string.gmatch(GetVariable("names"), "%b()") do
			local sdesc, name
			
			for word2 in string.gmatch(word, "%b{}") do
				word2 = string.gsub(word2, "{", "")
				word2 = string.gsub(word2, "}", "")
				
				if not sdesc then
					sdesc = word2
				else
					name = word2
				end
			end
			
			AddName(sdesc, name)
		end
	end
	
	loaded = true
end

function ListNames() -- ()
	-- Lists names.
	
	if #names > 0 then
		Note("")
		for i, info in ipairs(names) do
			Note(i..") "..info[1].." : "..string.gsub(info[2], "SPC", " "))
		end
		Note("")
	else
		Note("No names found")
	end
end

function RemoveName(index) -- ()
	-- Removes a name.
	
	if names[index] then
		DeleteTrigger(names[index][2])
		table.remove(names, index)
		SaveNames()
		Note("Removed name #"..index)
	else
		Note("Name #"..index.." not found.")
	end
end

--|————————————————————————————————————————————————————————————————————————————————————————|
--| CALLS
--|————————————————————————————————————————————————————————————————————————————————————————|

LoadNames()