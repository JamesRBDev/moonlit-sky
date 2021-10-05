--|————————————————————————————————————————————————————————————————————————————————————————|
--| DESCRIPTION
--|————————————————————————————————————————————————————————————————————————————————————————|

-- Contributors: RiftTalon

--[[
Handles the core framework of the Moonlit Sky Armageddon plugin suite.
--]]

--|————————————————————————————————————————————————————————————————————————————————————————|
--| SETTINGS
--|————————————————————————————————————————————————————————————————————————————————————————|

-- The displayed client version.
local VERSION    = "v3.0"

-- List of help topics.
local TOPIC_LIST = [[
<< CORE >>
mshelp <topic>
msversion
armasetup
toggletips

<< UTILITY >>
qtake <item> <container>
qput <item> <container>
qpsi <target> <message>
grip <hand1> <hand2>
switchgrip
lookall
look all
lall
l all
openlook <container>
qlookin <container>
qslip <item> <container>
qpalm <item> <container>
ass <entity>
cook <items> into <item>
afk <message>
stats
place <item> <container>
mine <deposit>
buywater <container>
multibuy <amount> <item>
stealth
grab <item> <container>
pickup <item> <container>
pick up <item> <container>
equip <item> <location>
info <target>
attributes
twogrip
autoforage <off/item>

<< COMBAT >>
qshoot <target> <direction>
cshoot <target> <direction>
qthrow <item> <target> <direction>
attack <target>
spar <target>
nospar
target <target>

<< SOCIAL >>
deepbow <target>
pose <ldesc>
ldesc <ldesc>
flipoff <target>
salute
glanceroom
smirk
snicker
hum
throwdart
reliefsigh
giggle
flex
dab
furiousdab
grunt
diphead
wake up
stand up
nervous
glance <entity>
language <language>
accent <accent>
mood <mood>

<< MINIMAP >>
map <map>
shift <direction>
setgrid <x> <y>
printgrid
togglemapping
maplist
printmap
copymap
tile <symbol> <x> <y>
ctile <x> <y>
atile
palette
importmap <map>
maptoken <token>
tokenlist
addrows <number> <position>
addcolumns <number> <position>
makemoves

<< NAMES >>
addname <sdesc> as <name>
listnames
removename <index>

<< INFO >>
emoting
]]

