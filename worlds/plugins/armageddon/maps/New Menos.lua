local LANDMARKS     = {
	["Before the Gates of a Small Mining Village"] = {"New Menos", 3, 1};
}

local PORTS         = {
	
}

local PORT_COMMANDS = {
	["Leave"]       = {
		["3,1"]     = {"Southlands",          23, 14};
	};
}

local MAPS          = {
	--0                            1                            2                            3                            
	{ " ";                         "34/70/14/1/0/3";            "31/64/1/0/3";               " ";                          }; -- 0
	{ "20/0/2/3/7";                "20/2/6";                    "20";                        "20/91/0/2/1";                }; -- 1
	{ " ";                         " ";                         "26/3/1/5/8";                " ";                          }; -- 2
	{ " ";                         " ";                         "26/3/1/2/4";                " ";                          }; -- 3
}

----------------------------------------

return PORTS, PORT_COMMANDS, MAPS, LANDMARKS