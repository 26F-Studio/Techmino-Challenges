return{
    env={
        life=2,
        drop=60,lock=60,
        freshLimit=15,
        bg='bg2',bgm='battle',
    },
    load=function()
        PLY.newPlayer(1)
        PLY.newAIPlayer(2,BOT.template{type='9S',speedLV=6,hold=true})
    end,
    score=function(P)return{P.stat.time}end,
    scoreDisp=function(D)return STRING.time(D[1])end,
    comp=function(a,b)return a[1]<b[1]end,
    getRank=function(P)
        if P.result=='win'then
            local T=P.stat.time
            return
            CHALLENGE==7 and
            (
                T<=33.333 and 5 or
                T<=53.333 and 4 or
                T<=80.000 and 3 or
                T<=120.00 and 2 or
                1
            )
            or
            (
                T<=50 and 5 or
                T<=80 and 4 or
                T<=120 and 3 or
                T<=180 and 2 or
                1
            )
        end
    end,
}