-- Information for each individual topic.
local TOPIC_INFO = {
	["mshelp"] = [[
	CORE: mshelp <topic>
	----------------------------------------------------------------
	Outputs information on a command, or if <topic> is blank; a list
	of commands.
	]];

	["msversion"] = [[
	CORE: msversion
	----------------------------------------------------------------
	Outputs the current Moonlit Sky version
	]];

	["armasetup"] = [[
	CORE: armasetup
	----------------------------------------------------------------
	Use this after entering the world on a new character. It sets up
	the output and infobar.
	]];

	["toggletips"] = [[
	CORE: toggletips
	----------------------------------------------------------------
	Toggles the display of tutorial messages and tips.
	]];

	["qtake"] = [[
	UTILITY: qtake <item> <container>
	----------------------------------------------------------------
	Opens <container>, takes <item>, and then closes <container>.
	]];

	["qput"] = [[
	UTILITY: qput <item> <container>
	----------------------------------------------------------------
	Opens <container>, puts <item>, and then closes <container>.
	]];

	["qpsi"] = [[
	UTILITY: qpsi <target> <message>
	----------------------------------------------------------------
	Contacts the <target>, sends them the telepathic <message>, and
	then ceases contact.
	]];

	["grip"] = [[
	UTILITY: grip <hand1> <hand2>
	----------------------------------------------------------------
	Switches an item from <hand1> to <hand2> or from one hand
	to both.
	]];

	["switchgrip"] = [[
	UTILITY: switchgrip
	----------------------------------------------------------------
	Switches which hands your weapons are in.
	]];

	["lookall"] = [[
	UTILITY: lookall
	----------------------------------------------------------------
	Looks in every direction.
	]];

	["look all"] = [[
	UTILITY: look all
	----------------------------------------------------------------
	Looks in every direction.
	]];

	["lall"] = [[
	UTILITY: lall
	----------------------------------------------------------------
	Looks in every direction.
	]];

	["l all"] = [[
	UTILITY: l all
	----------------------------------------------------------------
	Looks in every direction.
	]];

	["openlook"] = [[
	UTILITY: openlook <container>
	----------------------------------------------------------------
	Opens and looks into a container
	]];

	["qlookin"] = [[
	UTILITY: qlookin <container>
	----------------------------------------------------------------
	Opens a container, looks in it, and then closes it.
	]];

	["qslip"] = [[
	UTILITY: qslip <item> <container>
	----------------------------------------------------------------
	Unlatches a container, slips item into it, and relatches.
	]];

	["qpalm"] = [[
	UTILITY: qpalm <item> <container>
	----------------------------------------------------------------
	Unlatches a container, palms item out of it, and relatches.
	]];

	["ass"] = [[
	UTILITY: ass <entity>
	----------------------------------------------------------------
	Shortened version of "assess."
	]];

	["afk"] = [[
	UTILITY: afk <message>
	----------------------------------------------------------------
	Sets yourself as AFK to everyone, and alerts admins. A <message>
	should be included with information.
	]];

	["cook"] = [[
	UTILITY: cook <items> into <item>
	----------------------------------------------------------------
	Alternative command for `craft`.
	]];

	["stats"] = [[
	UTILITY: stats
	----------------------------------------------------------------
	Alternative command for `stat`.
	]];

	["place"] = [[
	UTILITY: place <item> <container>
	----------------------------------------------------------------
	Alternative command for `put`.
	]];

	["mine"] = [[
	UTILITY: mine <deposit>
	----------------------------------------------------------------
	Shorthand for `use pickaxe <deposit>`.
	]];

	["discard"] = [[
	UTILITY: discard <item>
	----------------------------------------------------------------
	Alternative to `junk <item>`.
	]];

	["buywater"] = [[
	UTILITY: buywater <container>
	----------------------------------------------------------------
	Purchases water from a templar, filling <container>.
	]];

	["multibuy"] = [[
	UTILITY: multibuy <amount> <item>
	----------------------------------------------------------------
	Buys multiple of an item from an NPC vendor.
	]];

	["stealth"] = [[
	UTILITY: stealth
	----------------------------------------------------------------
	Activates both sneaking and hiding.
	]];

	["grab"] = [[
	UTILITY: grab <item> <container>
	----------------------------------------------------------------
	Alternative to `take`.
	]];

	["pickup"] = [[
	UTILITY: pickup <item> <container>
	----------------------------------------------------------------
	Alternative to `take`.
	]];

	["pick up"] = [[
	UTILITY: pick up <item> <container>
	----------------------------------------------------------------
	Alternative to `take`.
	]];

	["equip"] = [[
	UTILITY: equip <item> <location>
	----------------------------------------------------------------
	Alternative to `wear`.
	]];

	["info"] = [[
	UTILITY: info <target>
	----------------------------------------------------------------
	Alternative to `assess -v <target>`. Like assess, but gives
	extra information.
	]];

	["attributes"] = [[
	UTILITY: attributes
	----------------------------------------------------------------
	Alternative to `score`
	]];

	["twogrip"] = [[
	UTILITY: twogrip
	----------------------------------------------------------------
	Grips your primary weapon in both hands.
	]];

	["autoforage"] = [[
	UTILITY: autoforage <off/item>
	----------------------------------------------------------------
	Automatically repeats foraging for <item>. Turn off with
	`autoforage off`
	]];

	["qshoot"] = [[
	COMBAT: qshoot <target> <direction>
	----------------------------------------------------------------
	Pulls an arrow from your quiver and then shoots <target>
	in <direction>.
	]];

	["cshoot"] = [[
	COMBAT: cshoot <target> <direction>
	----------------------------------------------------------------
	Pulls a bolt from your quiver, loads, and then shoots <target>
	in <direction>.
	]];

	["qthrow"] = [[
	COMBAT: qthrow <item> <target> <direction>
	----------------------------------------------------------------
	Holds <item>, throws it at <target> in <direction>.
	]];

	["charge"] = [[
	COMBAT: charge <direction> <target>
	----------------------------------------------------------------
	Activates running, plays an emote, moves you in <direction>, and
	attacks the <target>.
	]];

	["attack"] = [[
	COMBAT: attack <target>
	----------------------------------------------------------------
	Alternative to the `kill` command.
	]];

	["spar"] = [[
	COMBAT: spar <target>
	----------------------------------------------------------------
	Turns on mercy and then attacks a <target>.
	]];

	["nospar"] = [[
	COMBAT: nospar
	----------------------------------------------------------------
	Runs `stop`, `disengage`, and then turns off mercy.
	]];

	["target"] = [[
	COMBAT: target <target>
	----------------------------------------------------------------
	Shorthand for `change opponent <target>`
	]];

	["deepbow"] = [[
	SOCIAL: deepbow <target>
	----------------------------------------------------------------
	Bows deeply before <target>.
	]];

	["pose"] = [[
	SOCIAL: pose <ldesc>
	----------------------------------------------------------------
	Changes your long description.
	]];

	["ldesc"] = [[
	SOCIAL: ldesc <ldesc>
	----------------------------------------------------------------
	Changes your long description.
	]];

	["flipoff"] = [[
	SOCIAL: flipoff <target>
	----------------------------------------------------------------
	Flips off the <target>.
	]];

	["salute"] = [[
	SOCIAL: salute
	----------------------------------------------------------------
	Raise your fist in salute. Generally used for the T'Zai Byn.
	]];

	["glanceroom"] = [[
	SOCIAL: glanceroom
	----------------------------------------------------------------
	You glance around the room.
	]];

	["smirk"] = [[
	SOCIAL: smirk
	----------------------------------------------------------------
	You smirk.
	]];

	["snicker"] = [[
	SOCIAL: snicker
	----------------------------------------------------------------
	You snicker.
	]];

	["hum"] = [[
	SOCIAL: hum
	----------------------------------------------------------------
	You hum a short melody.
	]];

	["throwdart"] = [[
	SOCIAL: throwdart
	----------------------------------------------------------------
	Holds a dart, throws it at a dartboard.
	]];

	["reliefsigh"] = [[
	SOCIAL: reliefsigh
	----------------------------------------------------------------
	Sigh in relief.
	]];

	["giggle"] = [[
	SOCIAL: giggle
	----------------------------------------------------------------
	You giggle.
	]];

	["flex"] = [[
	SOCIAL: flex
	----------------------------------------------------------------
	Show off your masculinity.
	]];

	["dab"] = [[
	SOCIAL: dab
	----------------------------------------------------------------
	Dabs. Totally immersion-breaking and probably against the rules.
	]];

	["furiousdab"] = [[
	SOCIAL: furiousdab
	----------------------------------------------------------------
	USE AT YOUR OWN RISK.
	]];

	["grunt"] = [[
	SOCIAL: grunt
	----------------------------------------------------------------
	You let out a grunt.
	]];

	["diphead"] = [[
	SOCIAL: diphead
	----------------------------------------------------------------
	You dip your head.
	]];

	["wake up"] = [[
	SOCIAL: wake up
	----------------------------------------------------------------
	Wakes you up.
	]];

	["stand up"] = [[
	SOCIAL: stand up
	----------------------------------------------------------------
	Makes you stand up.
	]];

	["nervous"] = [[
	SOCIAL: nervous
	----------------------------------------------------------------
	Hidden emote where your eyes dart and your breathing
	becomes rapid.
	]];

	["glance"] = [[
	SOCIAL: glance <entity>
	----------------------------------------------------------------
	Silent emote where you glance at someone or something.
	]];

	["language"] = [[
	SOCIAL: language <language>
	----------------------------------------------------------------
	Shortened version of "change language".
	]];

	["accent"] = [[
	SOCIAL: accent <accent>
	----------------------------------------------------------------
	Shortened version of "change accent".
	]];

	["mood"] = [[
	SOCIAL: mood <mood>
	----------------------------------------------------------------
	Shortened version of "change mood".
	]];

	["blink"] = [[
	SOCIAL: blink
	----------------------------------------------------------------
	Shorthand for "emote blinks."
	]];

	["map"] = [[
	MINIMAP: map <map>
	----------------------------------------------------------------
	Sets the currently displayed map.
	]];

	["shift"] = [[
	MINIMAP: shift <direction>
	----------------------------------------------------------------
	Shifts your position on the map in <direction>.
	]];

	["setgrid"] = [[
	MINIMAP: setgrid <x> <y>
	----------------------------------------------------------------
	Sets your position on the map grid.
	]];

	["printgrid"] = [[
	MINIMAP: printgrid
	----------------------------------------------------------------
	Prints your current position on the map grid.
	]];

	["togglemapping"] = [[
	MINIMAP: togglemapping
	----------------------------------------------------------------
	Toggles whether or not to pause position changes on the map.
	]];

	["maplist"] = [[
	MINIMAP: maplist
	----------------------------------------------------------------
	Lists all of the available map displays to be used with the
	`map` command.
	]];

	["printmap"] = [[
	MINIMAP: printmap
	----------------------------------------------------------------
	Prints out the code for the current map.
	This function is used for map modifications and debugging.
	]];

	["copymap"] = [[
	MINIMAP: copymap
	----------------------------------------------------------------
	Copies the code for the current map to the clipboard.
	This function is used for map modifications and debugging.
	]];

	["maptoken"] = [[
	MINIMAP: maptoken <token>
	----------------------------------------------------------------
	Sets your token on the minimap to the specified image. The name
	of the token is case-sensitive.
	]];

	["tokenlist"] = [[
	MINIMAP: tokenlist
	----------------------------------------------------------------
	Lists all of the available map tokens. Images are stored in
	MUSHClient/worlds/plugins/Armageddon/Images/Tokens
	]];

	["tile"] = [[
	MINIMAP: tile <symbol> <x> <y>
	----------------------------------------------------------------
	Adds a tile to the map. The tile itself is determined by its
	<symbol> representative. <x> and <y> are the position. If left
	empty, it defaults to your current position.
	This function is used for map modifications and debugging.
	]];

	["ctile"] = [[
	MINIMAP: ctile <x> <y>
	----------------------------------------------------------------
	Removes a tile from the map. <x> and <y> are the position.
	If left empty, it defaults to your current position.
	This function is used for map modifications and debugging.
	]];

	["atile"] = [[
	MINIMAP: atile
	----------------------------------------------------------------
	Automatically populates the current tile. Only works in the
	wilderness and outside of cities.
	]];

	["palette"] = [[
	MINIMAP: palette
	----------------------------------------------------------------
	Toggles the map tile palette.
	]];

	["importmap"] = [[
	MINIMAP: importmap <map>
	----------------------------------------------------------------
	Imports or refreshes a map.
	]];

	["addrows"] = [[
	MINIMAP: addrows <number> <position>
	----------------------------------------------------------------
	Adds the specified <number> of rows to the current map, the
	<position> of which can be either "start" or "end".

	Example: addrows 4 start
	]];

	["addcolumns"] = [[
	MINIMAP: addcolumns <number> <position>
	----------------------------------------------------------------
	Adds the specified <number> of columns to the current map, the
	<position> of which can be either "start" or "end".

	Example: addcolumns 4 start
	]];

	["makemoves"] = [[
	MINIMAP: makemoves
	----------------------------------------------------------------
	Automatically carries out all queued movements on the minimap.
	]];

	["addname"] = [[
	NAMES: addname <sdesc> as <name>
	----------------------------------------------------------------
	Replaces <sdesc> with <name>.
	]];

	["listnames"] = [[
	NAMES: listnames
	----------------------------------------------------------------
	Lists all of your set names.
	]];

	["removename"] = [[
	NAMES: removename <index>
	----------------------------------------------------------------
	Removes the previously-set name.
	Set <index> as the number of that name in the listnames list.
	]];

	["emoting"] = [[
	INFO: emoting
	----------------------------------------------------------------
	Emote:  Normal emote.
	HEmote: Only visible to people paying attention.
	SEmote: Silent emote, people have to see you.

	Using emotes in non-emote commands:
	<command> (pre-emote) <arguments> [post-emote]

	Example: eat (salivating) meat [and is overwhelmed by its flavor]
	Result: Salivating, the young, muscular man takes a bite of meat,
	and is overwhelemed by its flavor.

	Symbol    Reference         Target Sees
	------    ---------         -----------
	  ~       (sdesc)           you
	  !       him/her           you
	  %       (sdesc)'s         your
	  ^       his/her           your
	  #       he/she            you
	  &       himself/herself   yourself
	  =       (sdesc)'s         yours
	  +       his/hers          yours
	  
	Example: emote glances at ~tall
	Result:  The young, muscular man glances at the tall, scarred man.
	]];
}

