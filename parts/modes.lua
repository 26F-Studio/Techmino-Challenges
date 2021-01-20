return{
	{name="sprint_10l",		x=0,	y=0,	size=35,shape=1,icon="sprint",	unlock={"sprint_20l","sprint_40l"}},
	{name="sprint_20l",		x=-200,	y=0,	size=45,shape=1,icon="sprint"},
	{name="sprint_40l",		x=0,	y=-300,	size=35,shape=1,icon="sprint",	unlock={"dig_10l","sprint_100l","marathon_n","sprintPenta","sprintMPH"}},
	{name="sprint_100l",	x=-200,	y=-200,	size=45,shape=1,icon="sprint",	unlock={"sprint_400l","drought_n"}},
	{name="sprint_400l",	x=-400,	y=-200,	size=35,shape=1,icon="sprint",	unlock={"sprint_1000l"}},
	{name="sprint_1000l",	x=-600,	y=-200,	size=35,shape=1,icon="sprint"},

	{name="sprintPenta",	x=210,	y=-370,	size=40,shape=3,icon="sprint"},
	{name="sprintMPH",		x=210,	y=-230,	size=40,shape=3,icon="sprint"},

	{name="drought_n",		x=-400,	y=0,	size=35,shape=1,icon="noI",		unlock={"drought_l"}},
	{name="drought_l",		x=-600,	y=0,	size=35,shape=1,icon="mess"},

	{name="dig_10l",		x=-200,	y=-400,	size=35,shape=1,icon="dig",		unlock={"dig_40l"}},
	{name="dig_40l",		x=-400,	y=-400,	size=35,shape=1,icon="dig",		unlock={"dig_100l"}},
	{name="dig_100l",		x=-600,	y=-400,	size=35,shape=1,icon="dig",		unlock={"dig_400l"}},
	{name="dig_400l",		x=-800,	y=-200,	size=35,shape=1,icon="dig"},

	{name="marathon_n",		x=0,	y=-600,	size=55,shape=1,icon="marathon",unlock={"marathon_h","solo_e","round_e","blind_e","classic_fast","survivor_e","bigbang","zen"}},
	{name="marathon_h",		x=0,	y=-800,	size=45,shape=1,icon="marathon",unlock={"master_beginner"}},

	{name="solo_e",			x=-300,	y=-1000,size=35,shape=1,icon="solo",	unlock={"solo_n"}},
	{name="solo_n",			x=-500,	y=-1000,size=35,shape=1,icon="solo",	unlock={"solo_h"}},
	{name="solo_h",			x=-700,	y=-1000,size=35,shape=1,icon="solo",	unlock={"solo_l","techmino49_e"}},
	{name="solo_l",			x=-900,	y=-1000,size=35,shape=1,icon="solo",	unlock={"solo_u"}},
	{name="solo_u",			x=-1100,y=-1000,size=35,shape=1,icon="solo"},

	{name="techmino49_e",	x=-900,	y=-1200,size=35,shape=1,icon="royale",	unlock={"techmino49_h","techmino99_e"}},
	{name="techmino49_h",	x=-900,	y=-1400,size=35,shape=1,icon="royale",	unlock={"techmino49_u"}},
	{name="techmino49_u",	x=-900,	y=-1600,size=35,shape=1,icon="royale"},
	{name="techmino99_e",	x=-1100,y=-1400,size=35,shape=1,icon="royale",	unlock={"techmino99_h"}},
	{name="techmino99_h",	x=-1100,y=-1600,size=35,shape=1,icon="royale",	unlock={"techmino99_u"}},
	{name="techmino99_u",	x=-1100,y=-1800,size=35,shape=1,icon="royale"},

	{name="round_e",		x=-300,	y=-800,	size=35,shape=1,icon="round",	unlock={"round_n"}},
	{name="round_n",		x=-500,	y=-800,	size=35,shape=1,icon="round",	unlock={"round_h"}},
	{name="round_h",		x=-700,	y=-800,	size=35,shape=1,icon="round",	unlock={"round_l"}},
	{name="round_l",		x=-900,	y=-800,	size=35,shape=1,icon="round",	unlock={"round_u"}},
	{name="round_u",		x=-1100,y=-800,	size=35,shape=1,icon="round"},

	{name="master_beginner",x=0,	y=-1000,size=35,shape=1,icon="master",	unlock={"master_advance"}},
	{name="master_advance",	x=0,	y=-1200,size=35,shape=3,icon="master",	unlock={"master_final","GM","master_phantasm"}},
	{name="master_final",	x=0,	y=-1600,size=40,shape=2,icon="master"},
	{name="master_phantasm",x=-150,	y=-1500,size=40,shape=2,icon="master"},
	{name="GM",				x=150,	y=-1500,size=35,shape=2,icon="master"},

	{name="blind_e",		x=150,	y=-700,	size=35,shape=1,icon="blind",	unlock={"blind_n"}},
	{name="blind_n",		x=150,	y=-800,	size=35,shape=1,icon="blind",	unlock={"blind_h"}},
	{name="blind_h",		x=150,	y=-900,	size=35,shape=1,icon="blind",	unlock={"blind_l"}},
	{name="blind_l",		x=150,	y=-1000,size=35,shape=3,icon="blind",	unlock={"blind_u"}},
	{name="blind_u",		x=150,	y=-1100,size=35,shape=3,icon="blind",	unlock={"blind_wtf"}},
	{name="blind_wtf",		x=150,	y=-1200,size=35,shape=2,icon="blind"},

	{name="classic_fast",	x=-300,	y=-1200,size=40,shape=2,icon="classic"},

	{name="survivor_e",		x=300,	y=-600,	size=35,shape=1,icon="survivor",unlock={"survivor_n"}},
	{name="survivor_n",		x=500,	y=-600,	size=35,shape=1,icon="survivor",unlock={"survivor_h","attacker_h","defender_n","dig_h"}},
	{name="survivor_h",		x=700,	y=-600,	size=35,shape=1,icon="survivor",unlock={"survivor_l"}},
	{name="survivor_l",		x=900,	y=-600,	size=35,shape=3,icon="survivor",unlock={"survivor_u"}},
	{name="survivor_u",		x=1100,	y=-600,	size=35,shape=2,icon="survivor"},

	{name="attacker_h",		x=300,	y=-800,	size=35,shape=1,icon="attacker",unlock={"attacker_u"}},
	{name="attacker_u",		x=300,	y=-1000,size=35,shape=1,icon="attacker"},

	{name="defender_n",		x=500,	y=-800,	size=35,shape=1,icon="defender",unlock={"defender_l"}},
	{name="defender_l",		x=500,	y=-1000,size=35,shape=1,icon="defender"},

	{name="dig_h",			x=700,	y=-800,	size=35,shape=1,icon="dig",		unlock={"dig_u"}},
	{name="dig_u",			x=700,	y=-1000,size=35,shape=1,icon="dig"},

	{name="bigbang",		x=400,	y=-400,	size=55,shape=1,icon="bigbang",	unlock={"c4wtrain_n","pctrain_n","tech_n"}},
	{name="c4wtrain_n",		x=700,	y=-400,	size=35,shape=1,icon="c4wtrain",unlock={"c4wtrain_l"}},
	{name="c4wtrain_l",		x=900,	y=-400,	size=35,shape=1,icon="c4wtrain"},

	{name="pctrain_n",		x=700,	y=-220,	size=35,shape=1,icon="pctrain",	unlock={"pctrain_l","pc_n"}},
	{name="pctrain_l",		x=900,	y=-220,	size=35,shape=1,icon="pctrain"},

	{name="pc_n",	x=800,	y=-100,	size=35,shape=1,icon="pc",		unlock={"pc_h"}},
	{name="pc_h",	x=1000,	y=-100,	size=35,shape=3,icon="pc",		unlock={"pc_l"}},
	{name="pc_l",	x=1200,	y=-100,	size=35,shape=2,icon="pc"},

	{name="tech_n",			x=400,	y=-150,	size=35,shape=1,icon="tech",	unlock={"tech_n_plus","tech_h","tech_finesse"}},
	{name="tech_n_plus",	x=650,	y=150,	size=35,shape=3,icon="tech",	unlock={"tsd_e"}},
	{name="tech_h",			x=400,	y=40,	size=35,shape=1,icon="tech",	unlock={"tech_h_plus","tech_l"}},
	{name="tech_h_plus",	x=200,	y=70,	size=35,shape=3,icon="tech"},
	{name="tech_l",			x=400,	y=200,	size=35,shape=1,icon="tech",	unlock={"tech_l_plus"}},
	{name="tech_l_plus",	x=200,	y=230,	size=35,shape=3,icon="tech"},

	{name="tech_finesse",	x=800,	y=50,	size=35,shape=1,icon="tech",	unlock={"tech_finesse_f"}},
	{name="tech_finesse_f",	x=1000,	y=50,	size=35,shape=1,icon="tech"},

	{name="tsd_e",			x=800,	y=250,	size=35,shape=1,icon="tsd",		unlock={"tsd_h"}},
	{name="tsd_h",			x=1000,	y=250,	size=35,shape=1,icon="tsd",		unlock={"tsd_u"}},
	{name="tsd_u",			x=1200,	y=250,	size=35,shape=1,icon="tsd"},

	{name="zen",			x=-800,	y=-600,	size=35,shape=1,icon="zen",		unlock={"ultra","infinite","infinite_dig"}},
	{name="ultra",			x=-1000,y=-400,	size=35,shape=1,icon="ultra"},
	{name="infinite",		x=-800,	y=-400,	size=35,shape=1,icon="infinite"},
	{name="infinite_dig",	x=-1000,y=-600,	size=35,shape=1,icon="infinite"},

	{name="sprintFix"},
	{name="sprintLock"},
	{name="marathon_bfmax"},

	{name="custom_puzzle"},
	{name="custom_clear"},
}