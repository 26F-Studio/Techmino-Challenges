return{
    env={
        drop=60,lock=60,
        eventSet='checkLine_10',
        bg='bg2',bgm='race',
    },
    score=function(P)return{P.stat.time,P.stat.piece}end,
    scoreDisp=function(D)return STRING.time(D[1]).."   "..D[2].." Pieces"end,
    comp=function(a,b)return a[1]<b[1]or a[1]==b[1]and a[2]<b[2]end,
    getRank=function(P)
        if P.stat.row<10 then return end
        local T=P.stat.time
        return
        CHALLENGE==7 and
        (
            T<=4.6666 and 5 or
            T<=6.6666 and 4 or
            T<=16.666 and 3 or
            T<=26.666 and 2 or
            T<=41.333 and 1 or
            0
        )
        or
        (
            T<=7 and 5 or
            T<=10 and 4 or
            T<=25 and 3 or
            T<=40 and 2 or
            T<=62 and 1 or
            0
        )
    end,
}
