local function update_round(P)
	if #players.alive>1 then
		P.control=false
		local ID=P.id
		repeat
			ID=ID+1
			if not players[ID]then ID=1 end
		until players[ID].alive or ID==P.id
		players[ID].control=true
	end
end

return{
	name={
		"回合制",
		"回合制",
		"Turn-Based",
	},
	level={
		"简单",
		"简单",
		"EASY",
	},
	info={
		"下棋模式",
		"下棋模式",
		"Chess?",
	},
	color=color.cyan,
	env={
		drop=1e99,lock=1e99,
		oncehold=false,
		dropPiece=update_round,
		bg="game2",bgm="push",
	},
	load=function()
		newPlayer(1,340,15)
		newPlayer(2,965,360,.5,AITemplate("9S",10))
	end,
	mesDisp=function(P,dx,dy)
	end,
	score=function(P)return{P.stat.piece,P.stat.time}end,
	scoreDisp=function(D)return D[1].." Pieces   "..toTime(D[2])end,
	comp=function(a,b)return a[1]<b[1]or a[1]==b[1]and a[2]<b[2]end,
	getRank=function(P)
		if P.result=="WIN"then
			local T=P.stat.piece
			return
			T<=23 and 5 or
			T<=26 and 4 or
			T<=40 and 3 or
			T<=60 and 2 or
			1
		end
	end,
}