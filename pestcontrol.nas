
#oldMan
    tempblock air {MBCoords}
    if item GHOST_COIN jump #oldManDone
    msg &7Old Man: &xIt's spooky season again, which means I get to scare you youngsters.
    delay msgDelay
    msg &7Old Man: &xBut for kids these days, monsters just don't cut it anymore.
    delay msgDelay
    msg &7Old Man: &xI know what'll scare you...
    delay msgDelay
    msg &7Old Man: &xGET A JOB! &b/g pestcontrol &xto go to work.
    delay 1000
    tempblock speech {MBCoords}
quit
#oldManDone
    msg &7Old Man: &xSo, how'd your shift go?
    delay msgDelay
    msg ...
    delay 1000
    msg &7Old Man: &xYou've found the &6GHOST COIN&x? Incredible!
    delay msgDelay
    msg &7Old Man: &xI had no idea that existed. Hehehe...
    delay 1000
    tempblock speech {MBCoords}
quit

#spawnMB
    if spawned quit
    set spawned true
    
    
    cmd tbot add silverbat 3 129 152 29 358 https://dl.dropbox.com/s/ehjx4pdaffxywkz/bat.png empty
    cmd tbot model silverbat goodlyay+bat
    item take SILVER_BAT
    
    set shaunStart 32 129 176
    cmd tbot add shaun {shaunStart} 0 1 https://dl.dropbox.com/s/1pxcrrzltcg5twy/shaun.png empty
    
    call #cefSetup
    set counterLocation 17 129 155 90 0
    set defaultFogColor E9B59F
    //msg Setup map
quit

#info
    tempblock air {MBCoords}
    if mobile goto #infoBegin
    ifnot cef goto #infoNoCef
    msg Note: this adventure makes use of CEF for music.
    goto #infoBegin
quit
#infoBegin
    msg Type &b/input start &Sto start!
    delay 1000
    tempblock speech {MBCoords}
quit
#infoNoCef
    msg This adventure makes use extensive use of the CEF plugin for music.
    msg Please install it for the full experience!
    if webclient msg Notice: you must have desktop client to use plugins.
    if webclient msg https://www.classicube.net/download
    msg $cef
    delay 5000
    msg |
    msg If you'd still like to continue without CEF,
    goto #infoBegin
quit

#begin
    if started quit
    set started true
    cmd tp {counterLocation}
    cpemsg announce &bAnother slow day...
    call #playTheme|main
quit

#input
    if runArg1|=| msg No input given.
    if runArg1|=| quit
    
    set start start
    if runArg1|=|start goto #begin
    msg Unrecognized input "{runArg1}"
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- CEF METHODS -------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#cefSetup
    
    set themeResidence https://youtu.be/uTRohcxcez4
    set themeResidence-volume 0.5
    set themeShaun https://youtu.be/ccpyyrdS-Qo
    set themeShaun-volume 0.6
    
    call #changeTheme|main|themeResidence
    call #changeTheme|shaun|themeShaun
    
quit

//runArgs: theme to change, url to change to
#changeTheme
    msg cef create -n {runArg1} -glasq {{runArg2}}
    set {runArg1}-volume {{runArg2}-volume}
quit
#changeThemeNoLoop
    msg cef create -n {runArg1} -gasq {{runArg2}}
quit

//runArgs: theme to play
#playTheme
    msg cef time -n {runArg1} 0
    set volume {{runArg1}-volume}
    if volume|=| set volume 1
    setdiv volume 2
    msg cef volume -n {runArg1} -g {volume}
    msg cef resume -n {runArg1}
quit
#fadeOutTheme
    //fade (volume) (other volume) (timespan)
    msg cef fade {volume} 0 1 -n {runArg1}
    delay 1500
    msg cef pause -n {runArg1}
quit
#stopTheme
    msg cef pause -n {runArg1}
quit



// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- OTHER METHODS -----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#clock
    if timePassed quit
    tempblock air {MBCoords}
    set clockMBCoords {MBCoords}
    freeze
    changemodel invisible
    msg Not much to do right now.
    msg Do you want to zone out and pass time until something interesting happens?
    reply 1|&xPass the time|#clockPassTime
    reply 2|&xNo, I want to look around more.|#clockNoPassTime
