return{
    env={
        life=2,
        drop=60,lock=60,
        freshLimit=15,
        bg='bg2',bgm='battle',
    },
    load=function()
        PLY.newPlayer(1)
        PLY.newAIPlayer(2,BOT.template{type='CC',speedLV=6,next=2,hold=true,node=30000})
    end,
    score=function(P)return{P.stat.time}end,
    scoreDisp=function(D)return STRING.time(D[1])end,
    comp=function(a,b)return a[1]<b[1]end,
    getRank=function(P)
        if P.result=='win'then
            local L,T=P.life,P.stat.time
            return
            (CHALLENGE==7 or CHALLENGE==14) and
            (
                L>=2 and
                (
                    T<=50 and 5 or
                    T<=80 and 4 or
                    3
                ) or
                L>=1 and 2 or
                1
            )
            or
            (
                L>=2 and 5 or
                L>=1 and 4 or
                3
            )
        end
    end,
}