--|————————————————————————————————————————————————————————————————————————————————————————|
--| VARIABLES
--|————————————————————————————————————————————————————————————————————————————————————————|



--|————————————————————————————————————————————————————————————————————————————————————————|
--| FUNCTIONS
--|————————————————————————————————————————————————————————————————————————————————————————|

function OnHelp(name, line, wildcards) -- (string, number, table)
	-- Handles help topics.
	
	local foundTopic = false
	
	if wildcards then
		local topic = wildcards[1]
		
		-- Remove whitespace from text capture.
		if topic then
			topic = string.gsub(topic, " ", "")
		end

		if TOPIC_INFO[topic] then
			-- Output a topic's information.
			Note("")
			Note(TOPIC_INFO[topic])
			Note("")
			foundTopic = true
		end
	end
	
	if not foundTopic then
		-- Output the list of topics.
		Note("")
		Note(TOPIC_LIST)
		Note("")
	end
end

function Tip(message) -- (string)
	-- TODO: Check if tips are enabled.
	Note(message)
end

function GetVersion() -- ()
	-- Returns the current core version.
	
	return VERSION
end

function Setup() -- ()
	-- Applies the theme.
	
	local wSize   = math.max(580, 19 + (GetInfo(213) * 80))
	local hSize   = math.min(GetInfo(280), 800)
	local wCenter = GetInfo(250) / 2
	local hCenter = GetInfo(280) / 2
	win           = GetPluginID()
	win2          = GetPluginID().."1"
	win3          = GetPluginID().."2"
	
	WindowCreate(win2,
		0, 0, 600, 1080, -- pos/size
		4, -- docked to
		5, -- flags
		ColourNameToRGB "black")
		
	WindowCreate(win3,
		0, 0, 600, 1080, -- pos/size
		6, -- docked to
		5, -- flags
		ColourNameToRGB "black")
		
	WindowLoadImage(     win2, "adornment", "worlds/plugins/Armageddon/Images/background_adornment.png" )
	WindowDrawImageAlpha(win2, "adornment", 0, 0, 600, 1080, 0.5, 0, 0)
	WindowLoadImage(     win3, "adornment", "worlds/plugins/Armageddon/Images/background_adornment2.png")
	WindowDrawImageAlpha(win3, "adornment", 0, 0, 600, 1080, 0.5, 0, 0)
	
	TextRectangle((wCenter - wSize) + 6,   -- left
		(hCenter - (hSize / 2)) + 6,  -- top
		wCenter - 12, -- 50 + width for 80 characters
		-(hCenter - (hSize / 2)) - 6,  -- 100 pixels from the bottom
		0,  -- BorderOffset, 
		ColourNameToRGB ("#111111"),    -- BorderColour, 
		0,  -- BorderWidth, 
		ColourNameToRGB ("#000000"),  -- OutsideFillColour, 
		8) -- OutsideFillStyle (fine hatch)
	
	WindowCreate(win,
		(wCenter - wSize), (hCenter - (hSize / 2)), wSize, hSize, -- pos/size
		0, -- docked to
		3, -- flags
		ColourNameToRGB "#343434")
		
	WindowSetZOrder(win, 10)
	
	WindowLoadImage(win,  "corners",    "worlds/plugins/Armageddon/Images/arma_corners.png"          )
	WindowLoadImage(win,  "background", "worlds/plugins/Armageddon/Images/arma_window_background.png")
	WindowDrawImage(win,  "background", 2, 2, wSize - 2, hSize - 2, 2, 0, 0, 0, 0)
	
	SetBackgroundImage("worlds/plugins/Armageddon/Images/arma_background.png", 0)
	
	WindowDrawImageAlpha(win, "corners", 0,          0,          16,    16,    1,  0,  0 )
	WindowDrawImageAlpha(win, "corners", wSize - 16, 0,          wSize, 16,    1,  16, 0 )
	WindowDrawImageAlpha(win, "corners", 0,          hSize - 16, 16,    hSize, 1,  0,  16)
	WindowDrawImageAlpha(win, "corners", wSize - 16, hSize - 16, wSize, hSize, 1,  16, 16)
	
	--SetScroll (-2,  false)
	WindowShow(win2, true)
	WindowShow(win3, true)
	WindowShow(win,  true)
	
	Note("")
	Note("Press ENTER to connect to Armageddon.")
	Note("")
end

function OnPluginDisable() -- ()
	-- Hides the windows.
	
	WindowShow(win,  false)
	WindowShow(win2, false)
	--SetScroll (-2,   true )
end

--|————————————————————————————————————————————————————————————————————————————————————————|
--| CALLS
--|————————————————————————————————————————————————————————————————————————————————————————|

DoAfterSpecial(1, "Setup()", 12)