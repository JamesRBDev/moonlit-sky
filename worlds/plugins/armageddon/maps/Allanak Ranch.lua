local LANDMARKS     = {
	
}

local PORTS         = {
	
}

local PORT_COMMANDS = {
	["Leave"]       = {
		["1,2"]     = {"Southlands",          26, 9};
	};
}

local MAPS          = {
	--0                            1                            2                            3                            
	{ " ";                         "34/0/3/1";                  "34/0/1/3";                  " ";                          }; -- 0
	{ "34/0/3";                    "31";                        "31";                        "31/1/0/2";                   }; -- 1
	{ "34/3";                      "31/2/65";                   "31/2";                      "31/2/1/0";                   }; -- 2
}

----------------------------------------

return PORTS, PORT_COMMANDS, MAPS, LANDMARKS