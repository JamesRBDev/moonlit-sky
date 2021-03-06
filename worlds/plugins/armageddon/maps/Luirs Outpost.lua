local LANDMARKS     = {
	
}

local PORTS         = {
	["7,6"]         = {"Luirs Outpost",       7,  21};
	["7,22"]        = {"Luirs Outpost",       7,  7};
	["6,21"]        = {"Luirs Outpost",       6,  6};
	["3,13"]        = {"Red Desert",          12, 4};
}

local PORT_COMMANDS = {
	["North"]       = {
		["0,5"]     = {"Luirs Outpost",       0,  3};
		["0,12"]    = {"Luirs Outpost",       0,  9};
	};
	["South"]       = {
		["0,3"]     = {"Luirs Outpost",       0,  5};
		["0,9"]     = {"Luirs Outpost",       0,  12};
	};
	["East"]        = {
		["3,11"]    = {"Luirs Outpost",       5,  11};
		["8,7"]     = {"Luirs Outpost",       10, 7};
	};
	["West"]        = {
		["5,11"]    = {"Luirs Outpost",       3,  11};
		["10,7"]    = {"Luirs Outpost",       8,  7};
	};
	["Up"]          = {
		["7,20"]    = {"Luirs Outpost",       12, 17};
	};
	["Down"]        = {
		["12,17"]   = {"Luirs Outpost",       7,  20};
	};
}

local MAPS          = {
	--0                            1                            2                            3                            4                            5                            6                            7                            8                            9                            10                           11                           12                           13                           14                           15                           
	{ " ";                         "21/2/3/17";                 "21/2/0/17";                 "21/1/17";                   " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 0
	{ " ";                         " ";                         " ";                         "21/1/3/17";                 " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 1
	{ " ";                         " ";                         "29/0/3/2/17";               "21/1/12/17";                " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 2
	{ "24/3/0/12";                 "24/0/2";                    "24/2/0/42";                 "24/2/1/91/10";              " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 3
	{ "24/3/1/10/12/17";           " ";                         "20/0/3/9";                  "20/0";                      "20/0/2";                    "20/0";                      "20/0/2";                    "20/0/2";                    "20/0/1/9";                  " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 4
	{ "24/3/1/10";                 "30/0/3/2/75/9";             "20/1";                      "34/3/2/1";                  "34/0/1/3";                  "34/2/1/3";                  " ";                         "34/4/6/9/17/1";             "20/1/3";                    " ";                         " ";                         "20/0/3";                    "20/2/0";                    "20/2/0";                    "20/2/0";                    "20/0/1";                     }; -- 5
	{ "24/3";                      "24/1/0/41";                 "20/3";                      "31/0/1/83";                 "34/1/3/48";                 "34/0/1/3";                  "20/0/3/61/11";              "34/50/9/14/13/12/17/7";     "20/1/3";                    " ";                         " ";                         "20/3/11";                   "13";                        " ";                         " ";                         "20/3/1";                     }; -- 6
	{ "24/3/63";                   "24";                        "20";                        "20";                        "20";                        "20";                        "20";                        "20/10";                     "20/11";                     "20/0/2/11/13/17";           "20/0/2/13";                 "20";                        "20/0";                      "20/0";                      "20/0";                      "20/2/1";                     }; -- 7
	{ "24/3";                      "24/1/2/41";                 "20/3/1";                    "31/1/3/64";                 "21/3/51";                   "21/72";                     "21/48";                     "21/1/49";                   "20/1/3";                    " ";                         "11";                        "20/13";                     "35/12";                     "35/80/12";                  "35/52/12";                  "35/0/1/12";                  }; -- 8
	{ "24/3/1/12";                 " ";                         "20/3/1";                    "31/1/3/2/46";               "21/3/72";                   "21";                        "21/40";                     "21/1/40";                   "20/1/3";                    " ";                         "11";                        "20/13/1";                   "10";                        "10";                        "10";                        "10";                         }; -- 9
	{ "24/3/1/10/17";              " ";                         "20/3/1";                    "21/2/0/3/42";               "21/2/40";                   "21/2/40";                   "21/40";                     "21/2/1/40";                 "20/1/3";                    " ";                         " ";                         "20/3/1";                    " ";                         " ";                         " ";                         " ";                          }; -- 10
	{ "24/3/12/17";                " ";                         "20/2/3/9";                  "20/0/2/11";                 "20/0/2/11/13/17";           "20/0/2/13";                 "20/12";                     "20/0";                      "20/2/9";                    "31/0/2/83";                 "31/0/2/1/83";               "35/3/1";                    " ";                         " ";                         " ";                         " ";                          }; -- 11
	{ "24/3/2/10";                 "24/2/0";                    "24/0/2";                    "24/0/1/91/12";              " ";                         " ";                         "10";                        "20/3/2/7/45";               " ";                         " ";                         " ";                         "35/1/3";                    " ";                         " ";                         " ";                         " ";                          }; -- 12
	{ "32/4/17";                   "21/4/17";                   "21/0/17";                   "21/10/17";                  "32/0/17";                   "26/0/17";                   "26/0/17";                   " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 13
	{ "32/17";                     "32/2/17";                   "32/17";                     "32/2/17";                   "32/17";                     "26/17";                     "26/17";                     " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 14
	{ "26/1/17";                   " ";                         "29/1/3/17";                 " ";                         "26/3/17";                   "26/17";                     "26/17";                     " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 15
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "34/1/3/0/70";               " ";                         " ";                         " ";                          }; -- 16
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "34/1/3/8/14";               " ";                         " ";                         " ";                          }; -- 17
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "34/1/3/2/70";               " ";                         " ";                         " ";                          }; -- 18
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "34/0/3/1";                  " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 19
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "11";                        "34/1/9/13";                 " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 20
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "20/11/3/0/61/17";           "34/50/14/12/13/11";         "13";                        " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 21
	{ " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         "20/17";                     "20/10/17";                  "20/17";                     " ";                         " ";                         " ";                         " ";                         " ";                         " ";                         " ";                          }; -- 22
}

----------------------------------------

return PORTS, PORT_COMMANDS, MAPS, LANDMARKS