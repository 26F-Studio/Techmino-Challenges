return{
    env={
        pushSpeed=6,
        eventSet='dig_40l',
        bg='bg1',bgm='way',
    },
    score=function(P)return{P.stat.piece,P.stat.time}end,
    scoreDisp=function(D)return D[1].." Pieces   "..STRING.time(D[2]) end,
    comp=function(a,b)return a[1]<b[1]or a[1]==b[1]and a[2]<b[2]end,
    getRank=function(P)
        if P.stat.dig<40 then return end
        local P=P.stat.piece
        return
        (CHALLENGE==7 or CHALLENGE==14) and
        (
            P<=53 and 5 or
            P<=66 and 4 or
            P<=80 and 3 or
            P<=106 and 2 or
            P<=146 and 1 or
            0
        )
        or
        (
            P<=80 and 5 or
            P<=100 and 4 or
            P<=120 and 3 or
            P<=160 and 2 or
            P<=220 and 1 or
            0
        )
    end,
}
