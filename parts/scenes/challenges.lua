local gc=love.graphics
local gc_setColor=gc.setColor
local gc_rectangle=gc.rectangle
local gc_print,gc_printf=gc.print,gc.printf

local kb=love.keyboard
local setFont=FONT.set

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
    gc_setColor(1,1,.8)
    gc_print(chalName and chalName[1],80,6)
    gc_setColor(COLOR.Z)
    gc_printf(chalName[3],0,6,1190,'right')
end}

local scene={}

function scene.sceneInit()
    BG.set()
    local chalList={}
    for i=1,#text.challenges do chalList[i]=i end
    listBox:setList(chalList)
    local hide=listBox:getLen()==0
end

function scene.keyDown(key)
    if key=='return'then
        CHALLENGE=listBox:getSel()
        MES.new("info",text.challengeApplied:gsub("$1",CHALLENGE))
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
