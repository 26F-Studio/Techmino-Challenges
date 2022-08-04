local gc=love.graphics
local gc_setColor=gc.setColor
local gc_rectangle=gc.rectangle
local gc_print,gc_printf=gc.print,gc.printf

local kb=love.keyboard
local setFont=FONT.set
local fs=love.filesystem
local initIdentity=fs.getIdentity()

local listBox=WIDGET.newListBox{name='list',x=50,y=50,w=1200,h=520,lineH=40,drawF=function(chal,id,ifSel)
    if ifSel then
        gc_setColor(1,1,1,.3)
        gc_rectangle('fill',0,0,1200,40)
    end

    setFont(30)
    gc_setColor(.8,.8,.8)

    gc_setColor(.9,.9,1)
    local chalName=text.challenges[chal]
    gc_print(chalName and chalName[2] or "[C"..chal.."]",310,0)

    setFont(20)
    if CHALLENGE==chal then
        gc_setColor(0,0,1,.15)
        gc_rectangle('fill',0,0,1200,40)
        gc_setColor(1,0,0)
        gc_print(text.currentChallenge,6,6)
    end
    gc_setColor(1,1,.8)
    gc_print(chalName and chalName[1],80,6)
    gc_setColor(COLOR.Z)
    gc_printf(chalName[3],0,6,1190,'right')
end}

local function ReloadData()
    -- make directories
    for _,v in next,{'conf','record','replay','cache','lib'}do
        local info=fs.getInfo(v)
        if not info then
            fs.createDirectory(v)
        elseif info.type~='directory'then
            fs.remove(v)
            fs.createDirectory(v)
        end
    end

    -- load unlocks
    if not 
        pcall(TABLE.cover, loadFile('conf/unlock',    '-json -canSkip')or loadFile('conf/unlock',    '-luaon -canSkip')or{},RANKS)
    then
        MES.new('error',"An error occured when loading the savefile and some data was lost.")
    end

    --load replays
    REPLAY={}
    for _,fileName in next,fs.getDirectoryItems('replay')do
        if fileName:sub(12,12):match("[a-zA-Z]")then
            local date,mode,version,player,seed,setting,mod
            local fileData=fs.read('replay/'..fileName)
            date,   fileData=STRING.readLine(fileData)date=date:gsub("[a-zA-Z]","")
            mode,   fileData=STRING.readLine(fileData)mode=MODE_UPDATE_MAP[mode]or mode
            version,fileData=STRING.readLine(fileData)
            player, fileData=STRING.readLine(fileData)if player=="Local Player"then player="Stacker"end
            local success
            success,fileData=pcall(love.data.decompress,'string','zlib',fileData)
            if not success then goto BREAK_cannotParse end
            seed,   fileData=STRING.readLine(fileData)
            setting,fileData=STRING.readLine(fileData)setting=JSON.decode(setting)
            mod,    fileData=STRING.readLine(fileData)mod=JSON.decode(mod)
            if
                not setting or
                not mod or
                not mode or
                #mode==0
            then goto BREAK_cannotParse end
    
            fs.remove('replay/'..fileName)
            local newName=fileName:sub(1,10)..fileName:sub(15)
            fs.write('replay/'..newName,
                love.data.compress('string','zlib',
                    JSON.encode{
                        date=date,
                        mode=mode,
                        version=version,
                        player=player,
                        seed=seed,
                        setting=setting,
                        mod=mod,
                    }.."\n"..
                    fileData
                )
            )
            fileName=newName
        end
        ::BREAK_cannotParse::
        local rep=DATA.parseReplay('replay/'..fileName)
        table.insert(REPLAY,rep)
    end
    table.sort(REPLAY,function(a,b)return a.fileName>b.fileName end)
end

local scene={}

function scene.sceneInit()
    BG.set()
    local chalList={}
    for i=0,#text.challenges do chalList[i+1]=i end
    listBox:setList(chalList)
    local hide=listBox:getLen()==0
end

function scene.keyDown(key)
    if key=='return'then
        local prevChal=CHALLENGE
        CHALLENGE=listBox:getSel()
        RANKS={sprint_10l=0}
        fs.setIdentity(CHALLENGE~=0 and "TechC"..CHALLENGE or initIdentity)
        ReloadData()
        if prevChal==CHALLENGE then goto after_msg
        elseif prevChal==0 then MES.new('info',text.challengeApplied:gsub("$1",CHALLENGE))
        elseif CHALLENGE==0 then MES.new('info',text.challengeUnapplied)
        else MES.new('info',text.challengeSwitched:gsub("$1",CHALLENGE))
        end
        ::after_msg::
        backScene()
    elseif key=='up'or key=='down'then listBox:arrowKey(key)
    else return true end
end

scene.widgetList={
    listBox,
    WIDGET.newButton{name='start',  x=640,y=640,w=170,h=80,color='lY',code=pressKey'return',font=65,fText=CHAR.icon.play},
    WIDGET.newButton{name='back',  x=1140,y=640,w=170,h=80,sound='back',font=60,fText=CHAR.icon.back,code=backScene},
}

return scene