quit
#fadeOut
    set fogDelay 100
    env fog 000000
    
    env maxfog 32
    delay fogDelay
    env maxfog 16
    delay fogDelay
    env maxfog 8
    delay fogDelay
    env maxfog 4
    delay fogDelay
    env maxfog 2
    delay fogDelay
    env maxfog 1
quit
#clockPassTime
    set timePassed true
    
    newthread #fadeOutTheme|main
    call #fadeOut
    
    delay 2000
    msg You zone out for a while...
    cmd tp {counterLocation}
    delay 2000
    msg ...
    delay 2000
    env maxfog 0
    env fog {defaultFogColor}
    call #playTheme|main
    call #shaunEnters
quit
#clockNoPassTime
    unfreeze
    changemodel
    tempblock speech {clockMBCoords}
quit

#bat
    if item SILVER_BAT quit
    tempblock air {MBCoords}
    freeze
    msg It's Gramps's lucky silver bat.
    delay 1000
    if canGetBat goto #batTake
    tempblock speech {MBCoords}
    unfreeze
quit
#batTake
    msg This should work as a weapon...
    delay 1000
    item get SILVER_BAT
    cmd tbot model silverbat 0
    unfreeze
quit


#openDoor
    tempchunk 37 129 155 38 131 156 27 129 155
quit
#closeDoor
    tempchunk 27 129 155 28 131 156 27 129 155
quit
#shaunEnters
    set pos1 32.0625 129 161.5
    set pos2 28.375 129 155.5
    set posCounter 20 129 155
    set shaunMBPos 20 131 155
    tempblock air {shaunMBPos}
    
    cmd tbot ai shaun summon {shaunStart} 0 1
    delay 500
    cmd tbot ai shaun move {pos1},summon {pos1} 102 334,msg &bSomeone's outside...,wait 5,summon {pos1} 177 358,wait 10,move {pos2},summon {pos2} 272 19
    
    delay 7200
    call #openDoor
    cmd tbot ai shaun move {posCounter},stare
    delay 500
    call #closeDoor
    
    delay 2500
    set canSpeakToShaun true
    tempblock interest {shaunMBPos}
quit
#shaunExits
    set pos3 26.4375 129 155.4375
    set pos4 31.71875 129 156.5625
    
    //cmd tbot ai shaun summon {posCounter} 270 0
    //delay 2000
    cmd tbot ai shaun move {pos3},summon {pos3} 94 26
    delay 2200
    call #openDoor
    cmd tbot ai shaun move {pos4},move {shaunStart}
    delay 500
    call #closeDoor
quit


#shaunSpeaks
    ifnot canSpeakToShaun quit
    set canSpeakToShaun false
    newthread #fadeOutTheme|main
    call #playTheme|shaun
    
    tempblock air {MBCoords}
    msg &6Customer: &xHey there! I'm looking for someone who can deal with pests. Yes? Perfect.
    delay msgDelay
    msg &6Customer: &xMy name's Shaun. And you are...?
    delay 1000
    // //  reply [option number]|[text shown to player]|[#label to call if chosen]
    reply 1|&xI'm @nick.|#nameNeutral
    reply 2|&xI'm Mr. @nick.|#nameMasc
    reply 3|&xI'm Ms. @nick.|#nameFem
quit
#nameNeutral
    set @ghosthouse_playerPronouns. theythem
    set @ghosthouse_playerName. @nick
    goto #shaunSpeaks2
quit
#nameMasc
    set @ghosthouse_playerPronouns. hehim
    set @ghosthouse_playerName. Mr. @nick
    goto #shaunSpeaks2
quit
#nameFem
    set @ghosthouse_playerPronouns. sheher
    set @ghosthouse_playerName. Ms. @nick
    goto #shaunSpeaks2
quit

#shaunSpeaks2
    msg &bYou: &xI'm {@ghosthouse_playerName.}.
    delay msgDelay
    msg &6Shaun: &xIt's good to meet you, {@ghosthouse_playerName.}!
    delay msgDelay
    msg &6Shaun: &xNow, back to the pest issue. I really need them dealt with as soon as possible. And by that I mean today.
    delay msgDelay
    msg &6Shaun: &xCan you help me out?
    delay 1000
    
    reply 1|&xOf course! No One Beats Pete's!|#replyYes|Of_course!_No_One_Beats_Pete's!|1
    reply 2|&xWhat kind of pests are you dealing with?|#replyWhatPests
    reply 3|&xWe're about to close for today...|#replyClosing|We're_about_to_close_for_today...
