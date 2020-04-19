local gc=love.graphics
local Timer=love.timer.getTime
local int,ceil,abs,rnd,max,min=math.floor,math.ceil,math.abs,math.random,math.max,math.min
local ins,rem=table.insert,table.remove
local format=string.format
local actName=actName--controllings' id
local scr=scr--screen camera
-------------------------<GameData>-------------------------
local gameEnv0={
	noFly=false,
	das=10,arr=2,
	sddas=2,sdarr=2,
	ihs=true,irs=true,ims=true,
	quickR=true,swap=true,
	ghost=true,center=true,
	smooth=false,grid=false,
	text=true,
	lockFX=3,dropFX=3,
	shakeFX=3,

	_20G=false,bone=false,
	drop=60,lock=60,
	wait=0,fall=0,
	next=6,hold=true,
	oncehold=true,
	ospin=true,
	sequence="bag7",
	face=NULL,
	skin=NULL,

	pushSpeed=3,
	block=true,
	visible="show",
	Fkey=NULL,puzzle=false,
	freshLimit=1e99,easyFresh=true,
	fine=false,fineKill=false,
	target=1e99,dropPiece=NULL,
	mindas=0,minarr=0,minsdarr=0,

	bg="none",bgm="race"
}
local comboAtk={0,0,1,1,2,2,3,3,4,4,3,2,3,2,3,2,3}--2 else
local b2bPoint={50,100,180}
local b2bATK={3,5,8}
local clearSCR={80,200,400}
local spinSCR={--[blockName][row]
	{200,750,1600},--Z
	{200,750,1600},--S
	{220,700,1600},--L
	{220,700,1600},--J
	{250,800,1500},--T
	{260,900,1800},--O
	{300,1200,1700},--I
}
--B2BMUL:1.2/2.0
--Techrash:1K;MUL:1.3/1.8
--Mini*=.6
local visible_opt={show=1e99,time=300,fast=20,none=0}
local reAtk={0,0,1,1,1,2,2,3,3}
local reDef={0,1,1,2,3,3,4,4,5}
local initCenterX={6,6,6,6,6,6.5,6.5}--1 added
local initCenterY={22,22,22,22,22,22.5,21.5}--1 added
local CCblockID={4,3,5,6,1,2,0}
local scs=require("parts/spinCenters")
local kickList=require("parts/kickList")
local finesseCtrlPar={
	[1]={
		{1,2,1,0,1,2,2,1},
		{2,2,2,1,1,2,3,2,2},
	},--Z
	[3]={
		{1,2,1,0,1,2,2,1},
		{2,2,3,2,1,2,3,3,2},
		{3,4,3,2,3,4,4,3},
		{2,3,2,1,2,3,3,2,2},
	},--L
	[6]={
		{1,2,2,1,0,1,2,2,1},
	},--O
	[7]={
		{1,2,1,0,1,2,1},
		{2,2,2,2,1,1,2,2,2,2},
	},--I
}--SZI逆态视为顺态
finesseCtrlPar[2]=finesseCtrlPar[1]--SZ算法相同
finesseCtrlPar[4]=finesseCtrlPar[3]--JLT算法相同
finesseCtrlPar[5]=finesseCtrlPar[3]--JLT算法相同
local CCblockID={4,3,5,6,1,2,0}
local freshPrepare={
	none=NULL,
	bag7=function(P)
		local bag={1,2,3,4,5,6,7}
		::L::P:getNext(rem(bag,rnd(#bag)))
		if bag[1]then goto L end
	end,
	his4=function(P)
		P.his={rnd(7),rnd(7),rnd(7),rnd(7)}
		for _=1,6 do
			local j,i=0
			repeat
				i=rnd(7)
				j=j+1
			until i~=P.his[1]and i~=P.his[2]and i~=P.his[3]and i~=P.his[4]or j==6
			P:getNext(i)
			rem(P.his,1)P.his[4]=i
		end
	end,
	rnd=function(P)
		P:getNext(rnd(7))
		for i=1,5 do
			local i
			::L::i=rnd(7)
			if i==P.next[#P.next].id then goto L end
			P:getNext(i)
		end
	end,
	drought1=function(P)
		local bag={1,2,3,3,4,4,5,5,6,6}
		::L::P:getNext(rem(bag,rnd(#bag)))
		if bag[1]then goto L end
	end,
	drought2=function(P)
		local bag={1,1,1,2,2,2,6,6,3,4,5,7}
		::L::P:getNext(rem(bag,rnd(#bag)))
		if bag[1]then goto L end
	end,
}
local freshMethod={
	none=NULL,
	bag7=function(P)
		if #P.next<6 then
			local bag={1,2,3,4,5,6,7}
			::L::P:getNext(rem(bag,rnd(#bag)))
			if bag[1]then goto L end
		end
	end,
	his4=function(P)
		if #P.next<6 then
			for n=1,4 do
				local j,i=0
				repeat
					i=rnd(7)
					j=j+1
				until i~=P.his[1]and i~=P.his[2]and i~=P.his[3]and i~=P.his[4]or j==4
				P:getNext(i)
				P.his[n]=i
			end
		end
	end,
	rnd=function(P)
		if #P.next<6 then
			for i=1,3 do
				local i
				::L::i=rnd(7)
				if i==P.next[#P.next].id then goto L end
				P:getNext(i)
			end
		end
	end,
	drought1=function(P)
		if #P.next<6 then
			local bag={1,2,3,4,5,6}
			::L::P:getNext(rem(bag,rnd(#bag)))
			if bag[1]then goto L end
		end
	end,
	drought2=function(P)
		if #P.next<6 then
			local i=rnd(18)
			P:getNext(
				i<=4 and 1 or
				i<=8 and 2 or
				i<=12 and 6 or
				i<=14 and 3 or
				i<=16 and 4 or
				i==17 and 5 or
				7
			)
		end
	end,
}
local spinName={"zspin","sspin","lspin","jspin","tspin","ospin","ispin"}
local clearName={"single","double","triple"}
local spin_n={[0]="spin_0","spin_1","spin_2","spin_3"}
local clear_n={"clear_1","clear_2","clear_3","clear_4"}
local ren_n={}for i=1,11 do ren_n[i]="ren_"..i end
-------------------------</GameData>------------------------

--------------------------<Pnt/Upd>-------------------------
local frameColor={
	[0]=color.white,
	color.lightGreen,
	color.lightBlue,
	color.lightPurple,
	color.lightOrange,
}
local attackColor={
	{color.darkGrey,color.white},
	{color.grey,color.white},
	{color.lightPurple,color.white},
	{color.lightRed,color.white},
	{color.darkGreen,color.cyan},
}
local function drawPixel(y,x,id)
	gc.draw(blockSkin[id],30*x-30,600-30*y)
end
local function drawDial(x,y,speed)
	gc.setColor(1,1,1)
	mStr(int(speed),x,y-18)
	gc.draw(IMG.dialCircle,x,y,nil,nil,nil,32,32)
	gc.setColor(1,1,1,.6)
	gc.draw(IMG.dialNeedle,x,y,2.094+(speed<=175 and .02094*speed or 4.712-52.36/(speed-125)),nil,nil,5,4)
end
local function Pdraw_norm(P)
	local curColor=P.cur.color
	local _
	gc.push("transform")
	gc.translate(P.x,P.y)gc.scale(P.size)
	--Camera
	gc.setColor(0,0,0,.6)gc.rectangle("fill",0,0,600,690)
	gc.setLineWidth(7)gc.setColor(frameColor[P.strength])gc.rectangle("line",0,0,600,690)
	--Boarder
	gc.translate(150+P.fieldOff.x,70+P.fieldOff.y)
	if P.gameEnv.grid then
		gc.setLineWidth(1)
		gc.setColor(1,1,1,.2)
		for x=1,9 do gc.line(30*x,-10,30*x,600)end
		for y=0,19 do
			y=30*(y-int(P.fieldBeneath/30))+P.fieldBeneath
			gc.line(0,y,300,y)
		end
	end--Grid
	gc.translate(0,P.fieldBeneath)
	gc.setScissor(scr.x+(P.absFieldX+P.fieldOff.x)*scr.k,scr.y+(P.absFieldY+P.fieldOff.y)*scr.k,300*P.size*scr.k,610*P.size*scr.k)
		if P.falling==-1 then
			for j=int(P.fieldBeneath/30+1),#P.field do
				for i=1,10 do
					if P.field[j][i]>0 then
						gc.setColor(1,1,1,min(P.visTime[j][i]*.05,1))
						drawPixel(j,i,P.field[j][i])
					end
				end
			end
		else--field block only
			local dy,stepY=0,P.gameEnv.smooth and(P.falling/(P.gameEnv.fall+1))^2.5*30 or 30
			local A=P.falling/P.gameEnv.fall
			local h,H=1,#P.field
			for j=int(P.fieldBeneath/30+1),H do
				while j==P.clearingRow[h]do
					h=h+1
					dy=dy+stepY
					gc.translate(0,-stepY)
					gc.setColor(1,1,1,A)
					gc.rectangle("fill",0,630-30*j,300,stepY)
				end
				for i=1,10 do
					if P.field[j][i]>0 then
						gc.setColor(1,1,1,min(P.visTime[j][i]*.05,1))
						drawPixel(j,i,P.field[j][i])
					end
				end
			end
			gc.translate(0,dy)
		end--Field with falling animation
		for i=1,#P.lockFX do
			_=P.lockFX[i]
			if _[3]<.5 then
				gc.setColor(1,1,1,2*_[3])
				gc.rectangle("fill",_[1],_[2],60*_[3],30)
			else
				gc.setColor(1,1,1,2-2*_[3])
				gc.rectangle("fill",_[1]+30,_[2],60*_[3]-60,30)
			end
		end--lockFX
		for i=1,#P.dropFX do
			_=P.dropFX[i]
			gc.setColor(1,1,1,_[1]*.12)
			for x=_[3],_[5]do
				for y=_[6],_[4]do
					drawPixel(y,x,_[2])
				end
			end
		end--dropFX
		if P.waiting==-1 then
			if P.gameEnv.ghost then
				gc.setColor(1,1,1,.3)
				for i=1,P.r do for j=1,P.c do
					if P.cur.bk[i][j]then
						drawPixel(i+P.y_img-1,j+P.curX-1,curColor)
					end
				end end
			end--Ghost
			-- local dy=setting.smooth and(P.y_img~=P.curY and  or 1)^4*30 or 0
			local dy
			if P.gameEnv.smooth then
				if P.y_img~=P.curY then
					dy=(min(P.dropDelay,1e99)/P.gameEnv.drop-1)*30
				else
					dy=0
				end
				--[[
				if P.y_img~=P.curY then
					dy=(min(P.dropDelay,8e98)/P.gameEnv.drop)^4*30
				else
					dy=(min(P.lockDelay,8e98)/P.gameEnv.lock)^(P.gameEnv._20G and 3 or 7)*30
				end
				]]
			else
				dy=0
			end
			gc.translate(0,-dy)
			local trans=P.lockDelay/P.gameEnv.lock
			if P.gameEnv.block then
				SHADER.alpha:send("a",trans)
				gc.setShader(SHADER.alpha)
					_=blockSkin[curColor]
					for i=1,P.r do for j=1,P.c do
						if P.cur.bk[i][j]then
							local x=30*(j+P.curX)-60-3
							local y=630-30*(i+P.curY)-3
							gc.draw(_,x,y)gc.draw(_,x+6,y+6)
							gc.draw(_,x+6,y)gc.draw(_,x,y+6)
						end
					end end
				gc.setShader()--White Boarder(indicate lockdelay)
				gc.setColor(1,1,1)
				for i=1,P.r do for j=1,P.c do
					if P.cur.bk[i][j]then
						drawPixel(i+P.curY-1,j+P.curX-1,curColor)
					end
				end end--Block
			end
			if P.gameEnv.center then
				gc.setColor(1,1,1,trans)
				local x=30*(P.curX+P.sc[2]-1)-15
				gc.draw(IMG.spinCenter,x,600-30*(P.curY+P.sc[1]-1)+15,nil,nil,nil,4,4)
				gc.translate(0,dy)
				gc.setColor(1,1,1,.5)
				gc.draw(IMG.spinCenter,x,600-30*(P.y_img+P.sc[1]-1)+15,nil,nil,nil,4,4)
				goto E
			end--Rotate center
			gc.translate(0,dy)
		end
	::E::
	gc.setColor(1,1,1)
	gc.draw(P.dust)
	gc.setScissor()--In-playField things
	gc.translate(0,-P.fieldBeneath)
	gc.setBlendMode("replace","alphamultiply")--SPEED UPUP(?)
		gc.setLineWidth(2)
		gc.rectangle("line",-1,-11,302,612)--Draw boarder
		gc.rectangle("line",301,0,15,601)--Draw atkBuffer boarder
		local h=0
		for i=1,#P.atkBuffer do
			local A=P.atkBuffer[i]
			local bar=A.amount*30
			if h+bar>600 then bar=600-h end
			if not A.sent then
				if A.time<20 then
					bar=bar*(20*A.time)^.5*.05
					--Appear
				end
				if A.countdown>0 then
					gc.setColor(attackColor[A.lv][1])
					gc.rectangle("fill",303,599-h,11,-bar+3)
					gc.setColor(attackColor[A.lv][2])
					gc.rectangle("fill",303,599-h+(-bar+3),11,-(-bar+3)*(1-A.countdown/A.cd0))
					--Timing
				else
					local t=math.sin((Timer()-i)*30)*.5+.5
					local c1,c2=attackColor[A.lv][1],attackColor[A.lv][2]
					gc.setColor(c1[1]*t+c2[1]*(1-t),c1[2]*t+c2[2]*(1-t),c1[3]*t+c2[3]*(1-t))
					gc.rectangle("fill",303,599-h,11,-bar+3)
					--Warning
				end
			else
				gc.setColor(attackColor[A.lv][1])
				bar=bar*(20-A.time)*.05
				gc.rectangle("fill",303,599-h,11,-bar+2)
				--Disappear
			end
			h=h+bar
		end--Buffer line
		local a,b=P.b2b,P.b2b1 if a>b then a,b=b,a end
		gc.setColor(.8,1,.2)
		gc.rectangle("fill",-14,599,11,-b*.5)
		gc.setColor(P.b2b<40 and color.white or P.b2b<=1e3 and color.lightRed or color.lightBlue)
		gc.rectangle("fill",-14,599,11,-a*.5)
		gc.setColor(1,1,1)
		if Timer()%.5<.3 then
			gc.rectangle("fill",-15,b<40 and 578.5 or 98.5,13,3)
		end
		gc.rectangle("line",-16,-3,15,604)--Draw b2b bar boarder
		--B2B indictator
		gc.translate(-P.fieldOff.x,-P.fieldOff.y)
	gc.setBlendMode("alpha")

	if P.gameEnv.hold then
		mText(drawableText.hold,-81,-10)
		if P.holded then gc.setColor(.6,.5,.5)end
		local B=P.hd.bk
		for i=1,#B do for j=1,#B[1]do
			if B[i][j]then
				drawPixel(i+17.5-#B*.5,j-2.7-#B[1]*.5,P.hd.color)
			end
		end end
	end--Hold
	gc.setColor(1,1,1)
	mText(drawableText.next,381,-10)
	local N=1
	::L::
	if N<=P.gameEnv.next and P.next[N]then
		local b,c=P.next[N].bk,P.next[N].color
		for i=1,#b do for j=1,#b[1] do
			if b[i][j]then
				drawPixel(i+20-2.4*N-#b*.5,j+12.7-#b[1]*.5,c)
			end
		end end
		N=N+1
		goto L
	end
	--Next
	gc.setColor(.8,.8,.8)
	gc.draw(drawableText.modeName,-135,-65)
	gc.draw(drawableText.levelName,437-drawableText.levelName:getWidth(),-65)
	gc.setColor(1,1,1)
	if frame<180 then
		local count=179-frame
		gc.push("transform")
			gc.translate(155,220)
			setFont(95)
			if count%60>45 then gc.scale(1+(count%60-45)^2*.01,1)end
			mStr(int(count/60+1),0,0)
		gc.pop()
	end--Draw starting counter
	TEXT.draw(P.bonus)--Bonus texts
	setFont(25)
	drawDial(360,520,P.dropSpeed)
	drawDial(405,575,P.keySpeed)
	gc.setColor(1,1,1)
	mStr(format("%.2f",P.stat.time),-81,518)--Time
	mStr(P.score1,-81,560)--Score
	gc.draw(drawableText.bpm,390,490)
	gc.draw(drawableText.kpm,344,583)
	--Speed dials
	gc.setColor(1,1,1)
	curMode.mesDisp(P)--Other messages
	if modeEnv.royaleMode then
		if P.atkMode then
			gc.setColor(1,.8,0,P.swappingAtkMode*.02)
			gc.rectangle("fill",RCPB[2*P.atkMode-1],RCPB[2*P.atkMode],90,35,8,4)
		end
		gc.setColor(1,1,1,P.swappingAtkMode*.025)
		gc.draw(royaleCtrlPad)
	end
	gc.pop()
end
local function Pdraw_small(P)
	P.frameWait=P.frameWait-1
	if P.frameWait==0 then
		P.frameWait=10
		gc.setCanvas(P.canvas)
		gc.clear(0,0,0,.4)
		gc.push("transform")
		gc.origin()
		gc.setColor(1,1,1,P.result and max(20-P.endCounter,0)*.05 or 1)
		local F=P.field
		for j=1,#F do
			for i=1,10 do if F[j][i]>0 then
				gc.draw(blockSkinMini[F[j][i]],6*i-6,120-6*j)
			end end
		end--Field
		if P.alive then
			gc.setLineWidth(2)
			gc.setColor(frameColor[P.strength])gc.rectangle("line",1,1,58,118)
		end--Draw boarder
		if modeEnv.royaleMode then
			gc.setColor(1,1,1)
			for i=1,P.strength do
				gc.draw(IMG.badgeIcon,12*i-7,4,nil,.5)
			end
		end
		if P.result then
			gc.setColor(1,1,1,min(P.endCounter,60)*.01)
			setFont(17)mStr(P.result,32,47)
			setFont(15)mStr(P.modeData.event,30,82)
		end
		gc.pop()
		gc.setCanvas()
		--draw content
	end
	gc.setColor(1,1,1)
	gc.draw(P.canvas,P.x,P.y,nil,P.size*10)
	--draw Canvas
	if P.killMark then
		gc.setLineWidth(3)
		gc.setColor(1,0,0,min(P.endCounter,25)*.04)
		gc.circle("line",P.centerX,P.centerY,(840-20*min(P.endCounter,30))*P.size)
	end
	setFont(30)
end
local function Pdraw_demo(P)
	local _
	local curColor=P.cur.color
	gc.push("transform")
	gc.translate(P.x,P.y)gc.scale(P.size)gc.translate(P.fieldOff.x,P.fieldOff.y)
	--Camera
	gc.setColor(.1,.1,.1,.8)gc.rectangle("fill",0,0,300,600)
	gc.setLineWidth(2)gc.setColor(1,1,1)gc.rectangle("line",-1,-1,302,602)
	--Frame
	if P.falling==-1 then
		for j=int(P.fieldBeneath/30+1),#P.field do
			for i=1,10 do
				if P.field[j][i]>0 then
					gc.setColor(1,1,1,min(P.visTime[j][i]*.05,1))
					drawPixel(j,i,P.field[j][i])
				end
			end
		end
	else--field block only
		local dy,stepY=0,P.gameEnv.smooth and(P.falling/(P.gameEnv.fall+1))^2.5*30 or 30
		local A=P.falling/P.gameEnv.fall
		local h,H=1,#P.field
		for j=int(P.fieldBeneath/30+1),H do
			while j==P.clearingRow[h]do
				h=h+1
				dy=dy+stepY
				gc.translate(0,-stepY)
				gc.setColor(1,1,1,A)
				gc.rectangle("fill",0,630-30*j,300,stepY)
			end
			for i=1,10 do
				if P.field[j][i]>0 then
					gc.setColor(1,1,1,min(P.visTime[j][i]*.05,1))
					drawPixel(j,i,P.field[j][i])
				end
			end
		end
		gc.translate(0,dy)
	end--Field with falling animation
	for i=1,#P.lockFX do
		_=P.lockFX[i]
		if _[3]<.5 then
			gc.setColor(1,1,1,3*_[3])
			gc.rectangle("fill",_[1],_[2],60*_[3],30)
		else
			gc.setColor(1,1,1,3-3*_[3])
			gc.rectangle("fill",_[1]+30,_[2],60*_[3]-60,30)
		end
	end--lockFX
	for i=1,#P.dropFX do
		local S=P.dropFX[i]
		gc.setColor(1,1,1,S[1]*.12)
		for x=S[3],S[5]do
			for y=S[6],S[4]do
				drawPixel(y,x,S[2])
			end
		end
	end--dropFX
	if P.waiting==-1 then
		gc.setColor(1,1,1,.3)
		for i=1,P.r do for j=1,P.c do
			if P.cur.bk[i][j]then
				drawPixel(i+P.y_img-1,j+P.curX-1,curColor)
			end
		end end
		--Ghost draw
		gc.setColor(1,1,1)
		for i=1,P.r do for j=1,P.c do
			if P.cur.bk[i][j]then
				drawPixel(i+P.curY-1,j+P.curX-1,curColor)
			end
		end end--Block
	end
	local id=P.hd.id
	if id>0 then
		_=P.color[id]
		gc.setColor(_[1],_[2],_[3],.3)
		_=miniBlock[P.hd.id]
		gc.draw(_,15,30,nil,16,nil,0,_:getHeight()*.5)
	end
	local N=1
	::L::
	if N<=P.gameEnv.next and P.next[N]then
		local id=P.next[N].id
		_=P.color[id]
		gc.setColor(_[1],_[2],_[3],.3)
		_=miniBlock[id]
		gc.draw(_,285,40*N-10,nil,16,nil,_:getWidth(),_:getHeight()*.5)
		N=N+1
		goto L
	end
	--Next
	gc.setColor(1,1,1)
	gc.draw(P.dust)
	gc.translate(-P.fieldOff.x,-P.fieldOff.y)
	TEXT.draw(P.bonus)
	gc.pop()
end
local function updateFXs(P,dt)
	if P.stat.score>P.score1 then
		if P.stat.score-P.score1<10 then
			P.score1=P.score1+1
		else
			P.score1=int(min(P.score1*.9+P.stat.score*.1+1))
		end
	end
	for i=#P.lockFX,1,-1 do
		local _=P.lockFX[i]
		_[3]=_[3]+_[4]
		if _[3]>1 then
			rem(P.lockFX,i)
		end
	end--lockFX
	for i=#P.dropFX,1,-1 do
		local S=P.dropFX[i]
		S[1]=S[1]-1+P.gameEnv.dropFX*.15
		if S[1]<=0 then
			rem(P.dropFX,i)
		end
	end--dropFX

	if P.gameEnv.shakeFX then
		local O=P.fieldOff
		O.vx,O.vy=O.vx*.8-abs(O.x)^1.2*(O.x>0 and .1 or -.1),O.vy*.8-abs(O.y)^1.2*(O.y>0 and .1 or -.1)
		O.x,O.y=O.x+O.vx,O.y+O.vy
		if abs(O.x)<.3 then O.x=0 end
		if abs(O.y)<.3 then O.y=0 end
	end--field shaking
	if P.bonus then
		TEXT.update(P.bonus)
	end
	for i=#P.atkBuffer,1,-1 do
		local A=P.atkBuffer[i]
		A.time=A.time+1
		if not A.sent then
			if A.countdown>0 then
				A.countdown=max(A.countdown-garbageSpeed,0)
			end
		else
			if A.time>20 then
				rem(P.atkBuffer,i)
			end
		end
	end
	if P.fieldBeneath>0 then P.fieldBeneath=max(P.fieldBeneath-P.gameEnv.pushSpeed,0)end
	if not P.small then
		P.dust:update(dt)
	end
end
local function Pupdate_alive(P,dt)
	if P.timing then P.stat.time=P.stat.time+dt end
	if P.keyRec then
		local _=frame
		local v=0
		for i=2,10 do v=v+i*(i-1)*7.2/(_-P.keyTime[i])end P.keySpeed=P.keySpeed*.99+v*.1
		v=0
		for i=2,10 do v=v+i*(i-1)*7.2/(_-P.dropTime[i])end P.dropSpeed=P.dropSpeed*.99+v*.1
		--Update speeds
		if modeEnv.royaleMode then
			if P.keyPressing[9]then
				P.swappingAtkMode=min(P.swappingAtkMode+2,30)
			else
				P.swappingAtkMode=P.swappingAtkMode+((#P.field>15 and P.swappingAtkMode>4 or P.swappingAtkMode>8)and -1 or 1)
			end
		end
	end

	if not P.human and P.control and P.waiting==-1 then
		local C=P.AI_keys
		P.AI_delay=P.AI_delay-1
		if not C[1]then
			P.AI_stage=AI_think[P.AI_mode][P.AI_stage](P,C)
		elseif P.AI_delay<=0 then
			P:pressKey(C[1])P:releaseKey(C[1])
			rem(C,1)
			P.AI_delay=P.AI_delay0*2
		end
	end
	if not P.keepVisible then
		for j=1,#P.field do for i=1,10 do
			if P.visTime[j][i]>0 then P.visTime[j][i]=P.visTime[j][i]-1 end
		end end
	end--Fresh visible time

	if P.movDir~=0 then
		local das,arr=P.gameEnv.das,P.gameEnv.arr
		local mov=P.moving
		if P.waiting==-1 then
			if P.movDir==1 then
				if P.keyPressing[2]then
					if arr>0 then
						if mov==das+arr or mov==das then
							if P:ifoverlap(P.cur.bk,P.curX+1,P.curY)then
								mov=das+arr-1
							else
								P.act.moveRight(P,true)
								mov=das
							end
						end
						mov=mov+1
					else
						if mov==das then
							P.act.insRight(P,true)
						else
							mov=mov+1
						end
					end
					if mov>=das and P.gameEnv.shakeFX and P:ifoverlap(P.cur.bk,P.curX+1,P.curY)then
						P.fieldOff.vx=P.gameEnv.shakeFX*.5
					end
				else
					P.movDir=0
				end
			else
				if P.keyPressing[1]then
					if arr>0 then
						if mov==das+arr or mov==das then
							if P:ifoverlap(P.cur.bk,P.curX-1,P.curY)then
								mov=das+arr-1
							else
								P.act.moveLeft(P,true)
								mov=das
							end
						end
						mov=mov+1
					else
						if mov==das then
							P.act.insLeft(P,true)
						else
							mov=mov+1
						end
					end
					if mov>=das and P.gameEnv.shakeFX and P:ifoverlap(P.cur.bk,P.curX-1,P.curY)then
						P.fieldOff.vx=-P.gameEnv.shakeFX*.5
					end
				else
					P.movDir=0
				end
			end
		elseif mov<das then
			mov=mov+1
		end
		P.moving=mov
	end

	if P.keyPressing[7]and not P.keyPressing[9]then
		local d=P.downing-P.gameEnv.sddas
		P.downing=P.downing+1
		if d>1 then
			if P.gameEnv.sdarr>0 then
				if d%P.gameEnv.sdarr==0 then
					P.act.down1(P)
				end
			else
				P.act.insDown(P)
			end
			if P.gameEnv.shakeFX then
				P.fieldOff.vy=P.gameEnv.shakeFX*.3
			end
		end
	else
		P.downing=0
	end
	if P.falling>=0 then
		P.falling=P.falling-1
		if P.falling>=0 then
			goto stop
		else
			local L=#P.clearingRow
			if P.human and P.gameEnv.fall>0 and #P.field+L>P.clearingRow[L]then SFX.play("fall")end
			P.clearingRow={}
		end
	end
	if not P.control then goto stop end
	if P.waiting==0 then P:popNext()end
	if P.waiting>=0 then
		P.waiting=P.waiting-1
		goto stop
	end
	if P.curY~=P.y_img then
		local D=P.dropDelay
		if D>1 then
			P.dropDelay=D-1
			goto stop
		end
		if D==1 then
			P.curY=P.curY-1
		else
			local _=P.curY-P.y_img--max fall dist
			D=1/D--fall dist
			if D<_ then
				P.curY=P.curY-D
				assert(P.curY==int(P.curY),"y:"..P.curY.." fall:"..D.." D_env:"..P.gameEnv.drop)
			else
				P.curY=P.y_img
			end
		end
		P.spinLast=false
		if P.y_img~=P.curY then
			P.dropDelay=P.gameEnv.drop
		elseif P.AI_mode=="CC"then
			P.AI_needFresh=true
			if not P.AIdata._20G and P.gameEnv.drop<P.AI_delay0*.5 then
				CC_switch20G(P)
			end
		end
		if P.freshTime<=P.gameEnv.freshLimit then
			P.lockDelay=P.gameEnv.lock
		end
	else
		P.lockDelay=P.lockDelay-1
		if P.lockDelay>=0 then goto stop end
		P:drop()
		if P.AI_mode=="CC"then
			P.AI_needFresh=true
		end
	end
	::stop::
	if P.b2b1==P.b2b then
	elseif P.b2b1<P.b2b then
		P.b2b1=min(P.b2b1*.98+P.b2b*.02+.4,P.b2b)
	else
		P.b2b1=max(P.b2b1*.95+P.b2b*.05-.6,P.b2b)
	end
	updateFXs(P,dt)
end
local function Pupdate_dead(P,dt)
	if P.timing then P.stat.time=P.stat.time+dt end
	if P.keyRec then
		P.keySpeed=P.keySpeed*.96+P.stat.key/P.stat.time*60*.04
		P.dropSpeed=P.dropSpeed*.96+P.stat.piece/P.stat.time*60*.04
		--Final average speeds
		if modeEnv.royaleMode then
			P.swappingAtkMode=min(P.swappingAtkMode+2,30)
		end
	end
	if P.falling>=0 then
		P.falling=P.falling-1
		if P.falling>=0 then
			goto stop
		else
			local L=#P.clearingRow
			if P.human and P.gameEnv.fall>0 and #P.field+L>P.clearingRow[L]then SFX.play("fall")end
			P.clearingRow={}
		end
	end::stop::
	if P.endCounter<40 then
		for j=1,#P.field do for i=1,10 do
			if P.visTime[j][i]<20 then P.visTime[j][i]=P.visTime[j][i]+.5 end
		end end--Make field visible
	end
	if P.b2b1>0 then P.b2b1=max(0,P.b2b1*.92-1)end
	updateFXs(P,dt)
end
-------------------------</Pnt/Upd>-------------------------
player={}local player=player
----------------------------<FX>----------------------------
local textFX=textFX
function player.showText(P,text,dx,dy,font,style,spd,stop)
	if P.gameEnv.text then
		P.bonus[#P.bonus+1]=TEXT.getText(text,150+dx,300+dy,font*P.size,style,spd,stop)
	end
end
function player.showTextF(P,text,dx,dy,font,style,spd,stop)
	P.bonus[#P.bonus+1]=TEXT.getText(text,150+dx,300+dy,font*P.size,style,spd,stop)
end
local function without(L,e)
	for i=1,#L do
		if L[i]==e then return end
	end
	return true
end
function player.createLockFX(P)
	local BK=P.cur.bk
	local t=.3-P.gameEnv.lockFX*.06
	for i=1,P.r do
		local y=P.curY+i-1
		if without(P.clearedRow,y)then
			for j=1,P.c do
				if BK[i][j]then
					ins(P.lockFX,{30*(P.curX+j-2),600-30*y,0,t})
				end
			end
		end
	end
end
function player.createDropFX(P,x1,y1,x2,y2)--x1<x2,y1>y2!
	if P.gameEnv.block and y1>=y2 then
		P.dropFX[#P.dropFX+1]={5,P.cur.color,x1,y1,x2,y2}
	end
end
function player.createBeam(P,R,send,time,target,color,clear,spin,mini,combo)
	local x1,y1,x2,y2
	if P.small then x1,y1=P.centerX,P.centerY
	else x1,y1=P.x+(30*(P.curX+P.sc[2]-1)-30+15+150)*P.size,P.y+(600-30*(P.curY+P.sc[1]-1)+15+70)*P.size
	end
	if R.small then x2,y2=R.centerX,R.centerY
	else x2,y2=R.x+308*R.size,R.y+450*R.size
	end

	local radius,corner
	local a,r,g,b=1,unpack(skin.libColor[color])
	if clear>10 then
		radius=10+3*send+100/(target+4)
		local t=clear%10
		if t==1 then
			corner=3
			r=.3+r*.4
			g=.3+g*.4
			b=.3+b*.4
		elseif t==2 then
			corner=5
			r=.5+r*.5
			g=.5+g*.5
			b=.5+b*.5
		elseif t<6 then
			corner=6
			r=.6+r*.4
			g=.6+g*.4
			b=.6+b*.4
		else
			corner=20
			r=.8+r*.2
			g=.8+g*.2
			b=.8+b*.2
		end
	else
		if combo>3 then
			radius=min(15+combo,30)
			corner=3
		else
			radius=30
			corner=4
		end
		r=1-r*.3
		g=1-g*.3
		b=1-b*.3
	end
	if modeEnv.royaleMode and not(P.human or R.human)then
		radius=radius*.4
		a=.35
	end
	FX_attack[#FX_attack+1]={
		x=x1,y=y1,--current pos
		x1=x1,y1=y1,--start pos
		x2=x2,y2=y2,--end pos
		rad=radius*(setting.atkFX+3)*.12,
		corner=corner,
		type=type==1 and"fill"or"line",
		r=r,g=g,b=b,a=a*(setting.atkFX+5)*.1,
		t=0,
		drag={},--Afterimage coordinate list
	}
end
-------------------------</FX>-------------------------

-------------------------<Method>-------------------------
local function solid(P,x,y)
	if x<1 or x>10 or y<1 then return true end
	if y>#P.field then return false end
	return P.field[y][x]>0
end
local function getBlockPosition(P)--for stereo sfx
	return(P.curX+P.sc[2]-6.5)*.15
end
function player.ifoverlap(P,bk,x,y)
	local C=#bk[1]
	if x<1 or x+C>11 or y<1 then return true end
	if y>#P.field then return end
	for i=1,#bk do
		if P.field[y+i-1]then
			for j=1,C do
				if bk[i][j]and P.field[y+i-1][x+j-1]>0 then return true end
			end
		end
	end
end
function player.ckfull(P,i)
	for j=1,10 do if P.field[i][j]<=0 then return end end
	return true
end
function player.fineError(P,rate)
	P.stat.extraPiece=P.stat.extraPiece+1
	P.stat.extraRate=P.stat.extraRate+rate
	if P.human then
		if P.gameEnv.fineKill then
			SFX.play("finesseError_long")
			P:lose()
		elseif setting.fine then
			SFX.play("finesseError")
		end
	elseif P.gameEnv.fineKill then
		P:lose()
	end
end
function player.garbageSend(P,R,send,time,...)
	if setting.atkFX>0 then
		P:createBeam(R,send,time,...)
	end
	R.lastRecv=P
	if R.atkBuffer.sum<20 then
		local B=R.atkBuffer
		if B.sum+send>20 then send=20-B.sum end--no more then 20
		local m,k=#B,1
		while k<=m and time>B[k].countdown do k=k+1 end
		for i=m,k,-1 do
			B[i+1]=B[i]
		end
		B[k]={
			pos=rnd(10),
			amount=send,
			countdown=time,
			cd0=time,
			time=0,
			sent=false,
			lv=min(int(send^.69),5),
		}--Sorted insert(by time)
		B.sum=B.sum+send
		R.stat.recv=R.stat.recv+send
		if R.human then
			SFX.play(send<4 and "blip_1"or"blip_2",min(send+1,5)*.1)
		end
	end
end
function player.garbageRelease(P)
	local n,flag=1
	::L::
		local A=P.atkBuffer[n]
		if A and A.countdown<=0 and not A.sent then
			P:garbageRise(12+A.lv,A.amount,A.pos)
			P.atkBuffer.sum=P.atkBuffer.sum-A.amount
			A.sent,A.time=true,0
			P.stat.pend=P.stat.pend+A.amount
			n=n+1
			flag=true
		else
			goto E
		end
	goto L
	::E::
	if flag and P.AI_mode=="CC"then CC_updateField(P)end
end
function player.garbageRise(P,color,amount,pos)
	local _
	local t=P.showTime*2
	for _=1,amount do
		ins(P.field,1,freeRow.get(color))
		ins(P.visTime,1,freeRow.get(t))
		P.field[1][pos]=0
	end
	P.fieldBeneath=P.fieldBeneath+amount*30
	P.curY=P.curY+amount
	P.garbageBeneath=P.garbageBeneath+amount
	P:freshgho()
	for i=1,#P.clearingRow do
		P.clearingRow[i]=P.clearingRow[i]+amount
	end
	for i=1,#P.lockFX do
		_=P.lockFX[i]
		_[2]=_[2]-30*amount--calculated pos!Must *=-30
	end
	for i=1,#P.dropFX do
		_=P.dropFX[i]
		_[4],_[6]=_[4]+amount,_[6]+amount
	end
	if #P.field>40 then P:lose()end
end
function player.freshTarget(P)
	if P.atkMode==1 then
		if not P.atking or not P.atking.alive or rnd()<.1 then
			P:changeAtk(randomTarget(P))
		end
	elseif P.atkMode==2 then
		P:changeAtk(P~=mostBadge and mostBadge or secBadge or randomTarget(P))
	elseif P.atkMode==3 then
		P:changeAtk(P~=mostDangerous and mostDangerous or secDangerous or randomTarget(P))
	elseif P.atkMode==4 then
		for i=1,#P.atker do
			if not P.atker[i].alive then
				rem(P.atker,i)
				return
			end
		end
	end
end
function player.changeAtkMode(P,m)
	if P.atkMode==m then return end
	P.atkMode=m
	if m==1 then
		P:changeAtk(randomTarget(P))
	elseif m==2 or m==3 then
		P:freshTarget()
	elseif m==4 then
		P:changeAtk()
	end
end
function player.changeAtk(P,R)
	-- if not P.human then R=players[1]end--1vALL mode?
	if P.atking then
		local K=P.atking.atker
		for i=1,#K do
			if K[i]==P then
				rem(K,i)
				break
			end
		end
	end
	if R then
		P.atking=R
		R.atker[#R.atker+1]=P
	else
		P.atking=nil
	end
end
function player.freshgho(P)
	P.y_img=min(#P.field+1,P.curY)
	if P.gameEnv._20G or P.keyPressing[7]and P.gameEnv.sdarr==0 then
		while not P:ifoverlap(P.cur.bk,P.curX,P.y_img-1)do
			P.y_img=P.y_img-1
			P.spinLast=false
		end
		if P.curY>P.y_img then
			if P.gameEnv.dropFX then
				P:createDropFX(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
			end
			if P.gameEnv.shakeFX then
				P.fieldOff.vy=P.gameEnv.shakeFX*.5
			end
			P.curY=P.y_img
		end
	else
		while not P:ifoverlap(P.cur.bk,P.curX,P.y_img-1)do
			P.y_img=P.y_img-1
		end
	end
end
function player.freshLockDelay(P)
	if P.lockDelay<P.gameEnv.lock then
		P.dropDelay=P.gameEnv.drop
		P.freshTime=P.freshTime+1
		if P.freshTime<=P.gameEnv.freshLimit then
			P.lockDelay=P.gameEnv.lock
		end
	end
end
function player.lock(P)
	for i=1,P.r do
		local y=P.curY+i-1
		if not P.field[y]then P.field[y],P.visTime[y]=freeRow.get(0),freeRow.get(0)end
		for j=1,P.c do
			if P.cur.bk[i][j]then
				P.field[y][P.curX+j-1]=P.cur.color
				P.visTime[y][P.curX+j-1]=P.showTime
			end
		end
	end
end
local OspinList={
	{111,5,2, 0,-1,0},{111,5,2,-1,-1,0},{111,5,0,-1, 0,0},--T
	{333,5,2,-1,-1,0},{333,5,2, 0,-1,0},{333,5,0, 0, 0,0},--T
	{313,1,2,-1, 0,0},{313,1,2, 0,-1,0},{313,1,2, 0, 0,0},--Z
	{131,2,2, 0, 0,0},{131,2,2,-1,-1,0},{131,2,2,-1, 0,0},--S
	{113,3,2,-1,-1,0},{331,3,0,-1, 0,0},{331,3,2, 0, 0,0},--L
	{331,4,2, 0,-1,0},{113,4,0, 0, 0,0},{113,4,2,-1, 0,0},--J
	{222,7,2,-1, 0,1},{222,7,2,-2, 0,1},{222,7,2, 0, 0,1},--I
	{121,6,0, 1,-1,1},{112,6,0, 2,-1,2},{122,6,0, 1,-2,2},--O
	{323,6,0,-1,-1,2},{332,6,0,-2,-1,2},{322,6,0,-1,-2,2},--O
}--{key,id,dir,dx,dy,freeLv(0=unmovable,1=↔Unmvb,2=free)}
function player.spin(P,d,ifpre)
	if P.cur.id==6 then--O-spin!Ohhhhhhhhhhhhhhhhhhhhhhhhhh
		if P.human then
			SFX.play("rotate",nil,getBlockPosition(P))
		end
		if P.gameEnv.easyFresh then
			P:freshLockDelay()
		end
		if P.gameEnv.ospin then
			local x,y=P.curX,P.curY
			if y==P.y_img and((solid(P,x-1,y)or solid(P,x-1,y+1)))and(solid(P,x+2,y)or solid(P,x+2,y+1))then
				local D=P.spinSeq%100*10+d
				P.spinSeq=D
				if D>100 then
					for i=1,#OspinList do
						local L=OspinList[i]
						if D==L[1]then
							local id,dir=L[2],L[3]
							local bk=blocks[id][dir]
							local x,y=P.curX+L[4],P.curY+L[5]
							if not P:ifoverlap(bk,x,y)and(L[6]>0 or P:ifoverlap(bk,x-1,y)and P:ifoverlap(bk,x+1,y))and(L[6]==2 or P:ifoverlap(bk,x,y-1))and P:ifoverlap(bk,x,y+1)then
								local C=P.cur
								C.id=id
								C.bk=bk
								P.curX,P.curY=x,y
								P.r,P.c=#bk,#bk[1]
								P.dir,P.sc=dir,scs[id][dir]
								P.spinLast=2
								P.stat.rotate=P.stat.rotate+1
								P:freshgho()
								P.spinSeq=0
								SFX.play("rotatekick",nil,getBlockPosition(P))
								return
							end
						end
					end
				end
			else
				P.spinSeq=0
			end
		end
		return
	end
	local idir=(P.dir+d)%4
	local icb=blocks[P.cur.id][idir]
	local isc=scs[P.cur.id][idir]
	local ir,ic=#icb,#icb[1]
	local ix,iy=P.curX+P.sc[2]-isc[2],P.curY+P.sc[1]-isc[1]
	local t--succssful test
	local iki=P.RS[P.cur.id][P.dir*10+idir]
	for i=1,P.freshTime<=1.2*P.gameEnv.freshLimit and #iki or 1 do
		local x,y=ix+iki[i][1],iy+iki[i][2]
		if not P:ifoverlap(icb,x,y)then
			ix=x;iy=y;t=i
			goto spin
		end
	end
	do return end
	::spin::
	if P.gameEnv.dropFX then
		P:createDropFX(P.curX,P.curY+P.r-1,P.curX+P.c-1,P.curY)
	end
	local y0=P.curY
	P.curX,P.curY,P.dir=ix,iy,idir
	P.sc,P.cur.bk=scs[P.cur.id][idir],icb
	P.r,P.c=ir,ic
	P.spinLast=t==2 and 0 or 1
	if not ifpre then P:freshgho()end
	if P.gameEnv.easyFresh or y0>P.curY then P:freshLockDelay()end
	if P.human then
		SFX.play(ifpre and"prerotate"or P:ifoverlap(P.cur.bk,P.curX,P.curY+1)and P:ifoverlap(P.cur.bk,P.curX-1,P.curY)and P:ifoverlap(P.cur.bk,P.curX+1,P.curY)and"rotatekick"or"rotate",nil,getBlockPosition(P))
	end
	P.stat.rotate=P.stat.rotate+1
end
function player.resetBlock(P)
	local id=P.cur.id
	local face=P.gameEnv.face[id]
	local sc=scs[id][face]
	P.sc=sc							--spin center
	P.dir=face						--block direction
	P.r,P.c=#P.cur.bk,#P.cur.bk[1]	--row/column
	P.curX=initCenterX[id]-sc[2]
	P.curY=initCenterY[id]-sc[1]+ceil(P.fieldBeneath/30)
	if P.gameEnv.ims and(P.keyPressing[1]and P.movDir==-1 or P.keyPressing[2]and P.movDir==1)and P.moving>=P.gameEnv.das then
		local x=P.curX+P.movDir
		if not P:ifoverlap(P.cur.bk,x,P.curY)then
			P.curX=x
		end
	end
	--IMS
end
function player.hold(P,ifpre)
	if not P.holded and (ifpre or P.waiting==-1) and P.gameEnv.hold then
		--Finesse check
		local H,B=P.hd,P.cur
		if H and H.id==B.id and H.name==B.name or P.ctrlCount>1 then
			P:fineError(1)
		end

		P.holded=P.gameEnv.oncehold
		P.spinLast=false
		P.ctrlCount=0
		P.spinSeq=0
		P.cur,P.hd=P.hd,P.cur
		local hid=P.hd.id
		P.hd.bk=blocks[hid][P.gameEnv.face[hid]]
		if P.cur.id==0 then
			P.cur=rem(P.next,1)
			P:newNext()
			if P.AI_mode=="CC"then BOT.addNext(P.AI_bot,CCblockID[P.next[P.AIdata.next].id])end
		end
		P:resetBlock()

		P:freshgho()
		P.dropDelay,P.lockDelay,P.freshTime=P.gameEnv.drop,P.gameEnv.lock,max(P.freshTime-5,0)
		if P:ifoverlap(P.cur.bk,P.curX,P.curY)then P:lock()P:lose()end

		if P.human then
			SFX.play(ifpre and"prehold"or"hold")
		end
		P.stat.hold=P.stat.hold+1
	end
end
function player.getNext(P,n)
	local E=P.gameEnv
	P.next[#P.next+1]={bk=blocks[n][E.face[n]],id=n,color=E.bone and 12 or E.skin[n],name=n}
end
function player.popNext(P)--pop next queue to hand
	P.holded=false
	P.spinLast=false
	P.spinSeq=0
	P.ctrlCount=0

	P.cur=rem(P.next,1)
	P:newNext()
	if P.AI_mode=="CC"then BOT.addNext(P.AI_bot,CCblockID[P.next[P.AIdata.next].id])end
	local _=P.keyPressing
	if _[8]and P.gameEnv.hold and P.gameEnv.ihs then
		P:hold(true)
		_[8]=false
	else
		P:resetBlock()
	end
	--IHS
	P.dropDelay,P.lockDelay,P.freshTime=P.gameEnv.drop,P.gameEnv.lock,0
	if P.gameEnv.irs then
		if _[5]then
			P:spin(2,true)
		else
			if _[3]then
				if _[4]then
					P:spin(2,true)
				else
					P:spin(1,true)
				end
			elseif _[4]then
				P:spin(3,true)
			end
		end
	end
	--IRS
	if P:ifoverlap(P.cur.bk,P.curX,P.curY)then P:lock()P:lose()end
	P:freshgho()
	if _[6]then P.act.hardDrop(P)_[6]=false end
	--IHdS
end
function player.drop(P)--Place piece
	local _
	local CHN=VOC.getFreeChannel()
	P.dropTime[11]=ins(P.dropTime,1,frame)--update speed dial
	local cmb=P.combo
	P.waiting=P.gameEnv.wait
	local STAT=P.stat
	local clear--if (perfect)clear
	local cc,gbcc=0,0--row/garbage-row cleared,full-part
	local atk,send=0,0--Send&Send Time
	local exblock=0--extra defense
	local cscore,sendTime=0,0
	local dospin=0
	local mini
	--spin判定
	if P.spinLast then
		if P.cur.id<6 then
			local x,y=P.curX+P.sc[2]-1,P.curY+P.sc[1]-1
			local c=0
			if solid(P,x-1,y+1)then c=c+1 end
			if solid(P,x+1,y+1)then c=c+1 end
			if c==0 then goto NTC end
			if solid(P,x-1,y-1)then c=c+1 end
			if solid(P,x+1,y-1)then c=c+1 end
			if c>2 then dospin=dospin+1 end
		end--三角
		::NTC::
		if P:ifoverlap(P.cur.bk,P.curX-1,P.curY)and P:ifoverlap(P.cur.bk,P.curX+1,P.curY)and P:ifoverlap(P.cur.bk,P.curX,P.curY+1)then
			dospin=dospin+2
		end--卡块
	end

	--锁定
	P:lock()
	--清空消行列表
	if P.clearedRow[1]then P.clearedRow={}end
	--消行
	for i=0,P.r-1 do
		local h=P.curY+i
		if P:ckfull(h)then
			cc=cc+1
			P.clearingRow[cc]=h-cc+1
			P.clearedRow[cc]=h
			if not P.small then
				local S=P.dust
				for _=1,100 do
					S:setPosition(rnd(300),600-30*h+rnd(30))
					S:emit(2)
				end
			end
		end
	end

	--处理锁定特效
	if P.gameEnv.lockFX then
		if cc==0 then
			P:createLockFX()
		elseif P.lockFX[1]then
			P.lockFX={}
		end
	end

	--处理锁定特效
	if P.gameEnv.lockFX then
		if cc==0 then
			P:createLockFX()
		elseif P.lockFX[1]then
			P.lockFX={}
		end
	end

	--spin结算
	if P.spinLast then
		if cc>0 then
			if dospin>0 then
				dospin=dospin+P.spinLast
				if dospin<2 then
					mini=P.cur.id<6 and cc<3 and cc<P.r
				end
			else
				dospin=false
			end
		elseif cc==0 then
			if dospin==0 then
				dospin=false
			end
		end
	else
		dospin=false
	end

	--极简判定:遮挡判断法
	local finesse
	if P.curY<=18 then
		local y0=P.curY
		local x,c=P.curX,P.c
		local B=P.cur.bk
		for x=1,c do
			local y
			for i=#B,1,-1 do
				if B[i][x]then y=i;goto L1 end
			end
			goto L2
			::L1::
			if y then
				x=P.curX+x-1
				for y=y0+y,#P.field do
					if solid(P,x,y)then
						finesse=true
						goto L2
					end--有遮挡视为最简
				end
			end
		end
	else
		finesse=true
	end
	::L2::

	--移除消去的行
	if cc>0 then
		for i=cc,1,-1 do
			_=P.clearedRow[i]
			freeRow.discard(rem(P.field,_))
			freeRow.discard(rem(P.visTime,_))
			if _<=P.garbageBeneath then
				P.garbageBeneath=P.garbageBeneath-1
				gbcc=gbcc+1
			end
		end
	end
	--清除超高特效
	_=#P.clearingRow
	::L::if _>0 then
		if P.clearingRow[_]>#P.field then
			P.clearingRow[_]=nil
			_=_-1
			goto L
		end
	end
	if P.clearingRow[1]then
		P.falling=P.gameEnv.fall
	elseif cc==P.r then
		clear=true
	end

	if not finesse then--极简判定:操作判断法
		if dospin then P.ctrlCount=P.ctrlCount-2 end--对无遮挡spin宽松两步
		local id=P.cur.id
		local dir=P.dir+1
		if id<3 or id==7 then
			if dir>2 then
				dir=dir-2
			end
		end--SZI的逆态视为顺态
		local d=P.ctrlCount-finesseCtrlPar[id][dir][P.curX]if d>=2 then P:fineError(2)elseif d>0 then P:fineError(d)end	--非最简
		end

	if cc>0 then
		cmb=cmb+1
		if cc==4 then
			cscore=1000
			if P.b2b>1000 then
				P:showText(text.techrashB3B,0,-30,50,"fly")
				atk=6
				sendTime=100
				exblock=exblock+1
				cscore=cscore*1.8
				STAT.b3b=STAT.b3b+1
				if P.human then
					VOC.play("b3b",CHN)
				end
			elseif P.b2b>=50 then
				P:showText(text.techrashB2B,0,-30,50,"drive")
				sendTime=80
				atk=5
				cscore=cscore*1.3
				STAT.b2b=STAT.b2b+1
				if P.human then
					VOC.play("b2b",CHN)
				end
			else
				P:showText(text.techrash,0,-30,70,"stretch")
				sendTime=60
				atk=4
			end
			P.b2b=P.b2b+120
			P.lastClear=74
			if P.human then
				VOC.play("techrash",CHN)
			end
		elseif cc>0 then
			if dospin then
				cscore=spinSCR[P.cur.name][cc]
				if P.b2b>1000 then
					P:showText(text.b3b..text.spin[P.cur.name]..text.clear[cc],0,-30,35,"spin")
					atk=b2bATK[cc]+cc-1
					exblock=exblock+1
					cscore=cscore*2
					STAT.b3b=STAT.b3b+1
					if P.human then
						VOC.play("b3b",CHN)
					end
				elseif P.b2b>=50 then
					P:showText(text.b2b..text.spin[P.cur.name]..text.clear[cc],0,-30,35,"spin")
					atk=b2bATK[cc]
					cscore=cscore*1.2
					STAT.b2b=STAT.b2b+1
					if P.human then
						VOC.play("b2b",CHN)
					end
				else
					P:showText(text.spin[P.cur.name]..text.clear[cc],0,-30,45,"spin")
					atk=2*cc
				end
				sendTime=20+atk*20
				if mini then
					P:showText(text.mini,0,-80,35,"appear")
					atk=atk*.5
					sendTime=sendTime+60
					cscore=cscore*.6
					P.b2b=P.b2b+b2bPoint[cc]*.5
					if P.human then
						VOC.play("mini",CHN)
					end
				else
					P.b2b=P.b2b+b2bPoint[cc]
				end
				P.lastClear=P.cur.id*10+cc
				if P.human then
					SFX.play(spin_n[cc])
					VOC.play(spinName[P.cur.name],CHN)
				end
			elseif not clear then
				P.b2b=max(P.b2b-250,0)
				P:showText(text.clear[cc],0,-30,27+cc*3,"appear",(8-cc)*.3)
				atk=cc-.75
				sendTime=20+atk*20
				cscore=cscore+clearSCR[cc]
				P.lastClear=cc
			end
			if P.human then
				VOC.play(clearName[cc],CHN)
			end
		end
		sendTime=sendTime+25*cmb
		if cmb>2 then
			atk=atk+(comboAtk[cmb]or 2)
			P:showText(text.cmb[min(cmb,20)],0,25,15+min(cmb,25)*3,cmb<10 and"appear"or"flicker")
			cscore=cscore+min(20*cmb,300)*cc
		end
		if clear then
			if #P.field==0 then
				P:showText(text.PC,0,-80,50,"flicker")
				atk=atk^.5+min(6+STAT.pc,10)
				exblock=exblock+2
				sendTime=sendTime+120
				if STAT.row+cc>4 then
					P.b2b=1200
					cscore=cscore+300*min(6+STAT.pc,10)
				else
					cscore=cscore+626
				end
				STAT.pc=STAT.pc+1
				P.lastClear=P.cur.id*10+5
				if P.human then
					SFX.play("clear")
					VOC.play("pc",CHN)
				end
			elseif cc>1 or #P.field==P.garbageBeneath then
				P:showText(text.HPC,0,-80,50,"fly")
				atk=atk+2
				exblock=exblock+2
				sendTime=sendTime+60
				cscore=cscore+626
				STAT.hpc=STAT.hpc+1
				P.lastClear=cc
				if P.human then
					SFX.play("clear")
					VOC.play("pc",CHN)
				end
			end
		end
		if P.human then
			SFX.play(clear_n[cc])
			SFX.play(ren_n[min(cmb,11)])
			if cmb>14 then SFX.play("ren_mega",(cmb-10)*.1)end
			VIB(cc+1)
		end
		if P.b2b>1200 then P.b2b=1200 end

		if modeEnv.royaleMode then
			local i=min(#P.atker,9)
			if i>1 then
				atk=atk+reAtk[i]
				exblock=exblock+reDef[i]
			end
		end--Bonus atk/def when focused
		local send=atk
		if send>0 then
			--ATK statistics
			if exblock then exblock=int(exblock*(1+P.strength*.25))end
			send=int(send*(1+P.strength*.25))
			--Badge Buff
			if send==0 then goto L end
				P:showText(send,0,80,35,"zoomout")
			if exblock==0 then goto L end
				P:showText(exblock,0,120,20,"zoomout")
			::L::
			send=send+exblock
			local k=0
			::R::
			if P.atkBuffer.sum>0 and send>0 then
				::F::
					k=k+1
					local A=P.atkBuffer[k]
					if not A then goto E end
				if A.sent then goto F end
				if send>=A.amount then
					send=send-A.amount
					P.atkBuffer.sum=P.atkBuffer.sum-A.amount
					A.sent,A.time=true,0
					if send>0 then goto R end
				else
					A.amount=A.amount-send
					P.atkBuffer.sum=P.atkBuffer.sum-send
					send=0
				end
			end
			::E::
			send=send-exblock
			if send>0 then
				local T
				if modeEnv.royaleMode then
					if P.atkMode==4 then
						local M=#P.atker
						if M>0 then
							for i=1,M do
								P:garbageSend(P.atker[i],send,sendTime,M,P.cur.color,P.lastClear,dospin,mini,cmb)
							end
						else
							T=randomTarget(P)
						end
					else
						P:freshTarget()
						T=P.atking
					end
				elseif #players.alive>1 then
					T=randomTarget(P)
				end
				if T then
					P:garbageSend(T,send,sendTime,1,P.cur.color,P.lastClear,dospin,mini,cmb)
				end
				if P.human and send>3 then SFX.play("emit",min(send,8)*.1)end
			end
		end
	else
		cmb=0
		local dropScore=10
		if dospin then
			P:showText(text.spin[P.cur.name],0,-30,45,"appear")
			P.b2b=P.b2b+20
			if P.human then
				SFX.play("spin_0")
				VOC.play(spinName[P.cur.name],CHN)
			end
			dropScore=25--spin bonus
		end

		if P.gameEnv._20G then
			dropScore=dropScore*2
		elseif P.gameEnv.drop<3 then
			dropScore=dropScore*1.5
		end--dropSpeed bonus

		if P.dropSpeed>60 then
			dropScore=dropScore*P.dropSpeed/60
		elseif P.dropSpeed>120 then
			dropScore=dropScore*1,2*P.dropSpeed/120
		elseif P.dropSpeed>180 then
			dropScore=dropScore*1.5*P.dropSpeed/180
		end--speed bonus

		cscore=cscore+dropScore
		if P.b2b>1000 then
			P.b2b=max(P.b2b-40,1000)
		end
		P:garbageRelease()
	end
	P.combo=cmb

	local n=P.cur.name
	if dospin then
		_=STAT.spin[n]	_[cc+1]=_[cc+1]+1--spin[1/2/3/4/5/6/7][0/1/2/3]
		_=STAT.spin_S	_[cc+1]=_[cc+1]+1--spin[0/1/2/3]
		_=STAT.spin_B	_[n]=_[n]+1--spin[1/2/3/4/5/6/7]
	elseif cc>0 then
		_=STAT.clear[n]	_[cc]=_[cc]+1--clear[1/2/3/4/5/6/7][1/2/3/4]
		_=STAT.clear_S	_[cc]=_[cc]+1--clear[1/2/3/4]
		_=STAT.clear_B	_[n]=_[n]+1--clear[1/2/3/4/5/6/7]
	end

	STAT.score=STAT.score+int(cscore)
	STAT.piece=STAT.piece+1
	STAT.row=STAT.row+cc
	STAT.atk=STAT.atk+atk
	STAT.send=STAT.send+send
	if gbcc>0 then
		STAT.dig=STAT.dig+gbcc
		STAT.digatk=STAT.digatk+atk*gbcc/cc
	end
	--Update stat
	_=P.gameEnv.dropPiece
	if _ then _(P)end
	--drop event
	if P.human then SFX.play("lock",nil,getBlockPosition(P))end
	--stereo SFX
end
function player.pressKey(P,i)
	P.keyPressing[i]=true
	P.act[actName[i]](P)
	if P.control then
		if P.keyRec then
			ins(P.keyTime,1,frame)
			P.keyTime[11]=nil
		end
		P.stat.key=P.stat.key+1
	end
	--ins(rec,{i,frame})
end
function player.releaseKey(P,i)
	if P.keyPressing[i]then
		P.keyPressing[i]=false
		-- if recording then ins(rec,{-i,frame})end
	end
end
-------------------------</Methods>-------------------------

--------------------------<Events>--------------------------
local function gameOver()
	FILE.saveData()
	local M=curMode
	local R=M.getRank
	if R then
		local P=players[1]
		R=R(P)--new rank
		if R then
			local r=modeRanks[M.id]--old rank
			if R>r then
				modeRanks[M.id]=R
				if r==0 then
					for i=1,#M.unlock do
						local m=M.unlock[i]
						if not modeRanks[m]then
							modeRanks[m]=modes[m].score and 0 or 6
						end
					end
				end
				FILE.saveUnlock()
			end
			local D=M.score(P)
			local L=M.records
			local p=#L--排名数-1
			if p>0 then
				::L::
				if M.comp(D,L[p])then--是否靠前
					p=p-1
					if p>0 then
						goto L
					end
				end
			end
			if p<10 then
				if p==0 then
					P:showTextF(text.newRecord,0,-100,100,"beat",.5)
				end
				D.date=os.date("%Y/%m/%d %H:%M")
				ins(L,p+1,D)
				if L[11]then L[11]=nil end
				FILE.saveRecord(M.saveFileName,L)
			end
		end
	end
end--Save record
function player.die(P)--Same thing when win/lose,not really die!
	P.alive=false
	P.timing=false
	P.control=false
	P.update=Pupdate_dead
	P.waiting=1e99
	P.b2b=0
	TASK.clear(P)
	for i=1,#P.atkBuffer do
		P.atkBuffer[i].sent=true
		P.atkBuffer[i].time=0
	end
	for i=1,#P.field do
		for j=1,10 do
			P.visTime[i][j]=min(P.visTime[i][j],20)
		end
	end
end
function player.reach_winCheck(P)
	if P.stat.row>=P.gameEnv.target then
		P:win("finish")
	end
end
function player.win(P,result)
	P:die()
	P.result="WIN"
	if modeEnv.royaleMode then
		P.modeData.event=1
		P:changeAtk()
	end
	if P.human then
		gameResult=result or"win"
		SFX.play("win")
		VOC.play("win")
		if modeEnv.royaleMode then
			BGM.play("8-bit happiness")
		end
	end
	TASK.new(tickEvent.finish,P)
	if curMode.id=="custom_puzzle"then
		P:showTextF(text.win,0,0,90,"beat",.4)
	else
		P:showTextF(text.win,0,0,90,"beat",.5,.2)
	end
	if P.human then
		gameOver()
	end
end
function player.lose(P)
	if P.life>0 then
		for _=#P.field,1,-1 do
			freeRow.discard(P.field[_])
			freeRow.discard(P.visTime[_])
			P.field[_],P.visTime[_]=nil
		end
		if P.AI_mode=="CC"then
			P.AI_needFresh=true
		end
		P.life=P.life-1
		return
	end
	P:die()
	for i=1,#players.alive do
		if players.alive[i]==P then
			rem(players.alive,i)
			break
		end
	end
	P.result="K.O."
	if modeEnv.royaleMode then
		P:changeAtk()
		P.modeData.event=#players.alive+1
		P:showTextF(P.modeData.event,0,-120,60,"appear",1,12)
		P.strength=0
		if P.lastRecv then
			local A,i=P,0
			repeat
				A,i=A.lastRecv,i+1
			until not A or A.alive or A==P or i==3
			if A and A.alive then
				if P.id==1 or A.id==1 then
					P.killMark=A.id==1
				end
				A.modeData.point,A.badge=A.modeData.point+1,A.badge+P.badge+1
				for i=A.strength+1,4 do
					if A.badge>=royaleData.powerUp[i]then
						A.strength=i
					end
				end
				P.lastRecv=A
				if P.id==1 or A.id==1 then
					TASK.new(tickEvent.throwBadge,A,{P,max(3,P.badge)*4})
				end
				freshMostBadge()
			end
		else
			P.badge=-1
		end
		freshMostDangerous()
		for i=1,#players.alive do
			if players.alive[i].atking==P then
				players.alive[i]:freshTarget()
			end
		end
		if #players.alive==royaleData.stage[gameStage]then
			royaleLevelup()
		end
	end
	P.gameEnv.keepVisible=P.gameEnv.visible~="show"
	P:showTextF(text.lose,0,0,90,"appear",.5,.2)
	if P.human then
		gameResult="lose"
		SFX.play("fail")
		VOC.play("lose")
		if modeEnv.royaleMode then BGM.play("end")end
	end
	if #players.alive==1 then
		players.alive[1]:win()
	end
	if #players==1 or(P.human and not players[2].human)then
		gameOver()
	end
	TASK.new(#players>1 and tickEvent.lose or tickEvent.finish,P)
end
-------------------------<\Events>--------------------------

-------------------------<Controls>-------------------------
player.act={}
function player.act.moveLeft(P,auto)
	if not auto then
		P.ctrlCount=P.ctrlCount+1
	end
	P.movDir=-1
	if P.keyPressing[9]then
		if P.gameEnv.swap then
			P:changeAtkMode(1)
		end
	elseif P.control and P.waiting==-1 then
		if not P:ifoverlap(P.cur.bk,P.curX-1,P.curY)then
			P.curX=P.curX-1
			local y0=P.curY
			P:freshgho()
			if P.gameEnv.easyFresh or y0~=P.curY then P:freshLockDelay()end
			if P.human and P.curY==P.y_img then SFX.play("move")end
			if not auto then P.moving=0 end
			P.spinLast=false
		else
			P.moving=P.gameEnv.das
		end
	else
		P.moving=0
	end
end
function player.act.moveRight(P,auto)
	if not auto then
		P.ctrlCount=P.ctrlCount+1
	end
	P.movDir=1
	if P.keyPressing[9]then
		if P.gameEnv.swap then
			P:changeAtkMode(2)
		end
	elseif P.control and P.waiting==-1 then
		if not P:ifoverlap(P.cur.bk,P.curX+1,P.curY)then
			P.curX=P.curX+1
			local y0=P.curY
			P:freshgho()
			if P.gameEnv.easyFresh or y0~=P.curY then P:freshLockDelay()end
			if P.human and P.curY==P.y_img then SFX.play("move")end
			if not auto then P.moving=0 end
			P.spinLast=false
		else
			P.moving=P.gameEnv.das
		end
	else
		P.moving=0
	end
end
function player.act.rotRight(P)
	if P.control and P.waiting==-1 then
		P.ctrlCount=P.ctrlCount+1
		P:spin(1)
		P.keyPressing[3]=false
	end
end
function player.act.rotLeft(P)
	if P.control and P.waiting==-1 then
		P.ctrlCount=P.ctrlCount+1
		P:spin(3)
		P.keyPressing[4]=false
	end
end
function player.act.rot180(P)
	if P.control and P.waiting==-1 then
		P.ctrlCount=P.ctrlCount+2
		P:spin(2)
		P.keyPressing[5]=false
	end
end
function player.act.hardDrop(P)
	if P.keyPressing[9]then
		if P.gameEnv.swap then
			P:changeAtkMode(3)
		end
		P.keyPressing[6]=false
	elseif P.control and P.waiting==-1 then
		if P.curY~=P.y_img then
			if P.gameEnv.dropFX then
				P:createDropFX(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
			end
			P.curY=P.y_img
			P.spinLast=false
			if P.gameEnv.shakeFX then
				P.fieldOff.vy=P.gameEnv.shakeFX*.6
			end
			if P.human then
				SFX.play("drop",nil,getBlockPosition(P))
				VIB(1)
			end
		end
		P.lockDelay=-1
		P:drop()
		P.keyPressing[6]=false
	end
end
function player.act.softDrop(P)
	if P.keyPressing[9]then
		if P.gameEnv.swap then
			P:changeAtkMode(4)
		end
	else
		P.downing=1
		if P.control and P.waiting==-1 then
			if P.curY~=P.y_img then
				P.curY=P.curY-1
				P.spinLast=false
			end
		end
	end
end
function player.act.hold(P)
	if P.control and P.waiting==-1 then
		P:hold()
	end
end
function player.act.func(P)
	P.gameEnv.Fkey(P)
end
function player.act.restart(P)
	if P.gameEnv.quickR or frame<180 then
		TASK.clear("play")
		resetPartGameData()
	end
end
function player.act.insLeft(P,auto)
	if P.gameEnv.nofly then return end
	local x0,y0=P.curX,P.curY
	while not P:ifoverlap(P.cur.bk,P.curX-1,P.curY)do
		P.curX=P.curX-1
		if P.gameEnv.dropFX then
			P:createDropFX(P.curX+P.c,P.curY+P.r-1,P.curX+P.c,P.curY)
		end
		P:freshgho()
	end
	if x0~=P.curX then
		if P.gameEnv.easyFresh or y0~=P.curY then P:freshLockDelay()end
	end
	if P.gameEnv.shakeFX then
		P.fieldOff.vx=-P.gameEnv.shakeFX*.5
	end
	if auto then
		if P.ctrlCount==0 then P.ctrlCount=1 end
	else
		P.ctrlCount=P.ctrlCount+1
	end
end
function player.act.insRight(P,auto)
	if P.gameEnv.nofly then return end
	local x0,y0=P.curX,P.curY
	while not P:ifoverlap(P.cur.bk,P.curX+1,P.curY)do
		P.curX=P.curX+1
		if P.gameEnv.dropFX then
			P:createDropFX(P.curX-1,P.curY+P.r-1,P.curX-1,P.curY)
		end
		P:freshgho()
	end
	if x0~=P.curX then
		if P.gameEnv.easyFresh or y0~=P.curY then P:freshLockDelay()end
	end
	if P.gameEnv.shakeFX then
		P.fieldOff.vx=P.gameEnv.shakeFX*.5
	end
	if auto then
		if P.ctrlCount==0 then P.ctrlCount=1 end
	else
		P.ctrlCount=P.ctrlCount+1
	end
end
function player.act.insDown(P)
	if P.curY~=P.y_img then
		if P.gameEnv.dropFX then
			P:createDropFX(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
		end
		if P.gameEnv.shakeFX then
			P.fieldOff.vy=P.gameEnv.shakeFX*.5
		end
		P.curY,P.lockDelay,P.spinLast=P.y_img,P.gameEnv.lock,false
	end
end
function player.act.down1(P)
	if P.curY~=P.y_img then
		P.curY=P.curY-1
		P.spinLast=false
	end
end
function player.act.down4(P)
	for _=1,4 do
		if P.curY~=P.y_img then
			P.curY=P.curY-1
			P.spinLast=false
		else
			break
		end
	end
end
function player.act.down10(P)
	for _=1,10 do
		if P.curY~=P.y_img then
			P.curY=P.curY-1
			P.spinLast=false
		else
			break
		end
	end
end
function player.act.dropLeft(P)
	if P.gameEnv.nofly then return end
	P.act.insLeft(P)
	P.act.hardDrop(P)
end
function player.act.dropRight(P)
	if P.gameEnv.nofly then return end
	P.act.insRight(P)
	P.act.hardDrop(P)
end
function player.act.addLeft(P)
	if P.gameEnv.nofly then return end
	P.act.insLeft(P)
	P.act.insDown(P)
	P.act.insRight(P)
	P.act.hardDrop(P)
end
function player.act.addRight(P)
	if P.gameEnv.nofly then return end
	P.act.insRight(P)
	P.act.insDown(P)
	P.act.insLeft(P)
	P.act.hardDrop(P)
end
-------------------------</Controls>-------------------------
function newDemoPlayer(id,x,y,size)
	local P={id=id}players[id]=P
	P.life=1e99
	for k,v in next,player do P[k]=v end
	players.alive[#players.alive+1]=P
	P.x,P.y,P.size=x,y,size
	P.fieldOff={x=0,y=0,vx=0,vy=0}
	P.small,P.keyRec=false,false
	P.draw=Pdraw_demo
	P.update=Pupdate_alive

	P.centerX,P.centerY=P.x+300*P.size,P.y+600*P.size
	P.absFieldX=P.x+150*P.size
	P.absFieldY=P.y+60*P.size

	P.alive=true
	P.control=true
	P.timing=false
	P.stat={
		time=0,score=0,
		key=0,rotate=0,hold=0,
		extraPiece=0,extraRate=0,
		piece=0,row=0,dig=0,
		atk=0,digatk=0,send=0,recv=0,pend=0,
		clear_S={0,0,0,0},clear_B={0,0,0,0,0,0,0},
		spin_S={0,0,0,0},spin_B={0,0,0,0,0,0,0},
		clear={{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}},
		spin={{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}},
		pc=0,hpc=0,b2b=0,b3b=0,
	}
	P.modeData={point=0,event=0,counter=0}
	P.keyTime={}P.keySpeed=0
	P.dropTime={}P.dropSpeed=0

	P.atker={}P.strength=0

	P.field,P.visTime={},{}
	P.atkBuffer={sum=0}
	P.gameEnv={
		noFly=false,
		das=10,arr=2,
		sddas=2,sdarr=2,
		quickR=true,swap=true,
		ghost=setting.ghost,center=setting.center,
		smooth=setting.smooth,grid=setting.grid,
		text=setting.text,
		lockFX=setting.lockFX,dropFX=setting.dropFX,
		shakeFX=setting.shakeFX,

		_20G=false,bone=false,
		drop=1e99,lock=1e99,
		wait=10,fall=20,
		next=6,hold=true,
		oncehold=true,
		ospin=true,
		sequence="bag7",
		face={0,0,0,0,0,0,0},
		skin=setting.skin,

		pushSpeed=3,
		block=true,
		visible="show",
		Fkey=nil,puzzle=false,
		freshLimit=1e99,easyFresh=true,
		fine=false,fineKill=false,
		target=1e99,dropPiece=NULL,
		mindas=0,minarr=0,minsdarr=0,
	}
	local ENV=P.gameEnv
	if ENV.lockFX==0 then	ENV.lockFX=nil	end
	if ENV.dropFX==0 then	ENV.dropFX=nil	end
	if ENV.shakeFX==0 then	ENV.shakeFX=nil	end
	P.color={}
	for _=1,7 do
		P.color[_]=skin.libColor[ENV.skin[_]]
	end
	P.cur={bk={{}},id=0,color=0,name=0}
		P.sc,P.dir,P.r,P.c={0,0},0,0,0
		P.curX,P.curY,P.y_img=0,0,0
	P.hd={bk={{}},id=0,color=0,name=0}
		P.holded=false
	P.next={}

	P.dropDelay,P.lockDelay=1e99,1e99
	P.freshTime=0
	P.spinLast,P.lastClear=false,nil
	P.spinSeq=0
	P.ctrlCount=0

	freshPrepare.bag7(P)
	P.newNext=freshMethod.bag7

	P.human=false
	P.AI_mode="CC"
	P.AI_stage=1
	P.AI_needFresh=false
	P.AI_keys={}
	P.AI_delay,P.AI_delay0=3,3
	P.AIdata={next=5,hold=true,_20G=false,bag7=true,node=80000}
	if not BOT then P.AI_mode="9S"end
	if P.AI_mode=="CC"then
		P.RS=kickList.AIRS
		local opt,wei=BOT.getConf()
			BOT.setHold(opt,P.AIdata.hold)
			BOT.set20G(opt,P.AIdata._20G)
			BOT.setBag(opt,P.AIdata.bag7)
			BOT.setNode(opt,P.AIdata.node)
		P.AI_bot=BOT.new(opt,wei)
		BOT.free(opt)BOT.free(wei)
		local CCBID={4,3,5,6,1,2,0}
		for i=1,5 do
			BOT.addNext(P.AI_bot,CCBID[P.next[i].id])
		end
	elseif P.AI_mode=="9S"then
		P.RS=kickList.TRS
	end
	P.showTime=1e99
	P.keepVisible=true
	P.keyPressing={}for i=1,12 do P.keyPressing[i]=false end
	P.movDir,P.moving,P.downing=0,0,0
	P.waiting,P.falling=-1,-1
	P.clearingRow,P.clearedRow={},{}
	P.combo,P.b2b=0,0
	P.garbageBeneath=0
	P.fieldBeneath=0
	P.score1,P.b2b1=0,0
	P.dropFX,P.lockFX={},{}
	P.bonus={}
	P.dust=clearDust:clone()
	P.dust:start()

	P:popNext()
end
function newPlayer(id,x,y,size,AIdata)
	players[id]={id=id}
	local P=players[id]
	P.life=0
	for k,v in next,player do P[k]=v end--inherit functions of player class
	players.alive[#players.alive+1]=P
	P.x,P.y,P.size=x,y,size or 1
	P.fieldOff={x=0,y=0,vx=0,vy=0}--for shake FX
	P.small=P.size<.1--if draw in small mode
	if P.small then
		P.centerX,P.centerY=P.x+300*P.size,P.y+600*P.size
		P.canvas=love.graphics.newCanvas(60,120)
		P.frameWait=rnd(30,120)
		P.draw=Pdraw_small
	else
		P.keyRec=true--if calculate keySpeed
		P.centerX,P.centerY=P.x+300*P.size,P.y+370*P.size
		P.absFieldX=P.x+150*P.size
		P.absFieldY=P.y+60*P.size
		P.draw=Pdraw_norm
		P.dust=clearDust:clone()
		P.dust:start()
		P.bonus={}--texts
	end
	P.update=Pupdate_alive

	P.alive=true
	P.control=false
	P.timing=false
	P.stat={
		time=0,score=0,
		key=0,rotate=0,hold=0,
		extraPiece=0,extraRate=0,
		piece=0,row=0,dig=0,
		atk=0,digatk=0,send=0,recv=0,pend=0,
		clear_S={0,0,0,0},clear_B={0,0,0,0,0,0,0},
		spin_S={0,0,0,0},spin_B={0,0,0,0,0,0,0},
		clear={{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}},
		spin={{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}},
		pc=0,hpc=0,b2b=0,b3b=0,
	}--Current gamestat
	P.modeData={point=0,event=0,counter=0}--data use by mode
	P.keyTime={}for i=1,10 do P.keyTime[i]=-1e5 end P.keySpeed=0
	P.dropTime={}for i=1,10 do P.dropTime[i]=-1e5 end P.dropSpeed=0

	P.field,P.visTime={},{}
	P.atkBuffer={sum=0}

	P.badge,P.strength=0,0
	P.atkMode,P.swappingAtkMode=1,20
	P.atker,P.atking,P.lastRecv={}
	--Royale-related

	P.gameEnv={}--Current game setting environment
	local ENV=P.gameEnv
	for k,v in next,gameEnv0 do
		if modeEnv[k]~=nil then
			v=modeEnv[k]
		elseif setting[k]~=nil then
			v=setting[k]
		end
		ENV[k]=v
	end--load game settings
	ENV.das=max(ENV.das,ENV.mindas)
	ENV.arr=max(ENV.arr,ENV.minarr)
	ENV.sdarr=max(ENV.sdarr,ENV.minsdarr)

	P.cur={bk={{}},id=0,color=0,name=0}--shape,shapeID,colorID,nameID
		P.sc,P.dir,P.r,P.c={0,0},0,0,0--IMG.spinCenter,direction,row,col
		P.curX,P.curY,P.y_img=0,0,0--x,y,ghostY
	P.hd={bk={{}},id=0,color=0,name=0}
		P.holded=false
	P.next={}

	P.dropDelay,P.lockDelay=ENV.drop,ENV.lock
	P.freshTime=0
	P.spinLast,P.lastClear=false,nil
	P.spinSeq=0--for Ospin,each digit mean a spin
	P.ctrlCount=0--key press time,for finesse check

	freshPrepare[ENV.sequence](P)
	P.newNext=freshMethod[ENV.sequence]

	if AIdata then
		ENV.face={0,0,0,0,0,0,0}
		ENV.skin={1,5,2,8,10,3,7}
		P.human=false
		P.AI_mode=AIdata.type
		P.AI_stage=1
		P.AI_needFresh=false
		P.AI_keys={}
		P.AI_delay=min(int(ENV.drop*.8),2*AIdata.delta)
		P.AI_delay0=AIdata.delta
		P.AIdata={
			next=AIdata.next,
			hold=AIdata.hold,
			_20G=ENV._20G,
			bag7=AIdata.bag7=="bag7",
			node=AIdata.node,
		}
		if not BOT then P.AI_mode="9S"end
		if P.AI_mode=="CC"then
			P.RS=kickList.AIRS
			local opt,wei=BOT.getConf()
				BOT.setHold(opt,P.AIdata.hold)
				BOT.set20G(opt,P.AIdata._20G)
				BOT.setBag(opt,P.AIdata.bag7)
				BOT.setNode(opt,P.AIdata.node)
			P.AI_bot=BOT.new(opt,wei)
			BOT.free(opt)BOT.free(wei)
			for i=1,AIdata.next do
				BOT.addNext(P.AI_bot,CCblockID[P.next[i].id])
			end
		elseif P.AI_mode=="9S"then
			P.RS=kickList.TRS
			P.AI_keys={}
		end
	else
		P.human=true
		P.RS=kickList.TRS
		players.human=players.human+1
		ENV.next=min(ENV.next,setting.maxNext)
	end
	
	if P.small then
		ENV.text=false
		ENV.lockFX=nil
		ENV.dropFX=nil
		ENV.shakeFX=nil
	else
		if ENV.lockFX==0 then	ENV.lockFX=nil	end
		if ENV.dropFX==0 then	ENV.dropFX=nil	end
		if ENV.shakeFX==0 then	ENV.shakeFX=nil	end
	end

	P.color={}
	for _=1,7 do
		P.color[_]=skin.libColor[ENV.skin[_]]
	end

	P.showTime=visible_opt[ENV.visible]
	P.keepVisible=ENV.visible=="show"


	P.keyPressing={}for i=1,12 do P.keyPressing[i]=false end
	P.movDir,P.moving,P.downing=0,0,0--last move key,DAS charging,downDAS charging
	P.waiting,P.falling=-1,-1
	P.clearingRow,P.clearedRow={},{}--clearing animation height,cleared row mark
	P.combo,P.b2b=0,0
	P.garbageBeneath=0
	P.fieldBeneath=0

	P.score1,P.b2b1=0,0
	P.dropFX,P.lockFX={},{}
	P.bonus={}--texts

	P.endCounter=0--used after gameover
	P.result=nil--string:"WIN"/"K.O."
end