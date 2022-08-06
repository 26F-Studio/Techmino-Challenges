return{
    env={
        pushSpeed=6,
        eventSet='dig_100l',
        bg='bg2',bgm='way',
    },
    score=function(P)return{P.stat.piece,P.stat.time}end,
    scoreDisp=function(D)return D[1].." Pieces   "..STRING.time(D[2]) end,
    comp=function(a,b)return a[1]<b[1]or a[1]==b[1]and a[2]<b[2]end,
    getRank=function(P)
        if P.stat.dig<100 then return end
        local P=P.stat.piece
        return
        (CHALLENGE==7 or CHALLENGE==14) and
        (
            P<=173 and 5 or
            P<=213 and 4 or
            P<=280 and 3 or
            P<=346 and 2 or
            P<=413 and 1 or
            0
        )
        or
        (
            P<=260 and 5 or
            P<=320 and 4 or
            P<=420 and 3 or
            P<=520 and 2 or
            P<=620 and 1 or
            0
        )
    end,
}
