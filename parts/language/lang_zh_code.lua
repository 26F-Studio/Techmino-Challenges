return {
    loadText={
        loadSFX="Load(SFX);",
        loadSample="Load(Sample);",
        loadVoice="Load(Voice);",
        loadFont="Load(Font);",
        loadModeIcon="Load(ModeIcon);",
        loadMode="Load(Mode);",
        loadOther="Load(Other);",
        finish="PressStart();",
    },
    sureQuit="SureQuit();",
    sureReset="SureReset();",
    sureDelete="SureDelete();",
    newDay="NewDay=true",
    playedLong="PlayedLong=true",
    playedTooMuch="PlayedTooMuch=true",
    settingWarn="SettingWarn();",
    settingWarn2="SettingWarn2();",

    atkModeName={"Random();","Badges();","Kills();","Back();"},
    royale_remain="LeftPlayers=$1",
    powerUp={[0]="UP=.0","UP=.25","UP=.5","UP=.75","UP=1"},
    cmb={"Combo=0","Combo=1","Combo=2","Combo=3","Combo=4","Combo=5","Combo=6","Combo=7","Combo=8","Combo=9","Combo=10","Combo=11","Combo=12","Combo=13","Combo=14","Combo=15","Combo=16","Combo=17","Combo=18","Combo=19","Combo>=20"},
    spin="_Spin.",
    spinNC="_Spin();",
    clear={"Clear(1);","Clear(2);","Clear(3);","Clear(4);","Clear(5);","Clear(6);","Clear(7);","Clear(8);","Clear(9);","Clear(10);","Clear(11);","Clear(12);","Clear(13);","Clear(14);","Clear(15);","Clear(16);","Clear(17);","Clear(18);","Clear(19);","Clear(20);","Clear(20+)"},
    cleared="",
    mini="Mini=true",b2b="B2B.",b3b="B2B2B.",
    PC="PC(All);",HPC="PC(Half);",
    replaying="Replay=true",
    tasUsing="TAS=true",

    stage="StrgePass=$1",
    great="Great();",
    awesome="Awesome();",
    almost="Almost();",
    continue="Continue();",
    maxspeed="Speed(Max);",
    speedup="Speed(Up);",
    missionFailed="Clear.Wrong();",
    infHeightOn="infHeight=true",
    infHeightOff="infHeight=false",
    infHeightHint="F1:!infHeight",
    highestGrade="(max=$1)",

    speedLV="P.SpeedLV",
    piece="P.Piece",line="P.Line",atk="P.ATK",eff="P.EFF",
    rpm="P.RPM",tsd="P.TSD",
    grade="P.Grade",techrash="P.Techrash",
    wave="P.Wave",nextWave="P.Next",
    combo="P.Combo",maxcmb="P.MaxCombo",
    pc="P.PC",ko="P.KO",

    win="Win();",
    lose="Lose();",
    torikan="Torikan();",
    finish="Result=Finish",
    gamewin="Result=Win",
    gameover="Result=GameOver",

    pause="Pause=true",
    pauseCount="PauseCount",
    finesse_ap="All.Perfect();",
    finesse_fc="Full.Combo();",

    page="Page=",

    ai_puzzle="assert(AI==true and Ctm.Mission~=true)",
    ai_mission="assert(AI==true and Ctm.Mission~=true)",
    ai_badPiece="assert(AI==true and Ctm.Seq~=Tetromino)",
    cc_fixed="assert(AI==CC and Sequence==Fixed)",
    cc_swap="assert(AI==CC and Hold.Mode==Swap)",
    cc_solid="assert(AI==CC and filledLine in Field)",
    cc_field_too_high="assert(AI==CC and Field.Height>=40)",
    switchSpawnSFX="SpawnSFX=false",
    needRestart="NeedRestart=true",

    loadError_errorMode="Error(Load.$1); Error.NoMode.$2();",
    loadError_read="Error(Load.$1); Error.ReadFailed();",
    loadError_noFile="Error(Load.$1); Error.NoFile();",
    loadError_other="Error(Load.$1); Error.LoadingFailed.$2();",
    loadError_unknown="Error(Load.$1); Error.Unknown();",

    saveError_duplicate="Error(Save.$1); Error.FileDuplicated();",
    saveError_encode="Error(Save.$1); Error.Encode();",
    saveError_other="Error(Save.$1); Error.$2();",
    saveError_unknown="SaveError($1); Error.Unknown();",

    copyDone="Copy(Done);",
    saveDone="Save(Done);",
    exportSuccess="Export(Success);",
    importSuccess="Import(Success);",
    dataCorrupted="Error.DataCorrupted();",
    pasteWrongPlace="Error.PasteWrongPlace();",
    noFile="Error.NoFile();",
    invalidSequence="Error.InvalidSequenceMode();",
    tooHighField="Error.TooHighField();",

    nowPlaying="NowPlaying=",

    VKTchW="VK.Weight.Touch",
    VKOrgW="VK.Weight.Origin",
    VKCurW="VK.Weight.CurrentPosition",

    noScore="NoScore=true",
    modeLocked="Locked=true",
    unlockHint="if (PreviousMode<=B) then Unlock();",
    highScore="HighScore",
    newRecord="NewRecord=true",

    replayBroken="Error.ReplayBroken();",

    dictNote="#!CopySource=Zictionary",



    -- Server's warn/error messages
    Techrater={},

    tooFrequent="Error.requesttooFrequent();",
    roomPasswordChanged="Info.roomPwChanged();",
    oldVersion="Version.New($1);",
    versionNotMatch="Version.NotMatch();",
    notFinished="ComingSoon();",

    noUsername="Error.NoUsername();",
    wrongEmail="Error.WrongEmail();",
    wrongCode="Error.WrongVerificationCode();",
    diffPassword="Error.DiffPassword();",
    checkEmail="register.RequestSent=true",

    wsFailed="Error.Websocket.Failed=$1",
    wsClose="Error.Websocket.Close=$1",
    netTimeout="Error.ConnectTimeOut();",
    serverDown="Error.ServerDown();",
    requestFailed="Error.RequestFailed();",

    onlinePlayerCount="OnlinePlayerCount=$1",
    createRoomSuccessed="CreateRoom.Successs=true",
    playerKicked="[$1]: roomKick([$2])",
    -- becomeHost="$1 become host",
    started="Room.Playing();",
    joinRoom="Room.Join($1);",
    leaveRoom="Room.Leave($1);",
    roomRemoved="Room.Removed();",
    ready="Ready();",
    spectating="Room.Spectating();",



    keySettingInstruction="Key.Bind(Press);\nKey.Bind.Cancel(Escspe);\nKey.Bind.Delete(Backspace);",
    customBGhelp="Ctm.BG(DropHere);",
    customBGloadFailed="Error.Ctm.BG(UnsupportFormat);",

    errorMsg="Error.Fatal();\n//请检查语法错误或向作者进行反馈。",
    tryAnotherBuild="Error.DecodeUTF8(); //如果你现在用的是Windows系统，请重新下载 Techmino-32/64位 (和现在运行的不一样的那个)。",

    modInstruction="Mod.Instruction();\n/*选择你要使用的Mod\n不同Mod会用不同的方式改变初始游戏规则(可能导致不能正常游玩)\n提醒:开启一些Mod会让成绩无效，你也可以用键盘开关Mod，按住shift反向*/",
    modInfo={
        next="Mod.Next();\n//强制使用Next的个数",
        hold="Mod.Hold\n//强制使用Hold的个数",
        hideNext="Mod.HideNext();\n//隐藏前几个Next",
        infHold="Mod.InfHold();\n//可以无限制使用Hold",
        hideBlock="Mod.HideBlock();\n//使当前方块不可见",
        hideGhost="Mod.HideGhost();\n//使提示阴影不可见",
        hidden="Mod.Hidden();\n//方块将会在锁定之后隐形",
        hideBoard="Mod.HideBoard();\n//遮挡部分或者全部场地",
        flipBoard="Mod.FlipBoard();\n//将场地以一定方式翻转显示",
        dropDelay="Mod.DropDelay();\n//强制使用下落速度(单位:帧/格)",
        lockDelay="Mod.LockDelay();\n//强制使用锁定延迟(单位:帧)",
        waitDelay="Mod.WaitDelay();\n//出块后的等待时间(单位:帧)",
        fallDelay="Mod.FallDelay();\n//消行后的等待时间(单位:帧)",
        life="Mod.Life();\n//修改初始生命数量",
        forceB2B="Mod.ForceB2B();\n//B2B条掉到启动线以下就会结束游戏",
        forceFinesse="Mod.ForceFinesse();\n//非极简操作将强制结束游戏",
        tele="Mod.Tele();\n//强制启用0移动延迟",
        noRotation="Mod.NoRot();\n//禁用旋转按键",
        noMove="Mod.NoMove();\n//禁用移动按键",
        customSeq="Mod.CtmSeq\n//强制使用某种序列",
        pushSpeed="Mod.PushSpeed();\n//改变垃圾行升起的速度(单位:格/帧)",
        boneBlock="Mod.Bone();\n//使用骨块进行游戏",
    },
    pauseStat={
        "P.Time",
        "P.Key/Rot/Hold",
        "P.Pieces",
        "P.Row/Dig",
        "P.Atk/DAtk",
        "P.Rise(P.Receive-P.Offset)",
        "P.Clear",
        "P.Spin",
        "P.B2B/B3B;P.PC/HPC",
        "P.Finesse",
    },
    radar={"DEF","OFF","ATK","SEND","SPD","DIG"},
    radarData={"D'PM","ADPM","APM","SPM","L'PM","DPM"},
    stat={
        "Stat.Launch = ",
        "Stat.Count = ",
        "Stat.Time = ",
        "Stat.Key/Rot/Hold = ",
        "Stat.Block/Row/Atk = ",
        "Stat.Recv/Offset/Rise = ",
        "Stat.Dig/DAtk = ",
        "Stat.Eff/DEff = ",
        "Stat.B2B/B3B = ",
        "Stat.PC/HPC = ",
        "Stat.FErr/FRate = ",
    },
    aboutTexts={
        "/*这只是一个普通的*方块游戏*",
        "从C2/IO/JS/WWC/KOS等方块获得过灵感",
        "",
        "使用LÖVE引擎",
        "错误或者建议请附带截图发送到内测群或者作者邮箱~",
        "仅通过官网/*见主菜单词典*/ 免费下载/更新",
        "其他渠道获得游戏皆有被修改/加广告/植入病毒的风险，程序只申请了振动&联网权限！",
        "若由于被修改的本游戏产生的各种损失作者不负责(怎么负责啊我又没法管)",
        FNNS and "/" or "请从正规途径获得最新版，游戏现为免费，不过有打赏当然感谢啦~",
        FNNS and "/" or "更多信息见小z词典*/",
    },
    staff={
        "原作者  MrZ",
        "邮箱: 1046101471@qq.com",
        "",
        "程序, 开发和设计",
        "MrZ",
        "",
        "音乐制作使用",
        "Beepbox",
        "FL Studio",
        "FL Mobile",
        "Logic Pro X",
        "",
        "[POWERED BY LÖVE]",
        "",
        "程序",
        "MrZ",
        "ParticleG",
        "Gompyn",
        "Trebor",
        "(scdhh)",
        "(FinnTenzor)",
        "(NOT_A_ROBOT)",
        "(user670)",
        "",
        "GitHub CI、封装和后端",
        "ParticleG",
        "Trebor",
        "LawrenceLiu",
        "Gompyn",
        "flaribbit",
        "scdhh",
        "",
        "视觉设计、UI和UX",
        "MrZ",
        "Gnyar",
        "C₂₉H₂₅N₃O₅",
        "ScF",
        "(旋律星萤)",
        "(T0722)",
        "",
        "插图",
        "Miya",
        "Mono",
        "Xiaoya",
        "葉枭",
        "",
        "音乐设计",
        "MrZ",
        "柒栎流星",
        "ERM",
        "Trebor",
        "C₂₉H₂₅N₃O₅",
        "(T0722)",
        "(Aether)",
        "(Hailey)",
        "",
        "音效和语音包",
        "Miya",
        "Xiaoya",
        "Mono",
        "Flore",
        "MrZ",
        "Trebor",
        "",
        "翻译和本地化",
        "User670",
        "MattMayuga",
        "Mizu",
        "Mr.Faq",
        "ScF",
        "C₂₉H₂₅N₃O₅",
        "NOT_A_ROBOT",
        "XMiao",
        "sakurw, Airun, 幽灵3383",
        "Shard Nguyễn, Squishy and TVN community",
        "",
        "演出",
        "Electric283",
        "Hebomai",
        "",
        "特别感谢",
        "Flyz",
        "Big_True",
        "NOT_A_ROBOT",
        "思竣",
        "yuhao7370",
        "Farter",
        "Teatube",
        "蕴空之灵",
        "T9972",
        "No-Usernam8",
        "andrew4043",
        "smdbs-smdbs",
        "paoho",
        "Allustrate",
        "Haoran SUN",
        "Tianling Lyu",
        "huaji2369",
        "Lexitik",
        "Tourahi Anime",
        "PopUpWaffles",
        "[All other test staff]",
        "…And You!",
    },
    used=[[
    Used.Tools=
        Beepbox
        Goldwave
        GFIE
        FL Mobile
    Used.Libs=
        Cold_Clear [MinusKelvin]
        json.lua [rxi]
        profile.lua [itraykov]
        sha2 [Egor Skriptunoff]
    ]],
    support="支持作者",
    WidgetText={
        main={
            offline="PlaySingle();",
            qplay="QPlay.",
            online="PlayMulti();",
            custom="PlayCtm();",
            setting="GameSettings();",
            stat="GameStat();",
            dict="Zictionary();",
            replays="GameReplay();",
        },
        main_simple={
            sprint="Play.Sprint(40L);",
            marathon="Play.Marathon();",
        },
        mode={
            mod="Mod(); (F1)",
            start="Play();",
        },
        mod={
            title="GameMod.UI",
            reset="Mod.Reset();",
            unranked="unranked=true",
        },
        pause={
            setting="Settings(); (S)",
            replay="Replay(Play); (P)",
            save="Replay(Save); (O)",
            resume="Resume(); (Esc)",
            restart="Restart(); (R)",
            quit="Return 0; (Q)",
            tas="TAS(); (T)",
        },
        net_menu={
            galaxim="M.Galaxim();",
            rooms="M.Rooms();",
            resetPW="M.ResetPW",
            logout="M.Logout();",
        },
        net_galaxim={
            match="GX.Enter();",
        },
        net_rooms={
            password="Password=",
            refreshing="Refrishing();",
            noRoom="NoRoom=true",
            refresh="Refresh();",
            new="NewRoom();",
            join="Join();",
        },
        net_newRoom={
            title="NewRoom.UI",
            roomName="RoomName //Default = [username]'s room",
            password="Password",
            description="Description",

            life="Life",
            pushSpeed="PushSpeed",
            garbageSpeed="GarbageSpeed",
            visible="Visiblity",
            freshLimit="FreshLimit",

            fieldH="FieldHeight",
            bufferLimit="BufferLimit",
            heightLimit="HeightLimit",

            drop="DropDelay",
            lock="LockDelay",
            wait="EntryDelay",
            fall="LineDelay",
            hang="DeathDelay",
            hurry="AREInterruption",

            capacity="Capacity",
            create="Create();",

            ospin="OSpin",
            fineKill="FineKill",
            b2bKill="B2BKill",
            lockout="Lockout",
            easyFresh="EZFresh",
            deepDrop="DeepDrop",
            bone="Bone",

            eventSet="EventSet",

            holdMode="HoldMode",
            nextCount="Next=",
            holdCount="Hold=",
            infHold="InfHold",
            phyHold="PhyHold",
        },
        net_game={
            ready="Ready();",
            spectate="Spectate();",
            cancel="Cancel();",
        },
        setting_game={
            title="GameSettings.UI",
            graphic="←Set.Video();",
            sound="Set.Sound();→",
            style="Style();",

            ctrl="Set.Ctrl();",
            key="Set.Key();",
            touch="Set.Touch();",
            showVK="Set.ShowVK",
            reTime="Set.ReTime=",
            RS="Set.RS",
            menuPos="Set.MenuPos",
            sysCursor="Set.SysCursor",
            autoPause="Set.AutoPause",
            autoSave="Set.AutoSave",
            simpMode="Set.SimpMode",
        },
        setting_video={
            title="VideoSettings.UI",
            sound="←Set.Sound();",
            game="Set.Game();→",

            block="Set.DrawBlock",
            smooth="Set.SmoothFall",
            upEdge="Set.UpEdge",
            bagLine="Set.BagLine",

            ghostType="Set.GhostType",
            ghost="Set.Ghost=",
            center="Set.Center=",
            grid="Set.Grid=",
            lineNum="Set.LineNum=",

            lockFX="Set.LockFX=",
            dropFX="Set.DropFX=",
            moveFX="Set.MoveFX=",
            clearFX="Set.ClearFX=",
            splashFX="Set.SplashFX=",
            shakeFX="Set.ShakeFX=",
            atkFX="Set.AtkFX=",

            frame="Set.Frame //\"%\"",

            text="Set.TextPU",
            score="Set.ScorePU",
            bufferWarn="Set.BufferWarn",
            showSpike="Set.ShowSpike",
            nextPos="Set.NextPos",
            highCam="Set.HighCam",
            warn="Set.Warn",

            clickFX="Set.ClickFX",
            power="Set.Battery",
            clean="Set.QuickDraw",
            fullscreen="Set.Fullscreen",
            portrait="Set.Portrait",
            msaa="Set.MSAA",

            bg_on="Set.BG(Normal);",
            bg_off="Set.BG(Off);",
            bg_custom="Set.BG(Ctm);",
            bg_custom_base64="Set.BG(Ctm,Clipboard.get())\n-- PNG/JPG in Base64 only",
            defaultBG="Set.BG.Default=",
            resetDbg="Set.BG.Default='space'",
            lockBG="Set.BG.Lock=",
            noTheme="Set.BG.NoTheme=",

            blockSatur="Set.BlockSatur",
            fieldSatur="Set.FieldSatur",
        },
        setting_sound={
            title="MusicSettings.UI",
            game="←Set.Game();",
            graphic="Set.Video();→",

            mainVol="Set.MainVol=",
            bgm="Set.BGM=",
            sfx="Set.SFX=",
            stereo="Set.Stereo=",
            spawn="Set.SpawnSFX=",
            warn="Set.WarnSFX=",
            vib="Set.VIB=",
            voc="Set.VOC=",

            autoMute="Set.AutoMute",
            fine="Set.FineErrSFX",
            sfxPack="Set.SFXPack",
            vocPack="Set.VOCPack",
            apply="Set.Apply();",
        },
        setting_control={
            title="CtrlSettings.UI",
            preview="Set.Preview();",

            das="Set.DAS=",arr="Set.SRR=",
            dascut="Set.DASCut=",
            irscut="Set.IRSCut=",
            dropcut="Set.DropCut=",
            sddas="Set.SDDAS=",sdarr="Set.SDARR=",
            ihs="Set.IHS",
            irs="Set.IRS",
            ims="Set.IMS",
            reset="Set.Reset();",
        },
        setting_key={
            a1="SK.MLeft();",
            a2="SK.MRight();",
            a3="SK.RRight();",
            a4="SK.RLeft();",
            a5="SK.R180();",
            a6="SK.HDrop();",
            a7="SK.SDrop();",
            a8="SK.Hold();",
            a9="SK.Function1();",
            a10="SK.Function2();",
            a11="SK.ILeft();",
            a12="SK.IRight();",
            a13="SK.SonicDrop();",
            a14="SK.Down1();",
            a15="SK.Down4();",
            a16="SK.Down10();",
            a17="SK.LDrop();",
            a18="SK.RDrop();",
            a19="SK.LZangi();",
            a20="SK.RZangi();",
            restart="SK.Restart();",
        },
        setting_skin={
            skinSet="Set.SkinSet",
            title="StyleSettings.UI",
            skinR="Set.RColor();",
            faceR="Set.RDir();",
        },
        setting_touch={
            default="Set.Default();",
            snap="Set.Snap();",
            size="Set.Size=",
            shape="Set.Shape();",
        },
        setting_touchSwitch={
            b1="ST.MLeft",      b2="ST.MRight",     b3="ST.RRight",  b4="ST.RLeft",
            b5="ST.R180",       b6="ST.HDrop",      b7="ST.SDrop",   b8="ST.Hold",
            b9="ST.Function1",  b10="ST.Function2", b11="ST.ILeft",  b12="ST.IRight",
            b13="ST.SonicDrop", b14="ST.Down1",     b15="ST.Down4",  b16="ST.Down10",
            b17="ST.LDrop",     b18="ST.RDrop",     b19="ST.LZangi", b20="ST.RZangi",

            norm="Set.Norm();",
            pro="Set.Pro();",
            icon="Set.Icon",
            sfx="Set.SFX=",
            vib="Set.VIB=",
            alpha="Set.Alpha=",

            track="Set.AutoTrack",
            dodge="Set.AutoDodge",
        },
        customGame={
            title="CtmGame.UI",
            defSeq="DefSeq=true",
            noMsn="NoMsn=true",

            drop="DropDelay",
            lock="LockDelay",
            wait="EntryDelay",
            fall="LineDelay",
            hang="DeathDelay",
            hurry="AREInterruption",

            bg="BG",
            bgm="BGM",

            copy="Copy.All();",
            paste="Paste.All();",
            play_clear="Play.Ctm(Clear);",
            play_puzzle="Play.Ctm(Puzzle);",

            reset="Reset(); (del)",
            advance="Advance(); (A)",
            mod="Mod(); (F1)",
            field="Edit.Field(); (F)",
            sequence="Edit.Seq(); (S)",
            mission="Edit.Mission(); (M)",

            eventSet="EventSet",

            holdMode="HoldMode",
            nextCount="Next=",
            holdCount="Hold=",
            infHold="InfHold",
            phyHold="PhyHold",

            fieldH="FieldHeight",
            visible="Visiblity",
            freshLimit="FreshLimit",
            opponent="Bot",
            life="Life",
            pushSpeed="PushSpeed",
            garbageSpeed="GarbargeSpeed",

            bufferLimit="BufferLimit",
            heightLimit="HeightLimit",
            ospin="Ospin",
            fineKill="FineKill",
            b2bKill="B2BKill",
            lockout="Lockout",
            easyFresh="EZFresh",
            deepDrop="DeepDrop",
            bone="Bone",
        },
        custom_field={
            title="CtmGame.Field.UI",
            subTitle="",

            any="Erase();",
            smart="Smart();",

            push="Add(); (K)",
            del="Del(); (L)",

            demo="Show\"×\"",

            newPg="NewPG(); (N)",
            delPg="DelPG(); (M)",
            prevPg="PrevPG();",
            nextPg="NextPG();",
        },
        custom_sequence={
            title="CtmGame.Seq.UI",
            subTitle="",
            sequence="Sequence",
        },
        custom_mission={
            title="CtmGame.Mission.UI",
            subTitle="",

            _1="1",_2="2",_3="3",_4="4",
            any1="any1",any2="any2",any3="any3",any4="any4",
            PC="PC",
            Z1="Z1",S1="S1",J1="J1",L1="L1",T1="T1",O1="O1",I1="I1",
            Z2="Z2",S2="S2",J2="J2",L2="L2",T2="T2",O2="O2",I2="I2",
            Z3="Z3",S3="S3",J3="J3",L3="L3",T3="T3",O3="O3",I3="I3",
            O4="O4",I4="I4",
            mission="Force",
        },
        music={
            title="Music.UI",
            arrow="→",
            now="NowPlaying=",

            bgm="BGM",
            sound="SFX();",
        },
        launchpad={
            title="SFX.UI",
            bgm="BGM",
            sfx="SFX",
            voc="VOC",
            music="Music();",
            label="Label",
        },
        about={
            staff="Staff();",
            his="History();",
            legals="Leagls();",
        },
        dict={
            title="Zictionary.UI",
        },
        stat={
            path="OpenPath();",
            save="DataManagement();",
        },
        login={
            title="SignIn.UI",
            ticket="Ticket=",
            authorize="Authorize();",
            paste="Paste();",
            submit="Submit();",
        },
        reset_password={
            title="Reset_Password.UI",
            send="Send();",
            code="V-code=",
            password="Password=",
            password2="RePassword=",
            setPW="SetPassword();",
        },
        account={
            title="Account.UI",
        },
        app_15p={
            color="Color",
            invis="Invis",
            slide="Slide",
            pathVis="PathVis",
            revKB="PrvKB",
        },
        app_schulteG={
            rank="Rank=",
            invis="Invis",
            disappear="Disappsar",
            tapFX="TapFX",
        },
        app_AtoZ={
            level="Level",
            keyboard="Keyboard();",
        },
        app_2048={
            invis="Invis",
            tapControl="TapCtrl",

            skip="Skip();",
        },
        app_ten={
            next="Next",
            invis="Invis",
            fast="Fast",
        },
        app_dtw={
            color="Color",
            mode="Mode",
            bgm="BGM",
            arcade="Arcade",
        },
        app_link={
            invis="Invis",
        },
        savedata={
            export="Data.Export",
            import="Data.Import",
            unlock="Progress();",
            data="Stat();",
            setting="Setting();",
            vk="VK();",

            couldSave="Data.Cloud //Testing",
            notLogin="NotLogin=true",
            upload="UpLoad();",
            download="DownLoad();",
        },
    },
    modes={
        ['sprint_10l']=         {"Sprint(10L);",            "",      "消除10行"},
        ['sprint_20l']=         {"Sprint(20L);",            "",      "消除20行"},
        ['sprint_40l']=         {"Sprint(40L);",            "",      "消除40行"},
        ['sprint_100l']=        {"Sprint(100L);",           "",      "消除100行"},
        ['sprint_400l']=        {"Sprint(400L);",           "",      "消除400行"},
        ['sprint_1000l']=       {"Sprint(1000L);",          "",      "消除1000行"},
        ['construct_sg']=       {"Construct(SecretGrade);", "",      "按照提示完成经典的“大于号”拼图"},
        ['construct_checker']=  {"Construct",               "",      "按照提示搭建棋盘的图案"},
        ['construct_invsg']=    {"Construct",               "",      "按照提示搭建折线图案"},
        ['sprintPenta']=        {"Sprint(Penta);",          "",      "伤脑筋十八块"},
        ['sprintMPH']=          {"Sprint(MPH);",            "",      "纯随机\n无预览\n无暂存"},
        ['sprint123']=          {"Sprint(M123);",           "",      "40L，但只有1~3连块"},
        ['dig_10l']=            {"Dig(10L);",               "",      "挖掘10行"},
        ['dig_40l']=            {"Dig(40L);",               "",      "挖掘40行"},
        ['dig_100l']=           {"Dig(100L);",              "",      "挖掘100行"},
        ['dig_400l']=           {"Dig(400L);",              "",      "挖掘400行"},
        ['dig_eff_10l']=        {"DigEff(10L);",            "",      "用尽量少的块数挖掘10行"},
        ['dig_eff_40l']=        {"DigEff(40L);",            "",      "用尽量少的块数挖掘40行"},
        ['dig_eff_100l']=       {"DigEff(100L);",           "",      "用尽量少的块数挖掘100行"},
        ['dig_eff_400l']=       {"DigEff(400L);",           "",      "用尽量少的块数挖掘400行"},
        ['dig_quad_10l']=       {"DigQuad(10L);",           "",      "挖掘10行，但只能消四"},
        ['drought_n']=          {"Drought(100L);",          "",      "你I没了"},
        ['drought_l']=          {"DroughtP(100L);",         "",      "后 妈 发 牌"},
        ['marathon_n']=         {"Marathon(Normal);",       "",      "200行加速马拉松"},
        ['marathon_h']=         {"Marathon(Hard);",         "",      "200行高速马拉松"},
        ['solo_e']=             {"Solo(Easy);",             "",      "打败AI"},
        ['solo_n']=             {"Solo(Normal);",           "",      "打败AI"},
        ['solo_h']=             {"Solo(Hard);",             "",      "打败AI"},
        ['solo_l']=             {"Solo(Lunatic);",          "",      "打败AI"},
        ['solo_u']=             {"Solo(Ultimate);",         "",      "打败AI"},
        ['techmino49_e']=       {"Tech49(Easy);",           "",      "49人混战，活到最后"},
        ['techmino49_h']=       {"Tech49(Hard);",           "",      "49人混战，活到最后"},
        ['techmino49_u']=       {"Tech49(Ultimate);",       "",      "49人混战，活到最后"},
        ['techmino99_e']=       {"Tech99(Easy);",           "",      "99人混战，活到最后"},
        ['techmino99_h']=       {"Tech99(Hard);",           "",      "99人混战，活到最后"},
        ['techmino99_u']=       {"Tech99(Ultimate);",       "",      "99人混战，活到最后"},
        ['round_e']=            {"Round(Easy);",            "",      "下棋模式"},
        ['round_n']=            {"Round(Normal);",          "",      "下棋模式"},
        ['round_h']=            {"Round(Hard);",            "",      "下棋模式"},
        ['round_l']=            {"Round(Lunatic);",         "",      "下棋模式"},
        ['round_u']=            {"Round(Ultimate);",        "",      "下棋模式"},
        ['big_n']=              {"Big(Normal);",            "",      "模拟5x10场地(标准尺寸的一半)"},
        ['big_h']=              {"Big(Hard);",              "",      "模拟5x10场地(标准尺寸的一半)"},
        ['master_n']=           {"Master(Normal);",         "",      "20G初心者练习"},
        ['master_h']=           {"Master(Hard);",           "",      "上级者20G挑战"},
        ['master_m']=           {"Master(M21);",            "",      "大师20G"},
        ['master_final']=       {"Master(Final);",          "",      "究极20G:无法触及的终点"},
        ['master_ph']=          {"Master(Phantasm);",       "",      "虚幻20G:？？？"},
        ['master_g']=           {"Master(Graded);",         "",      "20G段位考试"},
        ['master_ex']=          {"Master(EX);",             "",      "成为方块大师"},
        ['master_instinct']=    {"Master(Instinct);",       "",      "当前块在出现后一小会后会隐形"},
        ['strategy_e_plus']=    {"Strategy(EasyP);",        "",      "20G堆叠中速决策练习\n无Hold"},
        ['strategy_h']=         {"Strategy(Hard);",         "",      "20G堆叠快速决策练习"},
        ['strategy_u']=         {"Strategy(Ultimate);",     "",      "20G堆叠极速决策练习"},
        ['blind_e']=            {"Blind(Slow);",            "",      "不强大脑"},
        ['blind_n']=            {"Blind(Fast);",            "",      "挺强大脑"},
        ['blind_h']=            {"Blind(Instant);",         "",      "很强大脑"},
        ['blind_l']=            {"Blind(NoGhost);",         "",      "最强大脑"},
        ['blind_u']=            {"Blind(NoField);",         "",      "你准备好了吗"},
        ['blind_wtf']=          {"Blind(Voie);"  ,          "",      "还没准备好"},
        ['classic_e']=          {"Classic(Easy);",          "",      "高速经典"},
        ['classic_h']=          {"Classic(Hard);",          "",      "飞速经典"},
        ['classic_l']=          {"Classic(Lunatic);",       "",      "极速经典"},
        ['classic_u']=          {"Classic(Ultimate);",      "",      "光速经典"},
        ['survivor_e']=         {"Survivor(Easy);",         "",      "你能存活多久？"},
        ['survivor_n']=         {"Survivor(Normal);",       "",      "你能存活多久？"},
        ['survivor_h']=         {"Survivor(Hard);",         "",      "你能存活多久？"},
        ['survivor_l']=         {"Survivor(Lunatic);",      "",      "你能存活多久？"},
        ['survivor_u']=         {"Survivor(Ultimate);",     "",      "你能存活多久？"},
        ['attacker_h']=         {"Attacker(Hard);",         "",      "进攻练习"},
        ['attacker_u']=         {"Attacker(Ultimate);",     "",      "进攻练习"},
        ['defender_n']=         {"Defender(Normal);",       "",      "防守练习"},
        ['defender_l']=         {"Defender(Lunatic);",      "",      "防守练习"},
        ['dig_h']=              {"Dig(Hard);",              "",      "挖掘练习"},
        ['dig_u']=              {"Dig(Ultimate);",          "",      "挖掘练习"},
        ['c4wtrain_n']=         {"C4WTrain(Normal);",       "",      "消除100行"},
        ['c4wtrain_l']=         {"C4WTrain(Lunatic);",      "",      "无 限 连 击"},
        ['pctrain_n']=          {"PCTrain(Normal);",        "",      "简易PC题库，熟悉全清定式的组合"},
        ['pctrain_l']=          {"PCTrain(Lunatic);",       "",      "困难PC题库，强算力者进"},
        ['pc_n']=               {"PC(Normal);",             "",      "100行内刷PC"},
        ['pc_h']=               {"PC(Hard);",               "",      "100行内刷PC"},
        ['pc_l']=               {"PC(Lunatic);",            "",      "100行内刷PC"},
        ['pc_inf']=             {"PC(Inf);",                "",      "你能连续做多少PC？"},
        ['tech_n']=             {"Tech(Normal);",           "",      "禁止断B2B"},
        ['tech_n_plus']=        {"Tech(NormalP);",          "",      "仅允许spin与PC"},
        ['tech_h']=             {"Tech(Hard);",             "",      "禁止断B2B"},
        ['tech_h_plus']=        {"Tech(HardP);",            "",      "仅允许spin与PC"},
        ['tech_l']=             {"Tech(Lunatic);",          "",      "禁止断B2B"},
        ['tech_l_plus']=        {"Tech(LunaticP);",         "",      "仅允许spin与PC"},
        ['tech_finesse']=       {"Tech(Finesse);",          "",      "强制最简操作"},
        ['tech_finesse_f']=     {"Tech(FinesseF);",         "",      "禁止普通消除，强制最简操作"},
        ['tsd_e']=              {"TSD(Easy);",              "",      "你能连续做几个TSD？"},
        ['tsd_h']=              {"TSD(Hard);",              "",      "你能连续做几个TSD？"},
        ['tsd_u']=              {"TSD(Ultimate);",          "",      "你能连续做几个TSD？"},
        ['backfire_n']=         {"Backfire(Normal);",       "",      "打出100攻击"},
        ['backfire_h']=         {"Backfire(Hard);",         "",      "打出100攻击"},
        ['backfire_l']=         {"Backfire(Lunatic);",      "",      "打出100攻击"},
        ['backfire_u']=         {"Backfire(Ultimate);",     "",      "打出100攻击"},
        ['sprintAtk']=          {"Sprint(100ATK);",         "",      "打出100攻击"},
        ['sprintEff']=          {"Sprint(EFF);",            "",      "40行内打出更高的攻击"},
        ['zen']=                {"Zen(200L);",              "",      "不限时200行"},
        ['ultra']=              {"Ultra(Extra);",           "",      "在两分钟内尽可能拿到最多的分数"},
        ['infinite']=           {"Infinite();",             "",      "沙盒"},
        ['infinite_dig']=       {"InfDig();",               "",      "挖呀挖呀挖"},
        ['marathon_inf']=       {"Marathon(Inf);",          "",      "无尽马拉松"},
        ['spinren']=            {"Spinren(EFF)",            "",      "掌管效率的神"},

        ['custom_clear']=       {"Custom(Clear);",          ""},
        ['custom_puzzle']=      {"Custom(Puzzle);",         ""},
    },
}
