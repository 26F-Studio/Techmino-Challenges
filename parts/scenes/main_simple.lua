local gc=love.graphics

local scene={}

local tip=gc.newText(getFont(30),"")

function scene.sceneInit()
    tip:set(text.getTip())
    BG.set()
end

function scene.draw()
    gc.setColor(1,1,1)
    mDraw(TEXTURE.title_color,640,160)
    mDraw(tip,640,660)
end

local function _loadGame(mode)
    if (CHALLENGE==1 or CHALLENGE==8 or CHALLENGE==9) and RANKS[mode]~=0 then
        MES.new('info',text.cTexts['alreadyAttempted_'..CHALLENGE])
        return
    end
    loadGame(mode,true)
end

scene.widgetList={
    WIDGET.newText{name='system',    x=750,y=280,color='Z',align='L',fText=SYSTEM},
    WIDGET.newText{name='version',   x=950,y=280,color='Z',align='L',fText=VERSION.string},
    WIDGET.newButton{name='sprint',  x=260,y=480,w=260,font=50,code=function()_loadGame('sprint_40l')end},
    WIDGET.newButton{name='marathon',x=640,y=480,w=260,font=50,code=function()_loadGame('marathon_n')end},
    WIDGET.newButton{name='setting', x=1000,y=400,w=120,font=90,fText=CHAR.icon.settings,code=goScene'setting_game'},
    WIDGET.newButton{name='lang',    x=1000,y=560,w=120,font=90,fText=CHAR.icon.language,code=goScene'lang'},
    WIDGET.newButton{name='dict',    x=1160,y=400,w=120,font=90,fText=CHAR.icon.zBook,code=goScene'dict'},
    WIDGET.newButton{name='quit',    x=1160,y=560,w=120,font=80,fText=CHAR.key.macEsc,code=function()VOC.play('bye')SCN.swapTo('quit','slowFade')end},
}

return scene