quit
#replyClosing
    msg &bYou: &x{runArg1}
    delay msgDelay
    msg &6Shaun: &xPlease! They've made my house uninhabitable and I'll have nowhere to sleep if you can't deal with them!
    delay msgDelay
    msg &6Shaun: &xa-and I'll make it worth your while! &6250 &xcoins!
    delay 1000
    reply 1|&xYou have a deal.|#replyYes|You_have_a_deal.
    reply 2|&xSorry, but I can't help you today.|#replyDenied|
quit
#replyDenied
    msg &bYou: &xSorry, but I can't help you today.
    delay msgDelay
    call #stopTheme|shaun
    msg &6Shaun: &xGod
    delay 500
    msg &6Shaun: &xDAMN it.
    delay msgDelay
    msg &6Shaun: &xFine. You don't want my business? I won't be coming back.
    delay msgDelay
    newthread #shaunExits
    msg &6Shaun: &x*grumble grumble*
    call #playTheme|main
    
    delay 6000
    cpemsg announce &bThe End...?
    call #fadeOut
    newthread #fadeOutTheme|main
    delay 5000
    cmd main
quit

#replyWhatPests
    msg &bYou: &xWhat kind of pests are you dealing with?
    delay msgDelay
    msg &6Shaun: &xI'm really no expert on the subject, but they're of the, uh, the standard variety I'm sure.
    delay msgDelay
    msg &6Shaun: &xI just need you to take a look and see if you can get rid of them.
    delay 1000
    reply 1|&xOkay, I'll see what I can do!|#replyYes|Okay,_I'll_see_what_I_can_do!
    reply 2|&xActually, we're about to close for today...|#replyClosing|Actually,_we're_about_to_close_for_today...
quit

#replyYes
    if runArg2|=|1 set usedPeteSlogan. true
    if runArg2|=| set usedPeteSlogan.
    //if runArg2|=|1 msg used pete slogan
    //if runArg2|=| msg did not use pete slogan
    
    msg &bYou: &x{runArg1}
    delay msgDelay
    msg &6Shaun: &xThank you so much, {@ghosthouse_playerName.}! This should help you get to my place...
    delay 500
    cmd tbot ai shaun move 19 129 155,summon 19 129 155 270 42,wait 6,summon 19 129 155 270 0
    delay 2000
    delay 500
    cmd tbot model shaun toastybred+pointing
    delay 500
    cmd tbot model shaun humanoid
    msg Shaun hands you written directions to his residence.
    delay msgDelay
    msg &6Shaun: &xOh, and one more thing. I'm sure there won't be a problem, but &cbring a weapon&x. Better safe than sorry, yeah?
    set canGetBat true
    delay msgDelay
    msg &6Shaun: &xSee you soon!
    delay 1000
    newthread #shaunExits
    call #fadeOutTheme|shaun
    call #playTheme|main
    delay 5000
    tempblock interest 26 130 155
    set canTryLeave true
    unfreeze
    changemodel
quit

#tryLeave
    ifnot canTryLeave quit
    tempblock air {MBCoords}
    set leaveMBCoords {MBCoords}
    ifnot item SILVER_BAT goto #needBat
    freeze
    msg Do you want to close up shop and head to Shaun's residence?
    reply 1|&xYes, it's time to go.|#leave
    reply 2|&xI'm not ready yet.|#stay
quit
#needBat
    msg According to Shaun, I shouldn't leave before getting a weapon.
    delay 1000
    tempblock interest {MBCoords}
quit

#leave
    newthread #fadeOutTheme|main
    call #fadeOut
    delay 1000
    msg You close up shop and take the journey...
    delay 2000
    msg ...
    delay 2000
    set @ghosthouse_canAccess. true
    cmd goto ghosthouse
quit
#stay
    unfreeze
    tempblock interest {leaveMBCoords}
quit






