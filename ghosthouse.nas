

#accessControl
    //okias thing todo remove
    //quit
    
    ifnot canAccess. msg You must &b/goto pestcontrol &Sbefore you can access &4ghosthouse&S.
    ifnot canAccess. set denyAccess true
    ifnot canAccess. quit
    
    //ifnot item SILVER_BAT msg You won't survive ghosthouse without your silver bat. Pick it up from &4pestcontrol&S again.
    //ifnot item SILVER_BAT set denyAccess true
    //ifnot item SILVER_BAT quit
quit

#spawnMB
    if spawned quit
    set spawned true
    
    item take MAGIC_HAMMER
    set defaultMaxFog 512
    set defaultFogColor FFDDB5
    set defaultSkyColor 010C42
    set defaultShadowColor 5E5E99
    
    
    cmd tbot add enemy 0 0 0 0 0 Ninja &f
    
    set doorX 255.5
    set doorY 165
    set doorZ 113
    set origDoorZ {doorZ}
    cmd tbot add frontdoor {doorX} {doorY} {doorZ} 0 0 https://dl.dropbox.com/s/ntfyzssq6kqx1pc/frontdoor.png &f
    cmd tbot model frontdoor g+frontdoor
    
    cmd tbot add ghostcoin 255.5 74.5 114.5 0 0 nothing &f
    cmd tbot model ghostcoin 743
    
    cmd tbot add armor 259.5 24.5 76 90 0 https://dl.dropbox.com/s/rx32lq11seh7hig/armor.png &f
    
    cmd tbot add dilehaunte 0 0 0 0 0 https://dl.dropbox.com/s/4y88sm96w54lr4e/dilehaunte.png &f
    cmd tbot model dilehaunte g+dilehaunte
    
    cmd tbot add shaun 252 64 94 90 0 https://dl.dropbox.com/s/1pxcrrzltcg5twy/shaun.png &f
    cmd tbot model shaun humanoid
    
    
    call #arenaSetup
    call #playerSetup
    call #skillSetup
    call #menusSetup
    call #inputSetup
    //todo put back
    call #cefSetup
    
    call #itemSetup
    
    //todo put back
    call #playTheme|main
    
    set respawnLocation 7792 6400 6320 0 0
    
    set theythem theythem
    set hehim hehim
    set sheher sheher
    set riddle riddle
    set hammer hammer
    set hamma hamma
    set hammah hammah
    set crowbar crowbar
quit

#trunk
    tempblock air {MBCoords}
    msg &bYou: &xI'll come back for the appropriate supplies once I figure out what kind of infestation there is.
    set lookedTrunk true
    delay 1000
quit

#showAll
    show every single package
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- CEF METHODS -------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#cefSetup
    
    set themeSilence https://youtu.be/rrzCctUYttY
    set themeSilence-volume 2
    set themeDangerousGuys https://youtu.be/BrlUetq8HqE
    set themeVineBoom https://youtu.be/_vBVGjFdwk4
    set themeYouWon https://youtu.be/gniYdGiQNTg
    set themePepperSteak https://youtu.be/V81DlvZkxGE
    set themeOtherworldlyOpponent https://youtu.be/BChh_cBLij0
    set themeBackBeatBattle https://youtu.be/aLSAcMcUBhA
    set themeLastSurprise https://youtu.be/jNCH3XlQ4Fg
    set themeMadRatDead https://youtu.be/E-H9D1x5YOk
    set themeMadRatHeart https://youtu.be/ZJZ6SYXYv2k
    set themeBattyTwist https://youtu.be/XNOWa50qsHY
    set themeAstonishingMarch https://youtu.be/x1iKlPDRfdY
    set themeGhostTalk https://youtu.be/Vvp3Rv2yCl8
    set themeGhostTalk-volume 0.6
    
    set themeSpooky https://youtu.be/HBz_lrkp2lc
    set themeSpooky-volume 0.6
    set themeHouse https://youtu.be/Clb4w-L_YNY
    set themeHouse-volume 0.6
    
    set themeEnd https://youtu.be/sx358uxmOJc
    
    call #changeTheme|battle|themeDangerousGuys
    call #changeThemeNoLoop|lose|themeVineBoom
    call #changeThemeNoLoop|win|themeYouWon
    call #changeTheme|main|themeSpooky
    
quit

//runArgs: theme to change, url to change to
#changeTheme
    msg cef create -n {runArg1} -glasq {{runArg2}}
    set {runArg1}-volume {{runArg2}-volume}
quit
//runArgs: theme to change, url to change to
#changeThemeBackground
    msg cef -b create -n {runArg1} -glasq {{runArg2}}
    set {runArg1}-volume {{runArg2}-volume}
quit
#changeThemeNoLoop
    msg cef create -n {runArg1} -gasq {{runArg2}}
    set {runArg1}-volume {{runArg2}-volume}
quit

//runArgs: theme to play
#playTheme
    msg cef speed -n {runArg1} 1
    msg cef time -n {runArg1} 0
    set volume {{runArg1}-volume}
    if volume|=| set volume 1
    setdiv volume 2
    
    //debug silence todo remove
    //set volume 0
    
    msg cef volume -n {runArg1} -g {volume}
    msg cef resume -n {runArg1}
quit
#fadeOutTheme
    msg cef fade {volume} 0 0.5 -n {runArg1}
    delay 1500
    msg cef pause -n {runArg1}
quit
#fadeOutThemeLong
    msg cef fade {volume} 0 3 -n {runArg1}
    delay 3000
    msg cef pause -n {runArg1}
quit
#stopTheme
    msg cef pause -n {runArg1}
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- ARENA METHODS ----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#arenaSetup
    call #defaultArenaSetup
    call #ghostCoinArenaSetup
    call #mirroArenaSetup
quit
//runaArgs: name of arena to set to
#setCurArena
    set curArena {runArg1}
quit

#defaultArenaSetup
    set defaultArena-playerLocation 8528 7168 304 0 0
    
    set defaultArena-tbotX 266 
    set defaultArena-tbotY 224
    set defaultArena-tbotZ 3 
    set defaultArena-tbotDir 180 0
    set defaultArena-tbotCoords {defaultArena-tbotX} {defaultArena-tbotY} {defaultArena-tbotZ}
    set defaultArena-tbotLocation {defaultArena-tbotCoords} {defaultArena-tbotDir}
    setadd defaultArena-tbotY 1
    set defaultArena-tbotCoordsJump {defaultArena-tbotX} {defaultArena-tbotY} {defaultArena-tbotZ}
    setadd defaultArena-tbotY -1
quit

#ghostCoinArenaSetup
    set ghostCoinArena-playerLocation 9024 7168 512 0 0
    
    set ghostCoinArena-tbotX 281.5 
    set ghostCoinArena-tbotY 224
    set ghostCoinArena-tbotZ 10.5
    set ghostCoinArena-tbotDir 180 0
    set ghostCoinArena-tbotCoords {ghostCoinArena-tbotX} {ghostCoinArena-tbotY} {ghostCoinArena-tbotZ}
    set ghostCoinArena-tbotLocation {ghostCoinArena-tbotCoords} {ghostCoinArena-tbotDir}
    setadd ghostCoinArena-tbotY 1
    set ghostCoinArena-tbotCoordsJump {ghostCoinArena-tbotX} {ghostCoinArena-tbotY} {ghostCoinArena-tbotZ}
    setadd ghostCoinArena-tbotY -1
quit

#mirroArenaSetup
    set mirrorArena-playerLocation 7792 7168 1520 0 0
    
    set mirrorArena-tbotX 243
    set mirrorArena-tbotY 224
    set mirrorArena-tbotZ 41
    set mirrorArena-tbotDir 180 0
    set mirrorArena-tbotCoords {mirrorArena-tbotX} {mirrorArena-tbotY} {mirrorArena-tbotZ}
    set mirrorArena-tbotLocation {mirrorArena-tbotCoords} {mirrorArena-tbotDir}
    setadd mirrorArena-tbotY 1
    set mirrorArena-tbotCoordsJump {mirrorArena-tbotX} {mirrorArena-tbotY} {mirrorArena-tbotZ}
    setadd mirrorArena-tbotY -1
quit

#restoreDefaultEnv
    env maxfog {defaultMaxFog}
    env fog {defaultFogColor}
    env sky {defaultSkyColor}
    env shadow {defaultShadowColor}
quit

#fadeToWhite
    set fogDelay 250
    env fog FFFFFF
    env sky FFFFFF
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
    delay fogDelay
quit
#fadeToBlack
    set fogDelay 50
    env fog 000000
    env sky 000000
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
    delay fogDelay
quit
#fadeFromBlack
    set fogDelay 100
    env fog 000000
    env sky 000000
    env maxfog 1
    delay fogDelay
    env maxfog 2
    delay fogDelay
    env maxfog 4
    delay fogDelay
    env maxfog 8
    delay fogDelay
    env maxfog 16
    delay fogDelay
    env maxfog 32
    delay fogDelay
    env maxfog 64
    delay fogDelay
    call #restoreDefaultEnv
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- BATTLE METHODS ----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#resetBattles
    resetdata packages #*Battle
    msg Reset battles
quit


#shouldBeginBattle?
    //okias thing todo remove
    //terminate
    
    set curBattle {runArg0}
    //if {curBattle} msg You already won this battle.
    if {curBattle} terminate
quit

#firstBattle
    call #shouldBeginBattle?
    
    call #setCurArena|ghostCoinArena
    call #setCurEnemy|ghist
    call #startBattle
quit
#musicBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|ghost
    call #startBattle
quit
#diningRoomBattle
    //when exiting the kitchen, jumpscare in dining room
    ifnot #kitchenBattle quit
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|ghist
    call #startBattle
quit
#kitchenBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|topjack
    call #startBattle
quit
#foedoorBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|foedoor
    set foedoor-defeat #foedoorDefeat
    call #startBattle
quit
#foedoorDefeat
    call #defaultEnemyDefeat|8
    tempchunk 234 54 87 237 60 90 234 63 87
quit
#foedoorBasementBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|foedoor
    set foedoor-defeat #foedoorBasementDefeat
    call #startBattle
quit
#foedoorBasementDefeat
    call #defaultEnemyDefeat|8
    tempblock air 275 54 162
    tempblock air 275 54 163
    tempblock air 275 55 163
    tempblock air 275 55 162
    tempblock air 275 56 162
    tempblock air 275 56 163
quit
#poolBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|ghost
    call #startBattle
quit
#armoryBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|armor
    set armor-defeat #armoryDefeat
    call #startBattle
quit
#armoryDefeat
    call #defaultEnemyDefeat|10
    cmd tbot remove armor
quit
#polterblastBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|polterblast
    call #startBattle
quit
#polterblastBasementBattle
    jump #polterblastBattle
quit
//#shaunBattle
//    set curBattle {runArg0}
//    call #shouldBeginBattle?
//    
//    call #setCurArena|defaultArena
//    call #setCurEnemy|shaun
//    call #startBattle
//quit
#magicHammerBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|ghust
    call #startBattle
quit
#shadowyBattle
    call #shouldBeginBattle?
    
    call #setCurArena|mirrorArena
    call #setCurEnemy|shadowy
    call #startBattle
quit
#barBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|topjack
    call #startBattle
quit
#upperBalconyBattle
    call #shouldBeginBattle?
    
    call #setCurArena|defaultArena
    call #setCurEnemy|ghist
    call #startBattle
quit

#startBattle
    call #stopTheme|main
    set battling true
    set curTurn 0
    //delay 800
    cmd tbot summon enemy {{curArena}-tbotLocation}
    cmd tbot skin enemy {{curEnemy}-skin}
    
    //msg starting {curBattle}
    set overworldLocation {MBCoords} {PlayerYaw} {PlayerPitch}
    
    freeze
    changemodel invisible
    cmd boost 0 1 0 1 1 1
    delay 1000
    call #setCurMenu|mainMenu
    
    call #fadeToBlack
    call #moveToArena
    delay 500
    env shadow 000
    delay 500
    call #moveToArena
    env maxfog {defaultMaxFog}
    //env fog 000000
    
    cmd tbot model enemy {{curEnemy}-model}
    delay 1000
    unfreeze
    call #playTheme|battle
    call #displayPlayerHealth|0
    call #displayEnemyHealth|0
    
    cpemsg announce &e{{curEnemy}-name} {{curEnemy}-introPhrase}
    set player-didMaxDamage false
    call #canAct
quit

#moveToArena
    cmd tpp {{curArena}-playerLocation}
quit

#explodeEnemy
    cmd effect explosion {{curArena}-tbotCoordsJump} 0 0 0
    cmd tbot summon enemy 0 0 0 0 0
quit
#winBattle
    call #stopTheme|battle
    call #playTheme|win
    cpemsg announce &a{{curEnemy}-name} {{curEnemy}-outtroPhrase}
    call #explodeEnemy
    delay 1000
    call {{curEnemy}-defeat}
    delay 2000
    newthread #fadeOutTheme|win
    call #displayPlayerHealth|0
    set {curBattle} true
    call #stopBattle|1
quit
#loseBattle
    freeze
    
    delay 800
    call #stopTheme|battle
    call #playTheme|lose
    delay 200
    cpemsg announce &cYou were defeated...
    setadd player-totalDeaths 1
    env maxfog 1
    delay 5000
    call #removePlayerHealth
    set player-curHealth {player-maxHealth}
    set yellowPotionActive false
    call #stopBattle|0
quit
//runArgs: 0 for lose, 1 for win
#stopBattle
    set battleResult {runArg1}
    freeze
    call #playerPostBattle
    call #hideMenu
    
    
    if battleResult|=|0 call #respawnPlayer
    if battleResult|=|0 call #loseConsumableItems
    
    if battleResult|=|1 cmd tp {overworldLocation}
    
    call #restoreDefaultEnv
    call #setSkillSpeed|0
    
    call #removeEnemyHealth
    unfreeze
    call #playTheme|main
    changemodel
    set battling false
quit
#respawnPlayer
    cmd tpp {respawnLocation}
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- MENU METHODS ------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#hideMenu
    cpemsg bot2
    cpemsg bot3
quit

#menusSetup
    call #mainMenuSetup
    call #itemMenuSetup
    set inputMethod Press
    if mobile set inputMethod /input
quit

//runArgs: name of menu to set to
#setCurMenu
    set curMenu {runArg1}
quit
#mainMenuSetup
    set mainMenu-displayGui #mainMenuDisplayGui
    set mainMenu-actionI #inputAttack
    set mainMenu-actionO #inputSupplies
    set mainMenu-actionK #inputNothing
    set mainMenu-actionL #inputFlee
quit

#mainMenuDisplayGui
    cpemsg bot2 &S{inputMethod} I &e₧ ATTACK &S{inputMethod} O &e╩ SUPPLIES
    ifnot cantFlee cpemsg bot3 &S{inputMethod} L &e▒ FLEE       %0.
quit
#inputAttack
    call #cannotAct
    call #startSkill
    //set player-turn #playerAttack
    //call #takeTurn
quit
#inputSupplies
    call #openItemMenu
quit
#inputFlee
    if cantFlee jump #inputNothing
    call #cannotAct
    set player-turn #tryFlee
    call #takeTurn
quit
#tryFlee
    msg You try to run away--
    delay msgDelay
    msg but you can't!
    set triedFleeing true
quit
#inputNothing
    msg Invalid option.
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- ITEM METHODS ------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#openItemMenu
    
    //call switch back and forth to preserve previously selected item but ensure a valid item is selected
    call #selectItem|1
    call #selectItem|-1
    
    if selectedItem|=|-1 msg You have no supplies to use.
    if selectedItem|=|-1 quit
    
    call #cannotAct
    delay 125
    call #setCurMenu|itemMenu
    call #canAct
    //runs in #canAct call {{curMenu}-displayGui}
quit

#itemMenuSetup
    set itemMenu-displayGui #itemMenuDisplayGui
    set itemMenu-actionI #inputPrevItem
    set itemMenu-actionO #inputNextItem
    set itemMenu-actionK #inputUseItem
    set itemMenu-actionL #inputBack
    set selectedItem 0
quit

#itemMenuDisplayGui
    call #formatItemName|{selectedItem}
    ifnot hasOneItem cpemsg bot2 &S{inputMethod} I &e← prev item &S{inputMethod} O &enext item →
    cpemsg bot3 &S{inputMethod} K &eUSE {displayedItem} &S{inputMethod} L&e BACK         %0.
quit
#inputPrevItem
    call #selectItem|-1
    call #itemMenuDisplayGui
quit
#inputNextItem
    call #selectItem|1
    call #itemMenuDisplayGui
quit
#inputUseItem
    call #cannotAct
    set player-turn #{items[{selectedItem}]}-use
    call #setCurMenu|mainMenu
    call #takeTurn
quit
#inputBack
    call #cannotAct
    call #setCurMenu|mainMenu
    delay 125
    call #canAct
    //call {{curMenu}-displayGui}
quit

#getHammer
    item get MAGIC_HAMMER
quit

#tempBandsag
    if bandsag quit
    set bandsag true
    set yellowPotion-name &eYellow Potion
    set yellowPotion-consumable true
    set yellowPotion-count 0
    set items[{totalItems}] yellowPotion
    setadd totalItems 1
    msg setup yellow potion
quit

// -------------------------------------------------------- item setup 
#itemSetup
    //fixed size array that holds a reference to every single existing item.
    //Each item has a count that determines how many you have of that item
    set totalItems 0

    set redPotion-name &4Red Potion
    set redPotion-consumable true
    set redPotion-count 0
    set items[{totalItems}] redPotion
    setadd totalItems 1
    
    set yellowPotion-name &eYellow Potion
    set yellowPotion-consumable true
    set yellowPotion-count 0
    set items[{totalItems}] yellowPotion
    setadd totalItems 1
    
    set carvingKnife-name &fSilver Knife
    set carvingKnife-consumable false
    set carvingKnife-count 0
    set items[{totalItems}] carvingKnife
    setadd totalItems 1
    
    set testWeapon-name &[Test Weapon
    set testWeapon-consumable false
    set testWeapon-count 0
    set items[{totalItems}] testWeapon
    setadd totalItems 1
    
    set fireExtinguisher-name &cFire Extinguisher
    set fireExtinguisher-consumable false
    set fireExtinguisher-count 0
    set items[{totalItems}] fireExtinguisher
    setadd totalItems 1

    set ghostCoin-name &6GHOST COIN
    set ghostCoin-consumable false
    set ghostCoin-count 0
    set items[{totalItems}] ghostCoin
    setadd totalItems 1
    
    set dileItem-name &]Dilehaunte
    set dileItem-consumable false
    set dileItem-count 0
    set items[{totalItems}] dileItem
    setadd totalItems 1
    
    //list of consumable item coords starts at 0 count
    set consumableItemCoords-count 0
quit
#tryHealOutBattle
    if battling msg You can't use this command during battle!
    if battling msg Use &E╩ SUPPLIES &Sinstead.
    if battling quit
    if redPotion-count|<=|0 msg &cYou have no red potions to heal with.
    if redPotion-count|<=|0 quit
    
    call #redPotion-use
    delay 1000
    call #displayPlayerHealth|0
quit
#redPotion-use
    if player-curHealth|>=|player-maxHealth msg You already have full health! Potion was not used.
    if player-curHealth|>=|player-maxHealth quit
    
    msg You drink the red potion. Yeeucky!
    msg It restores &a50 &Shealth!
    setadd redPotion-count -1
    msg (you have {redPotion-count} left)
    setadd player-curHealth 50
    if player-curHealth|>|player-maxHealth set player-curHealth {player-maxHealth}
    call #displayPlayerHealth|-50
quit
#yellowPotion-use
    setadd yellowPotion-count -1
    msg You drink the yellow potion. Zesty!
    delay 1000
    msg &bYour next ₧ ATTACK will have improved accuracy!
    msg (you have {yellowPotion-count} left)
    delay 1500
    set yellowPotionActive true
quit
#carvingKnife-use
    call #offensiveItemDamage-use|30
quit
#testWeapon-use
    call #offensiveItemDamage-use|35
quit
#fireExtinguisher-use
    call #offensiveItem-use
quit
#ghostCoin-use
    //only change death message if the enemy has no ghost coin reaction, i.e. enemy is not instakilled by it
    if {curEnemy}-ghostCoinReaction|=| set {curEnemy}-outtroPhrase became tame!
    call #offensiveItemDamage-use|999
quit
#dileItem-use
    msg &bYou: &xDilehaunte, get 'em!
    delay 1500
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| msg Dilehaunte casts a piercing hex on {{curEnemy}-name}!
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| delay 1000
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| call #damageEnemy|20
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| quit
    
    call {{curEnemy}-{items[{selectedItem}]}Reaction}
quit
#offensiveItemCommon
    call #formatItemName|{selectedItem}
    msg You try to use {displayedItem} &Son {{curEnemy}-name}!
    if {items[{selectedItem}]}-consumable setsub {items[{selectedItem}]}-count 1
    delay 1000
quit
#offensiveItem-use
    call #offensiveItemCommon
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| msg It doesn't do anything to {{curEnemy}-name}.
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| quit
    call {{curEnemy}-{items[{selectedItem}]}Reaction}
quit
//runArgs: amount of damage to do
#offensiveItemDamage-use
    set curOffensiveItemDamage {runArg1}
    call #offensiveItemCommon
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| call #damageEnemy|{curOffensiveItemDamage}
    if {curEnemy}-{items[{selectedItem}]}Reaction|=| quit
    call {{curEnemy}-{items[{selectedItem}]}Reaction}
quit


// -------------------------------------------------------- get item
//use in MBs
//runArgs: string item to get
#getItem
    set item {runArg1}
    if item|=| msg Not enough runArgs
    if item|=| quit
    
    tempblock openchest {MBCoords}
    ifnot {item}-consumable jump #getReusableItem
    
    if foundItemAt-{MBX}-{MBY}-{MBZ} msg You've already found {{item}-name} &Shere, but it will reappear if you're defeated.
    if foundItemAt-{MBX}-{MBY}-{MBZ} quit
    set foundItemAt-{MBX}-{MBY}-{MBZ} true
    
    set consumableItemCoords[{consumableItemCoords-count}] {MBCoords}
    setadd consumableItemCoords-count 1
    
    setadd {item}-count 1
    msg Found a supply: {{item}-name}&S!
    msg Use &b/input supplies &Sto see them all.
quit
//internal don't use in MBs
#getReusableItem
    if {item}-count|>|0 msg You've already found {{item}-name} &Shere.
    if {item}-count|>|0 quit
    
    set {item}-count 1
    msg Found a supply: {{item}-name}&S!
    msg Use &b/input supplies &Sto see them all.
quit

#restoreConsumableItems
    set index 0
    
    //hardcoded bathroom mirror chest :sob:
    tempblock chest-e 288 37 109
    
    #restoreConsumableItemsLoop
    if index|>=|consumableItemCoords-count jump #restoreConsumableItemsLoopBreak
    
        set consumableItemCoord {consumableItemCoords[{index}]}
        tempchunk {consumableItemCoord} {consumableItemCoord} {consumableItemCoord}
        
    setadd index 1
    jump #restoreConsumableItemsLoop
    #restoreConsumableItemsLoopBreak
    
    resetdata packages consumableItemCoords[*]
    resetdata packages foundItemAt*
    set consumableItemCoords-count 0
quit

// -------------------------------------------------------- displaying items
#displayItems
    msg Your supplies:
    set itemsDisplayed 0
    set itemIndex 0
    
        #displayItemsLoop
        if itemIndex|>=|totalItems jump #displayItemsLoopBreak
        
            if {items[{itemIndex}]}-count|=|0 jump #displayItemsLoopContinue
            call #formatItemName|{itemIndex}
            msg {displayedItem}
            setadd itemsDisplayed 1
        
        #displayItemsLoopContinue
        setadd itemIndex 1
        jump #displayItemsLoop
        #displayItemsLoopBreak
    
    if redPotion-count|>|0 msg Use &b/input heal &Sto use a {redpotion-name}&S outside of battle.
    if itemsDisplayed|=|0 msg &cYou have no supplies.
quit

//runArgs: index of item to display, out string displayedItem
#formatItemName
    set itemIndex {runArg1}
    set itemAmount &fx{{items[{itemIndex}]}-count}
    
    if {items[{itemIndex}]}-consumable set displayedItem {{items[{itemIndex}]}-name} &S{itemAmount}
    ifnot {items[{itemIndex}]}-consumable set displayedItem {{items[{itemIndex}]}-name}
quit


// -------------------------------------------------------- misc
//runArgs: direction to select in, out index selectedItem
#selectItem
    set dir {runArg1}
    set timesMoved 0
    #selectItemLoop
        setadd selectedItem dir
        setmod selectedItem totalItems
        setadd timesMoved 1
        //found item, exit routine
        if {items[{selectedItem}]}-count|>|0 jump #selectItemExitRoutine
        
        //Every item has been scanned and you have none, exit routine
        if timesMoved|>|totalItems set selectedItem -1
        if timesMoved|>|totalItems quit
        
    jump #selectItemLoop
quit
#selectItemExitRoutine
    if timesMoved|=|totalItems set hasOneItem true
    if timesMoved|=|totalItems quit
    set hasOneItem false
quit

#loseConsumableItems
    set itemIndex 0
    set itemsLost 0
    
    #loseItemsLoop
    if itemIndex|>=|totalItems jump #loseItemsBreak
        
        
        if {items[{itemIndex}]}-consumable call #loseItem
        
    setadd itemIndex 1
    jump #loseItemsLoop
    #loseItemsBreak
    
    if itemsLost|>|0 msg &cYou lost your consumable supplies!
    msg &aUpon defeat, consumable supplies can be found again. ▓
    call #restoreConsumableItems
quit
#loseItem
    //already don't have the item, exit routine
    if {items[{itemIndex}]}-count|<=|0 quit
    
    set {items[{itemIndex}]}-count 0
    setadd itemsLost 1
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- INPUT METHODS -----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#inputSetup
    // definehotkey [input args]|[key name]|<list of space separated modifiers>
    definehotkey I|I
    definehotkey O|O
    definehotkey K|K
    definehotkey L|L
    
    set I I
    set O O
    set K K
    set L L
    set supplies supplies
    set heal heal
quit

#canAct
    set canAct true
    call {{curMenu}-displayGui}
quit
#cannotAct
    set canAct false
    cpemsg bot2
    cpemsg bot3
quit

#input
    set inputRunArg2 {runArg2}
    if runArg1|=|riddle goto #answerChestRiddle
    if runArg1|=|supplies goto #displayItems
    if runArg1|=|heal goto #tryHealOutBattle
    ifnot canAct jump #inputExit
    if runArg1|=|I goto {{curMenu}-actionI}
    if runArg1|=|O goto {{curMenu}-actionO}
    if runArg1|=|K goto {{curMenu}-actionK}
    if runArg1|=|L goto {{curMenu}-actionL}
    
    msg Unrecognized fight action "{runArg1}"
quit
#inputExit
    msg Invalid input "{runArg1}"
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- TURN --------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#takeTurn
    msg -
    call {player-turn}
    msg -
    delay 1000
    msg -
    call #tryFleeLaugh
    
    set doMaxDamageReaction {player-didMaxDamage}
    set player-didMaxDamage false
    if {curEnemy}-maxDamageReaction|=| set {curEnemy}-maxDamageReaction #defaultMaxDamageReaction
    if doMaxDamageReaction call {{curEnemy}-maxDamageReaction}
    if doMaxDamageReaction jump #skipEnemyTurn
    
    call {{curEnemy}-turn}
    #skipEnemyTurn
    msg -
    call #canAct
    setadd curTurn 1
quit
#tryFleeLaugh
    ifnot triedFleeing quit
    set triedFleeing false
    set cantFlee true
    msg {{curEnemy}-name} is amused at your cowardice.
    delay msgDelay
quit
// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- SKILL METHODS -----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

//runArgs: speed to set (default 0)
#setSkillSpeed
    set prevSkillSpeed {curSkillSpeed}
    set curSkillSpeed {runArg1}
    set skillTCX 250
    setsub skillTCX curSkillSpeed
    tempchunk {skillTCX} 2 5 {skillTCX} 254 5 255 2 4
quit
#setSkillSpeedMsg
    set msg &o{{curEnemy}-name} is harder to ₧ ATTACK now!
    if prevSkillSpeed|>|curSkillSpeed set msg &b{{curEnemy}-name} is easier to ₧ ATTACK now!
    msg {msg}
quit

#skillSetup
    set skillLocation 255 253 4 0 90
    
    set buffBlockCenterX 255
    set buffBlockCenterY 1
    set buffBlockCenterZ 4
    
    set totalBuffBlocks 10
    set totalSkillLayers 20
    set totalSkillLayersMinusOne {totalSkillLayers}
    setadd totalSkillLayersMinusOne -1
    set skillLayerMulti 12
    
    set buffBlockList-count 0
    
    set buffAmount 5
    set debuffAmount -5
    set maxBuffDamage {totalBuffBlocks}
    setmul maxBuffDamage buffAmount
    
    set index 0
    #layerL
               if index|<|totalBuffBlocks set buffBlockHere?[{index}] true
            ifnot index|<|totalBuffBlocks set buffBlockHere?[{index}] false
        
        setadd index 1
        if index|=|totalSkillLayers jump #layerLBreak
        jump #layerL
    #layerLBreak
    
    set curSkillSpeed 0
    set prevSkillSpeed 0
quit

//--To shuffle an array a of n elements(indices 0..n - 1) :
//	for i from 0 to n-2 do
//		j = random index from i to n-1
//		exchange a[i] and a[j]
#skillShuffle
    set index 0
    set 
    #shuffL
        
        setrandrange j index totalSkillLayersMinusOne
        //preserve j
        set jValue {buffBlockHere?[{j}]}
        
		//set value of array at j to value of array at i
        set buffBlockHere?[{j}] {buffBlockHere?[{index}]}
        
		//set value of array at i to cached value of array at j
        set buffBlockHere?[{index}] {jValue}
        
    setadd index 1
    if index|=|totalSkillLayersMinusOne quit
    jump #shuffL
    quit
    
quit

#skillPop
    call #skillShuffle
    set skillPopIndex 0
    
    #skillPopLoop
            //msg buffBlockHere?[{skillPopIndex}] = {buffBlockHere?[{skillPopIndex}]}
            ifnot buffBlockHere?[{skillPopindex}] jump #skillPopLoopContinue
            
            setrandrange bBlockX -3 3
            set bBlockY {buffBlockCenterY}
            setrandrange bBlockZ -3 3
            
            setadd bBlockX buffBlockCenterX
            setadd bBlockY skillPopIndex
            setmul bBlockY skillLayerMulti
            setadd bBlockZ buffBlockCenterZ
            call #checkAndResolveBlockage
            
            tempblock light {bBlockX} {bBlockY} {bBlockZ}
            setsub bBlockY 1
            set buffBlockList[{buffBlockList-count}] {bBlockX} {bBlockY} {bBlockZ}
            setadd buffBlockList-count 1
            
            tempblock redlight {bBlockX} {bBlockY} {bBlockZ}
        
        #skillPopLoopContinue
        setadd skillPopIndex 1
        if skillPopIndex|>=|totalSkillLayers jump #skillPopLoopBreak
        jump #skillPopLoop
    #skillPopLoopBreak
quit
#checkAndResolveBlockage
    ifnot bBlockX|=|buffBlockCenterX quit
    ifnot bBlockZ|=|buffBlockCenterZ quit
    //just push north by one
    setadd bBlockZ -1
quit

#skillDepop
    set index 0
    #eraseSkillBlocksLoop
        if index|>=|buffBlockList-count jump #eraseSkillBlocksLoopBreak
        tempchunk 251 221 169 251 222 169 {buffBlockList[{index}]}
        setadd index 1
        jump #eraseSkillBlocksLoop
    #eraseSkillBlocksLoopBreak
    resetdata packages buffBlockList[*]
    set buffBlockList-count 0
    //msg Done erasing skill blocks
quit

#startSkill
    freeze
    reach 10
    call #displayPlayerHealth|0
    call #displayEnemyHealth|0
    
    call #skillDepop
    call #skillPop
    
    delay 500
    set endedEarly false
    set player-curAttackDamage 0
    call #editCurAttackDamage|0
    cmd tp {skillLocation}
quit
//runArgs: buff or debuff amount
#editCurAttackDamage
    call #calcBuffString|{runArg1}|diffString
    ifnot runArg1|=|0 cpemsg announce Your attack: &e{player-curAttackDamage}{diffString}&f damage! <
    ifnot runArg1|=|0 delay 100
    
    set damageColor &e
    set damageDisplayed {player-curAttackDamage}
    
    setadd player-curAttackDamage {runArg1}
    
    if player-curAttackDamage|=|maxBuffDamage set damageDisplayed {maxBuffDamage}
    if player-curAttackDamage|=|maxBuffDamage set diffString
    if player-curAttackDamage|=|maxBuffDamage set damageColor &6
    cpemsg announce Your attack: {damageColor}{damageDisplayed}{diffString}&f damage!
    
    if player-curAttackDamage|<|0 set player-curAttackDamage 0
quit
#buffAttack
    if gotBuff{MBY} msg Already got this buff this turn
    if gotBuff{MBY} quit
    set gotBuff{MBY} true
    
    if yellowPotionActive cmd boost 0 -0.5 0 1 1 1
    tempblock air {MBCoords}
    set effectY {MBY}
    setsub effectY 4
    cmd effect electric {MBX} {effectY} {MBZ} 0 0 0

    call #editCurAttackDamage|{buffAmount}
    call #tryEndEarly
quit
#tryEndEarly
    if player-curAttackDamage|=|maxBuffDamage quit

    if player-curAttackDamage|>=|{curEnemy}-curHealth set endedEarly true
    if player-curAttackDamage|>=|{curEnemy}-curHealth jump #endSkillCore
quit
#debuffAttack
    tempblock air {MBCoords}
    call #editCurAttackDamage|{debuffAmount}
quit
#endSkill
    //don't want double end
    if endedEarly quit
    ifnot endedEarly setadd player-totalSwings 1
    ifnot endedEarly setadd player-totalSwingDamage player-curAttackDamage
    
    #endSkillCore
    
    if yellowPotionActive msg The yellow potion's effects wore off.
    set yellowPotionActive false
    
    reach 5
    call #moveToArena
    unfreeze
    delay 1000
    set player-turn #playerAttack
    resetdata packages gotBuff*
    call #takeTurn
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- PLAYER METHODS ----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------
#playerSetup
    set player-maxHealth 100
    set player-curHealth 100
    
    
    
    set player-totalDeaths 0
    set player-totalDamageTaken 0
    set player-totalDamageDealt 0
    set player-totalSwingDamage 0
    set player-totalSwings 0

    set player-totalCoinsFound 0
quit
#displayPlayerStats
    set player-averageBatDamage {player-totalSwingDamage}
    ifnot player-totalSwings|=|0 setdiv player-averageBatDamage player-totalSwings
    setround player-averageBatDamage
    
    msg &a- Statistics! -
    delay 2000
    msg Total Deaths:&6 {player-totalDeaths}
    delay creditsDelay
    msg Total Damage Taken:&6 {player-totalDamageTaken}
    delay creditsDelay
    msg Total Damage Dealt:&6 {player-totalDamageDealt}
    delay creditsDelay
    msg Average bat damage:&6 {player-averageBatDamage} &S(excluding finishing blows)
    delay creditsDelay
    msg Total bat swings:&6 {player-totalSwings} &S(excluding finishing blows)
    delay creditsDelay
    msg Total coins discovered:&6 {player-totalCoinsFound}
    delay 2000
quit
#playerPostBattle
    //offense/defense used to be reset here but it was removed
quit
#playerAttack
    set player-attackMessage &eYou take a swing at {{curEnemy}-name}!
    if player-curAttackDamage|=|maxBuffDamage set player-attackMessage &eYou SMASH {{curEnemy}-name} with maximum force!
    if player-curAttackDamage|=|maxBuffDamage set player-didMaxDamage true
    if player-curAttackDamage|=|0 jump #playerMiss
    msg {player-attackMessage}
    delay 1000
    
    ifnot {curEnemy}-batReaction|=| jump {{curEnemy}-batReaction}
    //for enemy damage reaction to jump to if needed
    #playerAttackFinish
    call #damageEnemy|{player-curAttackDamage}
quit
#playerMiss
    msg &eYou miss your swing entirely...
    msg (click the &b[&a+&e₧&b]&S blocks!)
    delay 1000
quit
//runArgs: amount of damage (pre modifiers) to do to enemy
#damageEnemy
    set damage {runArg1}
    
    set actualDamageDealt {damage}
    if actualDamageDealt|>|{curEnemy}-curHealth set actualDamageDealt {{curEnemy}-curHealth}
    setadd player-totalDamageDealt actualDamageDealt
    
    setsub {curEnemy}-curHealth damage
    cpemsg announce
    msg {{curEnemy}-name} takes &c{damage} &Sdamage!
    call #displayEnemyHealth|{damage}
    if {curEnemy}-curHealth|<=|0 goto #winBattle
    if damage|>|0 newthread #bumpEnemy
quit
#bumpEnemy
    cmd tbot summon enemy {{curArena}-tbotCoordsJump} {{curArena}-tbotDir}
    delay 100
    cmd tbot summon enemy {{curArena}-tbotCoords} {{curArena}-tbotDir}
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- ENEMY METHODS -----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#defaultEnemyTurn
    setrandrange actionNumber 1 {{curEnemy}-actionCount}
    call {{curEnemy}-action{actionNumber}}
quit
//runArgs: amount of damage to do to player
#damagePlayer
    set damage {runArg1}
    
    set actualDamageDealt {damage}
    if actualDamageDealt|>|player-curHealth set actualDamageDealt {player-curHealth}
    setadd player-totalDamageTaken actualDamageDealt
    
    setsub player-curHealth damage
    msg You take &c{damage} &Sdamage!
    call #displayPlayerHealth|{damage}
    
    setdiv damage 10
    setdiv damage 2
    cmd boost 0 {damage} 0 1 1 1
    
    if player-curHealth|<=|0 goto #loseBattle
quit

//runArgs: name of enemy to set to
#setCurEnemy
    set curEnemy {runArg1}
    call #{curEnemy}Setup
quit
//runArgs: amount of money to give upon death
#defaultEnemyDefeat
    set enemyReward {runArg1}
    setadd player-totalCoinsFound enemyReward
    cmd rewardfrom {curBattle} {enemyReward} false
quit
//runArgs: amount of coins to get
#reward
    set reward {runArg1}
    setadd player-totalCoinsFound reward
    cmd reward {reward}
quit
#defaultMaxDamageReaction
    msg &b{{curEnemy}-name} is reeling from your attack!
quit

// Ghusty and Ghosty and Ghist
// After death they were not sorely missed
// Now they've formed their own clique
// With quite a mean streak
// Don't intrude or they'll surely be pissed

// ------------------------------------ ghist ------------------------------------
#ghistSetup
    set ghist-name Ghist
    set ghist-introPhrase attacks!
    set ghist-outtroPhrase disappears!
    set ghist-defeat #defaultEnemyDefeat|5
    
    set ghist-model g+ghist
    set ghist-skin https://dl.dropbox.com/s/3ygjk4pwrfwc1ku/ghist.png
    call #changeThemeBackground|battle|themeDangerousGuys
    
    set ghist-maxHealth 50
    set ghist-curHealth {{curEnemy}-maxHealth}

    
    set ghist-turn #defaultEnemyTurn
    set ghist-actionCount 3
    set ghist-action1 #ghistAttack
    set ghist-action2 #ghistAttack
    set ghist-action3 #ghistIdle
    
    set ghist-hasAttacked false
    set ghist-contemplating false
quit
#ghistAttack
    set ghist-hasAttacked true
    set again
    if ghist-contemplating set again ... again!
    if ghist-contemplating set ghist-contemplating false
    msg &c{{curEnemy}-name} rushes through you{again}!
    delay 1000
    call #damagePlayer|10
quit
#ghistIdle
    if ghist-contemplating jump #ghistAttack
    ifnot ghist-hasAttacked jump #ghistAttack
    msg {{curEnemy}-name} is contemplating its next move.
    set ghist-contemplating true
quit


// ------------------------------------ ghost ------------------------------------
#ghostSetup
    set ghost-name Ghost
    set ghost-introPhrase swoops in!
    set ghost-outtroPhrase is busted!
    set ghost-defeat #defaultEnemyDefeat|8
    
    set ghost-model g+ghost
    set ghost-skin https://dl.dropbox.com/s/1e1d5r3jyr2c2h3/ghost.png
    call #changeThemeBackground|battle|themePepperSteak
    
    set ghost-maxHealth 80
    set ghost-curHealth {{curEnemy}-maxHealth}
    
    set ghost-turn #defaultEnemyTurn
    set ghost-actionCount 4
    set ghost-action1 #ghostAttack
    set ghost-action2 #ghostAttack
    set ghost-action3 #ghostMutter
    set ghost-action4 #ghostWhisper
quit
#ghostAttack
    msg &c{{curEnemy}-name} grabs at you!
    delay 1000
    call #damagePlayer|15
quit
#ghostIdle
    msg {{curEnemy}-name} is staring off into space.
quit
#ghostMutter
    msg {{curEnemy}-name} mutters something you can't understand.
quit
#ghostWhisper
    msg &c{{curEnemy}-name} whispers something you can't bear to hear.
    delay 1000
    call #damagePlayer|25
quit


// ------------------------------------ ghust ------------------------------------
#ghustSetup
    set ghust-name Ghust
    set ghust-introPhrase barges in!
    set ghust-outtroPhrase is KO'd!
    set ghust-defeat #defaultEnemyDefeat|20
    
    set ghust-model g+ghust
    set ghust-skin https://dl.dropbox.com/s/ykf2fmghzkx412c/ghust.png
    call #changeThemeBackground|battle|themeMadRatDead
    
    set ghust-maxHealth 200
    set ghust-curHealth {{curEnemy}-maxHealth}
    
    set ghust-turn #defaultEnemyTurn
    set ghust-actionCount 3
    set ghust-action1 #ghustAttack
    set ghust-action2 #ghustAttack
    set ghust-action3 #ghustWag
quit
#ghustAttack
    msg &c{{curEnemy}-name} socks your face!
    delay 1000
    call #damagePlayer|20
quit
#ghustWag
    msg {{curEnemy}-name} wags its finger at you.
quit

// ------------------------------------ foe door ------------------------------------
#foedoorSetup
    set foedoor-name Foe Door
    set foedoor-introPhrase attacks!
    set foedoor-outtroPhrase fades away!
    set foedoor-defeat #defaultEnemyDefeat|8
    
    set foedoor-model g+foedoor
    set foedoor-skin https://dl.dropbox.com/s/ntfyzssq6kqx1pc/frontdoor.png
    call #changeThemeBackground|battle|themeOtherworldlyOpponent
    
    set foedoor-maxHealth 80
    set foedoor-curHealth {{curEnemy}-maxHealth}
    
    set foedoor-turn #defaultEnemyTurn
    set foedoor-actionCount 3
    set foedoor-action1 #ghostAttack
    set foedoor-action2 #foedoorCreak
    set foedoor-action3 #foedoorSlam
quit
#foedoorCreak
    msg {{curEnemy}-name} is creaking creepily.
quit
#foedoorSlam
    msg &c{{curEnemy}-name} does a painfully loud slam!
    delay 1000
    call #damagePlayer|25
quit


// ------------------------------------ topjack ------------------------------------
#topjackSetup
    set topjack-name Topjack
    set topjack-introPhrase approaches menacingly!
    set topjack-outtroPhrase rots away!
    set topjack-defeat #defaultEnemyDefeat|12
    
    set topjack-model g+topjack
    set topjack-skin https://dl.dropbox.com/s/35xyvdoc2c27cig/topJack.png
    call #changeThemeBackground|battle|themeBackBeatBattle
    
    set topjack-maxHealth 120
    set topjack-curHealth {{curEnemy}-maxHealth}
    
    set topjack-maxDamageReaction #topjackMaxDamageReaction
    set topjack-carvingKnifeReaction #topjackCarvingKnifeReaction
    
    set topjack-turn #topjackTurn
    set topjack-actionCount 3
    set topjack-action1 #topjackAttack
    set topjack-action2 #topjackGaze
    set topjack-action3 #topjackSpin
quit

#topjackTurn
    //if already slow, do turn as normal
    if curSkillSpeed|=|0 jump #defaultEnemyTurn
    set turnsPassed {curTurn}
    setsub turnsPassed topjack-turnItSpedUpOn
    if turnsPassed|=|2 jump #topjackSlow
    
    call #defaultEnemyTurn
quit
#topjackMaxDamageReaction
    call #topjackSpin
quit
#topjackAttack
    msg &c{{curEnemy}-name} falls on you!
    delay 1000
    call #damagePlayer|15
quit
#topjackGaze
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 100
    cmd effect go {{curArena}-tbotCoordsJump} 0 0 0
    delay 500
    
    msg &c{{curEnemy}-name} pierced you with a terrifying gaze!
    delay 1000
    call #damagePlayer|25
quit
#topjackSpin
    if curSkillSpeed|=|1 jump #topjackSlow
    
    set topjack-turnItSpedUpOn {curTurn}
    msg {{curEnemy}-name} starts spinning even faster!
    delay 1000
    call #setSkillSpeed|1
    call #setSkillSpeedMsg
    //it shouldn't be able to spin again until 2 turns later, replace spin with attack
    set topjack-action3 #topjackAttack
quit
#topjackSlow
    msg {{curEnemy}-name} slows down.
    delay 1000
    call #setSkillSpeed|0
    call #setSkillSpeedMsg
    //it can spin again if it wants to next turn
    set topjack-action3 #topjackSpin
quit
#topjackCarvingKnifeReaction
    msg ...and you carve a stupid face! ╫
    set {curEnemy}-outtroPhrase retires!
    delay 1000
    call #damageEnemy|999
    msg {{curEnemy}-name} retires! :joy:
quit



// ------------------------------------ polterblast ------------------------------------
#polterblastSetup
    set polterblast-name Polterblast
    set polterblast-introPhrase lights up!
    set polterblast-outtroPhrase was destroyed!
    set polterblast-defeat #defaultEnemyDefeat|10
    
    set polterblast-model g+polterblast
    set polterblast-skin https://dl.dropbox.com/s/cxssgpiyyb53usn/polterblast.png
    call #changeThemeBackground|battle|themeBattyTwist
    
    set polterblast-maxHealth 100
    set polterblast-curHealth {{curEnemy}-maxHealth}
    
    set polterblast-fireExtinguisherReaction #polterblastExt
    set polterblast-maxDamageReaction #polterblastMaxDamageReaction
    
    set polterblast-tick 3
    set polterblast-turn #defaultEnemyTurn
    set polterblast-actionCount 1
    set polterblast-action1 #polterblastTick
quit
#polterblastExt
    msg &b{{curEnemy}-name}'s fuse flame is extinguished!
    set {curEnemy}-outtroPhrase was defused!
    delay 1000
    call #damageEnemy|999
quit
#polterblastMaxDamageReaction
    //msg &b{{curEnemy}-name}'s fuse flame falters from your furious force!
    call {polterblast-turn}
quit
#polterblastTick
    setadd {curEnemy}-tick -1
    set plural inches
    if {curEnemy}-tick|=|1 set plural inch
    msg &c{{curEnemy}-name}'s fuse is burning! &o{{curEnemy}-tick} {plural} of fuse left!
    if {curEnemy}-tick|=|1 jump #polterblastLastTick
    if {curEnemy}-tick|=|0 jump #polterblastExplode
quit
#polterblastLastTick
    msg cef pause -n battle
    delay 1000
    msg cef speed -n battle 1.5
    msg cef time -n battle 0
    msg cef resume -n battle
quit
#polterblastExplode
    call #stopTheme|battle
    delay 1000
    msg &c{{curEnemy}-name} explodes!
    call #explodeEnemy
    call #damagePlayer|999
quit



// ------------------------------------ armor ------------------------------------
#armorSetup
    set armor-name Occupied Armor
    set armor-introPhrase comes to life!
    set armor-outtroPhrase falls apart!
    set armor-defeat #defaultEnemyDefeat|10
    
    set armor-model g+armor
    set armor-skin https://dl.dropbox.com/s/ozeixayq5ghepmo/armor.png
    call #changeThemeBackground|battle|themeAstonishingMarch
    
    set armor-maxHealth 100
    set armor-curHealth {{curEnemy}-maxHealth}
    
    #armorActionSetup
    
    set armor-peeking false
    set armor-mustPeek false
    set armor-carvingKnifeReaction #armorKnifeReaction
    set armor-batReaction #armorDamageReaction
    set armor-maxDamageReaction #armorMaxDamageReaction
    
    set armor-turn #armorTurn
    set armor-actionCount 2
    set armor-action1 #armorAttack
    set armor-action2 #armorMutter
quit
#armorMaxDamageReaction
    if armor-mustPeek jump #armorPeek
    if curTurn|=|5 jump #armorPeek
    call {{curEnemy}-turn}
quit
#armorTurn
    if armor-mustPeek jump #armorPeek
    if curTurn|=|4 jump #armorPeek
    call #defaultEnemyTurn
quit
#armorAttack
    ifnot armor-peeking jump #armorMiss
    msg &c{{curEnemy}-name} crashes into you!
    delay 1000
    call #damagePlayer|15
quit
#armorMiss
    msg {{curEnemy}-name} tries to crash into you, but can't see very well and misses!
quit
#armorMutter
    msg {{curEnemy}-name} wonders if it is historically accurate.
quit
#armorPeek
    if armor-peeking jump #armorUnpeek
    msg &bGhist peeks out from inside {{curEnemy}-name}!
    cmd tbot model enemy g+armorpeek
    set armor-peeking true
    set armor-mustPeek false
    set armor-carvingKnifeReaction
    set armor-batReaction
    set armor-maxDamageReaction
    set armor-actionCount 4
    set armor-action1 #armorAttack
    set armor-action2 #armorAttack
    set armor-action3 #armorAttack
    set armor-action4 #armorPeek
quit
#armorUnpeek
    msg &oGhist hides again!
    cmd tbot model enemy g+armor
    jump #armorActionSetup
quit
#armorDamageReaction
    msg &eYour bat bounces off and rebounds back at you!
    delay 1000
    call #damagePlayer|{player-curAttackDamage}
quit
#armorKnifeReaction
    msg You stab the knife through the visor and hear a screech!
    set armor-mustPeek true
    delay 1000
quit



// ------------------------------------ dilehaunte ------------------------------------
#dilehaunteDefeat
    call #defaultEnemyDefeat|20
    //cmd tempbot summon dilehaunte 0 0 0 0 0
    call #turnChairBack
quit
#dilehaunteSetup
    set dilehaunte-name Dilehaunte
    set dilehaunte-introPhrase attacks!
    set dilehaunte-outtroPhrase relents!
    set dilehaunte-defeat #dilehaunteDefeat
    
    set dilehaunte-model g+dilehaunte
    set dilehaunte-skin https://dl.dropbox.com/s/4y88sm96w54lr4e/dilehaunte.png
    call #changeThemeBackground|battle|themeMadRatHeart
    
    set dilehaunte-maxHealth 200
    set dilehaunte-curHealth {{curEnemy}-maxHealth}
    
    set dilehaunte-maxDamageReaction #dilehaunteMaxDamageReaction
    
    set dilehaunte-turn #dilehaunteTurn
    set dilehaunte-actionCount 3
    set dilehaunte-action1 #dilehaunteHeal
    set dilehaunte-action2 #dilehaunteAttack
    set dilehaunte-action3 #dilehaunteAttack
quit
#dilehaunteMaxDamageReaction
    if curTurn|=|1 jump #dilehaunteSpeedUp
    call #defaultMaxDamageReaction
quit
#dilehaunteTurn
    if curTurn|=|1 jump #dilehaunteSpeedUp
    call #defaultEnemyTurn
quit
#dilehaunteSpeedUp
    msg {{curEnemy}-name} casts a slowing hex on you!
    delay 1000
    call #setSkillSpeed|1
    call #setSkillSpeedMsg
quit
#dilehaunteAttack
    msg &c{{curEnemy}-name} casts a piercing hex on you!
    delay 1000
    call #damagePlayer|20
quit
#dilehaunteHeal
    msg &o{{curEnemy}-name} takes a sip from its glass!
    setadd {curEnemy}-curHealth 25
    call #displayEnemyHealth|-25
    delay 1000
quit



// ------------------------------------ shaun ------------------------------------
#shaunDefeat
    set shaunAtDoor false
    cmd tempbot model shaun g+rekt
    cmd tbot ai shaun summon 258.0938 64 109.9688 14 7
    tempblock speech 259 65 111
quit
#shaunRekt
    ifnot #shaunBattle quit
    if shaunPassedOut quit
    set shaunPassedOut true
    freeze
    tempblock air {MBCoords}
    msg &6Shaun: &xDamn it.
    delay 1000
    msg ...
    delay 1000
    msg Shaun passes out.
    delay 1000
    call #shaunRektDileComment
    unfreeze
    //tempblock interest {MBCoords}
quit
#shaunRektDileComment
    ifnot dileItem-count|>|0 quit
    msg &]Dilehaunte: &xLooks like that oaf got what was coming to him. Well fought!
    delay 1000
quit
#shaunSetup
    set shaun-name Shaun
    set shaun-introPhrase draws a gun on you!
    set shaun-outtroPhrase surrenders!
    set shaun-defeat #shaunDefeat|10
    
    set shaun-model goodlyay+gun
    set shaun-skin https://dl.dropbox.com/s/1pxcrrzltcg5twy/shaun.png
    call #changeThemeBackground|battle|themeLastSurprise
    
    set shaun-maxHealth 200
    set shaun-curHealth {{curEnemy}-maxHealth}
    
    #shaunGunSetup
    set shaun-lostGun false
    set shaun-justLostGun false
    set shaun-carvingKnifeReaction #shaunKnife
    set shaun-fireExtinguisherReaction #shaunExt
    set shaun-ghostCoinReaction #shaunCoin
    set shaun-dileItemReaction #shaunDileReaction
    set shaun-maxDamageReaction #shaunMaxDamageReaction
    
    set shaun-turn #shaunTurn
    set shaun-actionCount 1
    set shaun-action1 #shaunGun
quit
#shaunPotion
    msg &o{{curEnemy}-name} chugs a red potion!
    setadd {curEnemy}-curHealth 50
    call #displayEnemyHealth|-50
    delay 1000
quit
#shaunTurn
    if shaun-justLostGun jump #shaunLookGun
    if {curEnemy}-curHealth|<|50 jump #shaunPotion
    
    call #defaultEnemyTurn
quit
#shaunMaxDamageReaction
    msg Shaun spits blood out of his mouth.
    delay msgDelay
    set shaunInsult commoner
    if playerPronouns.|=|hehim set shaunInsult boy
    if playerPronouns.|=|sheher set shaunInsult girl
    msg &6{{curEnemy}-name}: &xIt's going to take more than brute force to take me down, you foolish {shaunInsult}!
    delay msgDelay
    call {shaun-turn}
quit
#shaunGun
    if dileItem-count|>|0 call #getDownMrPresident
    msg &c{{curEnemy}-name} shoots you!
    delay 1000
    call #damagePlayer|999
quit
#getDownMrPresident
    set nick boss
    if playerPronouns.|=|hehim set nick master @nick
    if playerPronouns.|=|sheher set nick mistress @nick
    msg &]Dilehaunte: &xGet down {nick}!!!
    delay 1000
    msg Dilehaunte swoops in front of you, but the bullet passes straight through it!
    delay 500
quit
#shaunKnife
    msg &6{{curEnemy}-name}: &xYou should know better than to bring a knife to a gun fight, {playerName.}.
    delay msgDelay
quit
#shaunCoin
    if dileItem-count|>|0 msg &6{{curEnemy}-name}: &xHah! I'm not a ghost. The coin won't hurt me!
    if dileItem-count|>|0 quit
    msg &6{{curEnemy}-name}: &xHah! You WISH you knew how to make the ghosts fight for you, {playerName.}.
    delay msgDelay
quit
#shaunExt
    msg &6{{curEnemy}-name}: &xWhat the--GYYAAHGH!
    delay msgDelay
    msg &bShaun loses hold of his gun and it bounces away!
    set shaun-lostGun true
    set shaun-justLostGun true
    cmd tbot model enemy goodlyay+meleestance
    delay 1000
    set shaun-actionCount 3
    set shaun-action1 #shaunPunch
    set shaun-action2 #shaunKick
    set shaun-action3 #shaunLookGun
    set shaun-maxDamageReaction
    set shaun-carvingKnifeReaction
    set shaun-fireExtinguisherReaction
    set shaun-dileItemReaction
quit
#shaunDileReaction
    msg Dilehaunte quickly swoops in and rushes through shaun's gun!
    delay 1000
    call #shaunExt
quit
#shaunPunch
    msg &c{{curEnemy}-name} punches you!
    delay 1000
    call #damagePlayer|30
quit
#shaunKick
    msg &c{{curEnemy}-name} kicks you!
    delay 1000
    call #damagePlayer|30
quit
#shaunLookGun
    set shaun-justLostGun false
    msg {{curEnemy}-name} is looking for his gun...
    delay 1000
    setrandrange shaun-gunChance 1 10
    if shaun-gunChance|=|1 call #shaunFindsGun
quit
#shaunFindsGun
    msg &oand he finds it!
    cmd tbot model enemy goodlyay+gun
    call #shaunGunSetup
quit

// ------------------------------------ shadowy ------------------------------------
#shadowySetup
    set shadowy-name Shadowy Figure
    set shadowy-introPhrase appears!
    set shadowy-outtroPhrase is banished!
    set shadowy-defeat #defaultEnemyDefeat|10
    
    set shadowy-model g+shadowy
    set shadowy-skin https://dl.dropbox.com/s/ehjx4pdaffxywkz/bat.png
    call #changeThemeBackground|battle|themeSilence
    
    set shadowy-maxHealth 100
    set shadowy-curHealth {player-curHealth}
    
    set shadowy-turn #defaultEnemyTurn
    set shadowy-actionCount 1
    set shadowy-action1 #shadowyAttack
quit
#shadowyAttack
    msg &c{{curEnemy}-name} takes a swing at you!
    delay 1000
    setrandrange shadowyDamage 6 10
    setmul shadowyDamage 5
    call #damagePlayer|{shadowyDamage}
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- HEALTH METHODS ----------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------


//runArgs: health difference
#displayPlayerHealth
    call #calcDiffString|{runArg1}|diffString
    call #calcHPstring|{player-maxHealth}|{player-curHealth}|healthString
    
    ifnot diff|=|0 cpemsg bot1 &fYou: {healthString} {diffString} <
    ifnot diff|=|0 delay 100
    cpemsg bot1 &fYou: {healthString} {diffString}
quit
#removePlayerHealth
    cpemsg bot1
quit

#displayEnemyHealth
    call #calcDiffString|{runArg1}|diffString
    call #calcHPstring|{{curEnemy}-maxHealth}|{{curEnemy}-curHealth}|healthString
    
    ifnot diff|=|0 cpemsg top3 &f{{curEnemy}-name}: {healthString} {diffString} <
    ifnot diff|=|0 delay 100
    cpemsg top3 &f{{curEnemy}-name}: {healthString} {diffString}
quit
#removeEnemyHealth
    cpemsg top3 
quit

//runArgs: difference, out diffString
#calcDiffString
    set diff {runArg1}
    if diff|=| set diff 0
    set calcedDiffString {runArg2}
    set {calcedDiffString}
    if diff|=|0 quit
    
    if diff|>|0 set diffColor &c
    if diff|<|0 set diffColor &a+
    setmul diff -1
    set {calcedDiffString} {diffColor}{diff}
quit
//runArgs: difference, out diffString
#calcBuffString
    set diff {runArg1}
    if diff|=| set diff 0
    set calcedDiffString {runArg2}
    set {calcedDiffString}
    if diff|=|0 quit
    
    if diff|>|0 set diffColor &a+
    if diff|<|0 set diffColor &c
    set {calcedDiffString} {diffColor}{diff}
quit


//runArgs: max health, current health, out healthString
#calcHPstring
    
    set curHPmax {runArg1}
    set curHP {runArg2}
    set calcedHPstring {runArg3}
    
    //dead, set to skull
    if curHP|<=|0 set {calcedHPstring} %f┘
    if curHP|<=|0 quit
    
    set HPloopMax {curHPmax}
    setdiv HPloopMax 10
    set HPloop {curHP}
    setdiv HPloop 10
    setrounddown HPloop
    
    set {calcedHPstring} %c
    #calcHPloop
        if HPloopMax|=|0 quit
        if HPloop|=|0 call #calcLastHeart

        ifnot HPloop|=|0 set {calcedHPstring} {{calcedHPstring}}♥
        setsub HPloop 1
        setsub HPloopMax 1
    jump #calcHPloop
quit

#calcLastHeart
    set modded {curHP}
    setmod modded 10
    set lastHeart
    if modded|>|0 set lastHeart %4╝
    if modded|>|5 set lastHeart ♥
    set {calcedHPstring} {{calcedHPstring}}{lastHeart}
    set {calcedHPstring} {{calcedHPstring}}%0
    if modded|=|0 set {calcedHPstring} {{calcedHPstring}}♥
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- MISC SHIT? --------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#shouldKnock
    if knockMessage quit
    set knockMessage true
    msg &bYou: &xI should probably knock on the door.
quit
#tryFrontDoor
    set knockMessage true
    if decidingDoor quit
    set decidingDoor true
    freeze
    changemodel invisible
    msg You knock on the door...
    delay msgDelay
    msg No answer, but it seems to be unlocked. Enter?
    reply 1|&xEnter.|#enterHouse
    reply 2|&xNo, I'll stay outside.|#stayOutside
quit
#stayOutside
    unfreeze
    changemodel
    set decidingDoor false
quit

//runArgs: label to call, total times to loop, delay between loops
#genericLoop
    set labelToCall {runArg1}
    set loopCount {runArg2}
    set loopDelay {runArg3}
    
    set index 0
    #genericLoopStart
        call {labelToCall}|{index}
        delay loopDelay
        setadd index 1
        if index|<|loopCount jump #genericLoopStart
    quit
quit

#enterHouse
    freeze
    newthread #fadeOutTheme|main
    set doorTilt 0
    set doorZ {origDoorZ}
    cmd tbot summon frontdoor {doorX} {doorY} {doorZ} 0 {doorTilt}
    
    delay 500
    env maxfog 128
    env fog 000000
    env sky 000000
    
    cmd tpp 8192 5280 3760 0 0
    delay 1000
    call #genericLoop|#openDoorLoop|9|100
    delay 1000
    call #genericLoop|#moveDoorLoop|16|50
    call #fadeToBlack
    call #changeTheme|main|themeHouse
    delay 1000
    cmd tpp 8192 2048 3600 0 0
    delay 500
    call #fadeFromBlack
    delay 1000
    unfreeze
    changemodel
    cpemsg announce &bShaun's House?
    call #playTheme|main
    set decidingDoor false
    set frontDoorRespawnLocation 8192 2048 3600 0 0
    set respawnLocation {frontDoorRespawnLocation}
quit

#openDoorLoop
    setadd doorTilt 10
    cmd tbot summon frontdoor {doorX} {doorY} {doorZ} 0 {doorTilt}
quit
#moveDoorLoop
    setadd doorZ 0.5
    cmd tbot summon frontdoor {doorX} {doorY} {doorZ} 0 {doorTilt}
quit

#frontDoorLeave
    freeze
    changemodel invisible
    set frontDoorChoice true
    msg Would you like to touch the &6GHOST COIN &Sto the door?
    msg (this will end the adventure)
    reply 1|&xYes, it's time to go.|#endMap
    reply 2|&xI'm not ready yet.|#stayInside
quit
#fakeGetGhostCoin
    //This sequence is awkward without the get text which is invisible if you already have the coin
    msg &7You found a &6GHOST COIN&7!
quit
#endMap
    msg |
    msg |
    set creditsDelay 2000
    call #stopTheme|main
    call #changeThemeNoLoop|win|themeEnd
    call #playTheme|win
    call #fadeToWhite
    delay 2000
    if item GHOST_COIN call #fakeGetGhostCoin
    item get GHOST_COIN
    delay 2000
    msg &eThis coin unlocks the ┴ flair!
    msg &eUse &b/help flair &eto learn how to use it.
    #skipCoin
    delay 3000
    env fog CCCCCC
    delay 250
    env fog 999999
    delay 250
    env fog 666666
    delay 250
    env fog 333333
    delay 250
    env fog 000000
    delay 250
    if cef call #cefCredits
    call #displayPlayerStats
    if cef call #fadeOutThemeLong|win
    delay 1000
    cpemsg announce &6┴~ THE END ~┴
    delay 2000
    cmd main
quit
#cefCredits
    msg &a- Music credits! -
    delay 2000
    msg Pete theme:&u Professor Layton's London Life - Residence
    delay creditsDelay
    msg Shaun theme:&u Kevin Macleod - Look Busy
    delay creditsDelay
    msg Outside theme:&u Runescape - Spooky
    delay creditsDelay
    msg Interior theme:&u Luigi's Mansion 2 - Sticky Situation
    delay creditsDelay
    msg Ghist theme:&u Mother 3 - Dangerous Guys
    delay creditsDelay
    msg Victory theme:&u Mother 3 - You Won!
    delay creditsDelay
    msg Topjack theme:&u Mother 3 - Back Beat Battle
    delay creditsDelay
    msg Ghost theme:&u Off - Pepper Steak
    delay creditsDelay
    msg Foe door theme:&u Earthbound - Otherworldly Foe
    delay creditsDelay
    msg Occupied Armor theme:&u Mother 3 - Astonishing March
    delay creditsDelay
    msg Polterblast theme:&u Mother 3 - Mr. Batty Twist
    delay creditsDelay
    msg Dilehaunte talk:&u Luigi's Mansion - Talking With Ghosts
    delay creditsDelay
    msg Dilehaunte battle:&u Mad Rat Dead - Mad Rat Heart
    delay creditsDelay
    msg Ghust theme:&u Mad Rat Dead - plash, plop, gurgle (HQ rip)
    delay creditsDelay
    msg Shaun theme:&u Persona 5 - Last Surprise
    delay creditsDelay
    msg Credits theme:&u Chrono Trigger - Fanfare I
    delay 2000
quit
#stayInside
    unfreeze
    changemodel
    set frontDoorChoice
quit
#tryFrontDoorInterior
    if frontDoorChoice quit
    if #shaunBattle jump #frontDoorLeave
    if shaunAtDoor msg Shaun is in the way.
    if shaunAtDoor quit
    setadd tryFrontDoorInteriorCount 1
    set doorZ {MBZ}
    setadd doorZ -1
    cmd effect electric {MBX} {MBY} {doorZ} 0 0 0
    if tryFrontDoorInteriorCount|=|1 msg &bYou: &xOuch!
    cmd boost 0 2 -4 1 1 1 1000
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    delay 100
    cmd effect ghost {MBX} {MBY} {doorZ} 0 0 0
    //if tryFrontDoorInteriorCount|=|1 msg &bYou: &xUh oh.
    //if tryFrontDoorInteriorCount|=|1 call #noTrunk
quit
#noTrunk
    ifnot lookedTrunk quit
    delay msgDelay
    msg &bYou: &xLooks like I'm not going back for my supplies after all.
quit



//runArgs: x, y, z pos center of door (min justified)
#unlockDoorNS
    set unlockingDoor true
    freeze
    changemodel invisible
    
    tempblock openchest {MBCoords}
    set sparkly {MBY}
    setadd sparkly 0.5
    cmd effect sparkleprecise {MBX} {sparkly} {MBZ} 0 0 0
    delay 1000
    if {runArg0} msg The door is unblocked now!
    
    cmd tp {unlockDoorLocation}
    delay 500
    ifnot {runArg0} cmd tp {unlockDoorLocation}
    delay 500
    
    set doorX {runArg1}
    set doorY {runArg2}
    set doorZ {runArg3}
    setadd doorY 1
    setadd doorZ 0.5
    ifnot {runArg0} cmd effect explosionsteam {doorX} {doorY} {doorZ} 0 0 0
    setadd doorY -1
    setadd doorZ -0.5
    setadd doorX -1
    
    call #doorNSBoardLayer
    setadd doorY 2
    call #doorNSBoardLayer
    ifnot {runArg0} delay 2000
    if {runArg0} delay 1000
    cmd tp {preUnlockDoorLocation}
    delay 500
    unfreeze
    changemodel
    set {runArg0} true
    set unlockingDoor false
quit
#doorNSBoardLayer
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorZ 1
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorX 2
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorZ -1
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorX -2
quit



//runArgs: x, y, z pos center of door (min justified)
#unlockDoorWE
    set unlockingDoor true
    freeze
    changemodel invisible
    
    tempblock openchest {MBCoords}
    set sparkly {MBY}
    setadd sparkly 0.5
    cmd effect sparkleprecise {MBX} {sparkly} {MBZ} 0 0 0
    delay 1000
    if {runArg0} msg The door is unblocked now!
    
    cmd tp {unlockDoorLocation}
    delay 500
    ifnot {runArg0} cmd tp {unlockDoorLocation}
    delay 500
    
    set doorX {runArg1}
    set doorY {runArg2}
    set doorZ {runArg3}
    setadd doorY 1
    setadd doorX 0.5
    ifnot {runArg0} cmd effect explosionsteam {doorX} {doorY} {doorZ} 0 0 0
    setadd doorY -1
    setadd doorX -0.5
    setadd doorZ -1
    
    call #doorWEBoardLayer
    setadd doorY 2
    call #doorWEBoardLayer
    ifnot {runArg0} delay 2000
    if {runArg0} delay 1000
    cmd tp {preUnlockDoorLocation}
    delay 500
    unfreeze
    changemodel
    set {runArg0} true
    set unlockingDoor false
quit
#doorWEBoardLayer
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorX 1
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorZ 2
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorX -1
    tempblock air {doorX} {doorY} {doorZ}
    setadd doorZ -2
quit


// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- UNLOCK DOORS ------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------


//runArgs: string label of battle that must be won
#requireBattle
    //todo put this back
    ifnot {runArg1} msg Not so fast! It's currently sealed by some kind of ghostly force.
    ifnot {runArg1} terminate
quit
#unlockLeftFoyer
    call #requireBattle|#firstBattle
    set preUnlockDoorLocation 256 73 117 358 49
    set unlockDoorLocation 251 64 106 334 0
    call #unlockDoorWE|248|64|100|
quit
#unlockRightFoyer
    call #requireBattle|#musicBattle
    set preUnlockDoorLocation 238 38 97 226 35
    set unlockDoorLocation 259 64 106 32 0
    call #unlockDoorWE|262|64|100
quit
#unlockFirstBedroom
    call #requireBattle|#kitchenBattle
    set preUnlockDoorLocation 290 52 89 54 329
    set unlockDoorLocation 261 73 93 270 0
    call #unlockDoorNS|246|73|93
quit
#unlockMiddleFoyer
    set preUnlockDoorLocation 238 52 98 240 29
    set unlockDoorLocation 254 64 101 0 0
    call #unlockDoorWE|253|64|91
quit
#unlockKitchenDoor
    tempblock air 280 52 92
    tempblock air 281 52 92
    tempblock air 280 54 92
    tempblock air 281 54 92
    cmd tpp 8992 1664 2960
quit
#unlockArmory
    call #requireBattle|#poolBattle
    set preUnlockDoorLocation 238 38 74 23 25
    set unlockDoorLocation 254 64 89 32 0
    call #unlockDoorNS|258|64|83
quit
#armoryPotion
    call #requireBattle|#armoryBattle
    call #getItem|redPotion
quit
#unlockHearth
    call #requireBattle|#armoryBattle
    set preUnlockDoorLocation 261 24 73 333 4
    set unlockDoorLocation 265 64 89 64 0
    call #unlockDoorWE|270|64|86
quit
#unlockSecondBedroom
    ifnot #dilehaunteBattle quit
    if talkingDile msg Can't do that while someone is talking to you.
    if talkingDile quit
    set preUnlockDoorLocation 290 64 76 64 28
    set unlockDoorLocation 260 73 84 271 0
    call #unlockDoorNS|246|73|83
quit
#unlockLibrary
    call #requireBattle|#armoryBattle
    set preUnlockDoorLocation 239 24 90 270 29
    set unlockDoorLocation 248 73 83 91 0
    call #unlockDoorNS|265|73|83
quit
#unlockBasement
    set preUnlockDoorLocation 271 15 102 254 1
    set unlockDoorLocation 257 59 96 143 15
    call #unlockDoorNS|260|58|99
    
    //open self
    tempblock openchest 272 17 102
    //one in mirror
    tempblock openchest 258 17 102
    //move drawers
    tempblock air 266 15 103
    tempblock air 266 16 103
    tempblock Drawers-NS 266 15 102
    tempblock Drawers-NS 266 16 102
    //unblock door outside
    tempblock air 264 73 104
    tempblock air 264 73 103
    tempblock air 264 75 103
    tempblock air 264 75 104
quit
#librarySign
    msg                 · ∙ ·
    msg  Thoughtful reflection
    msg Is the key to progress
    msg                 · ∙ ·
quit
#unlockDungeon
    call #requireBattle|#barBattle
    set preUnlockDoorLocation 308 34 161 180 39
    set unlockDoorLocation 267 54 161 230 0
    call #unlockDoorWE|262|54|165
quit
#unlockRestroom
    call #requireBattle|#polterblastBasementBattle
    set preUnlockDoorLocation 303 51 162 90 4
    set unlockDoorLocation 252 64 105 82 358
    call #unlockDoorNS|265|64|103
quit
#getRestroomPotion
    tempblock openchest 288 37 109
    call #getItem|redPotion
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- DILEHAUNTE --------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#chairCutscene
    //okias thing todo remove
    //terminate

    if #dilehaunteBattle quit
    if chairCutsceneDone quit
    set chairCutsceneDone true
    setadd chairCutsceneTimesSeen 1
    
    
    call #changeThemeBackground|battle|themeGhostTalk
    call #stopTheme|main
    freeze
    changemodel invisible
    cmd boost 0 1 0 1 1 1
    delay 1000
    if chairCutsceneTimesSeen|>|1 jump #dilehaunteQuickBattle
    
    call #resetChair
    call #fadeToBlack
    delay 500
    //cutscene coords
    cmd tp 279 64 78 90 0
    delay 500
    call #fadeFromBlack
    call #turnChair
    delay 1000
    call #ghostRise
    delay 800
    call #playTheme|battle
    delay 1000
    call #dileIntro
quit
#chairCutsceneEnd
    unfreeze
    call #turnChairBack
    call #fadeOutTheme|battle
    call #playTheme|main
quit
#resetChair
    set ghostY 61
    cmd tbot summon dilehaunte 286 {ghostY} 78 270 0
    tempchunk 285 63 77 287 68 79 285 63 77
quit
#turnChairBack
    tempchunk 285 63 77 287 68 79 285 63 77
    cmd effect explosionsteam 286 64 78 0 0 0
    cmd tbot summon dilehaunte 287 64 78 90 0
    tempblock speech 287 67 78
quit
#turnChair
    call #resetChair
    delay 1000
    
    tempchunk 285 56 77 287 61 79 285 63 77
    cmd effect explosionsteam 286 64 78 0 0 0
    delay 2000
    tempchunk 281 56 77 283 61 79 285 63 77
    cmd effect explosionsteam 286 64 78 0 0 0
quit
#ghostRise
    set ghostY 61
    cmd tbot summon dilehaunte 286 {ghostY} 78 270 0
    call #genericLoop|#ghostMoveUp|24|64
quit
#ghostMoveUp
    setadd ghostY 0.125
    cmd tbot summon dilehaunte 286 {ghostY} 78 270 0
quit
#dileIntro
    msg &]Ghost: &xCome now, put that bat down.
    delay msgDelay
    msg &]Ghost: &xThe other spirits may be of a wicked sort, but I, the Diplomatic Dilehaunte, have no need to fight you.
    delay msgDelay
    msg &]Dilehaunte: &xWhy have you come here?
    delay 1000
    call #dileReplies
quit
#dileReplies
    reply 1|&bYou: &xI was hired for pest control.|#replyPestControl
    reply 2|&bYou: &xI'm looking for Shaun.|#replyWhereShaun
    if tryFrontDoorInteriorCount|>|0 reply 3|&bYou: &xI can't leave.|#replyCantLeave
    if tryFrontDoorInteriorCount|<=|0 reply 3|&bYou: &xNo particular reason.|#replyNoReason
quit
#replyPestControl
    msg &bYou: &xI was hired for pest control.
    delay 1000
    msg &]Dilehaunte: &xI'm afraid someone has pranked you. No pests here; we take care of the house just fine.
    delay msgDelay
    jump #dileLeave
quit
#replyWhereShaun
    msg &bYou: &xI'm looking for Shaun.
    delay 1000
    msg &]Dilehaunte: &xI don't know of any Shauns. Just a word of advice, though...
    delay msgDelay
    jump #dileLeave
quit
#dileReplies2
    
quit
#replyCantLeave
    msg &bYou: &xI can't leave.
    delay 1000
    msg &]Dilehaunte: &xAh, that's right... the front door trap.
    delay msgDelay
    #explainDoor
    msg &]Dilehaunte: &xYesterday, some oaf was bothering the other spirits. After chasing him out, they hexed the door to teach him a lesson if he came back.
    delay msgDelay
    msg &]Dilehaunte: &xOnly the power of the &6GHOST COIN&x, with its control over the spirits, is strong enough to break that hex.
    delay msgDelay
    msg &]Dilehaunte: &x...
    delay msgDelay
    msg &]Dilehaunte: &xHm. I shouldn't have told you that.
    delay msgDelay
    msg &]Dilehaunte: &x...
    delay msgDelay
    msg &]Dilehaunte: &xApologies, but I have to kill you now.
    delay msgDelay
    
    call #dilehaunteBattle
    //unfreeze
    //changemodel
quit
#replyNoReason
    msg &bYou: &xNo particular reason.
    delay 1000
    #dileLeave
    msg &]Dilehaunte: &xI suggest you leave this property immediately. The other spirits don't enjoy visitors much.
    delay msgDelay
    msg &]Dilehaunte: &xAh, I'm sorry. I just remembered that you can't.
    delay msgDelay
    jump #explainDoor
quit
#dilehaunteQuickBattle
    msg &]Dilehaunte: &xWe both know how this will go, yes? Let's get to it.
    delay msgDelay
    jump #dilehaunteBattle
quit
#dilehaunteBattle
    set curBattle #dilehaunteBattle
    call #setCurArena|defaultArena
    call #setCurEnemy|dilehaunte
    call #startBattle
    set overworldLocation 279 64 78 90 0
    //in case player dies the cutscene needs to be able to trigger next time
    set chairCutsceneDone false
quit
#dilehaunteTalk
    if dileItem-count|>|0 quit
    if unlockingDoor quit
    set talkingDile true
    tempblock air {MBCoords}
    freeze
    if ghostCoin-count|>|0 jump #dilehaunteTalkAfterGotCoin
    msg &]Dilehaunte: &xIf you're strong enough to defeat me, I have no doubt you'll find a way to get the &6GHOST COIN&x...
    delay msgDelay
    set nick boss
    if playerPronouns.|=|hehim set nick master
    if playerPronouns.|=|sheher set nick mistress
    msg &]Dilehaunte: &xAlas. I hope you'll be a better {nick} than that wretched old Crowley.
    delay 1000
    unfreeze
    tempblock speech {MBCoords}
    set talkingDile
quit
#dilehaunteTalkAfterGotCoin
    msg &]Dilehaunte: &xSo, you've acquired the &6GHOST COIN&x...
    delay msgDelay
    msg &]Dilehaunte: &xIf you'd like to leave, all you need is to touch it to the door.
    delay 1000
    ifnot #shaunBattle jump #dilehaunteHelpOption
    if #shaunBattle jump #dilehaunteShaunOption
    #dilehaunteTalkEnd
    unfreeze
    //no MBCoords since reply gives 0 0 0
    tempblock speech 287 67 78
    set talkingDile
quit
#dilehaunteShaunOption
    reply 1|&xTell Dilehaunte about Shaun|#replyTellAboutShaun
    reply 2|&xLeave|#dilehaunteTalkEnd
quit
#dilehaunteHelpOption
    reply 1|&bYou: &xI command you to assist me!|#dilehaunteHelp
    reply 2|&xLeave|#dilehaunteTalkEnd
quit
#dilehaunteHelp
    msg &bYou: &xI command you to assist me!
    delay 1000
    msg &]Dilehaunte: &xOh dear. Well, I can't protest against the power of the &6GHOST COIN&x.
    delay msgDelay
    
    set item dileItem
    cmd effect explosionsteam 286 64 78 0 0 0
    cmd tempbot model dilehaunte 0
    call #getReusableItem|dileItem
    tempblock air 287 65 78
    tempblock air 287 66 78
    tempblock air 287 67 78
    tempblock air 287 68 78
    delay 2000
    msg &]Dilehaunte: &xAt your service.
    
    //jump #dilehaunteTalkEnd don't do this since we don't want speech bubble to re-appear
    unfreeze
    set talkingDile
quit
#replyTellAboutShaun
    msg You tell Dilehaunte about Shaun.
    delay 1000
    msg &]Dilehaunte: &xSo, Shaun must have been that oaf from yesterday. Seems like he's brought you a terrible bit of inconvenience.
    delay msgDelay
    set nick individual
    if playerPronouns.|=|hehim set nick lad
    if playerPronouns.|=|sheher set nick lass
    set hearthComment .
    if hearthOff set hearthComment &x (if we ignore the fireplace fiasco).
    msg &]Dilehaunte: &xYou seem like a good natured {nick}{hearthComment}
    delay msgDelay
    msg &]Dilehaunte: &xAs a favor after you depart, I'll get everyone to reseal the door again and we'll take "good care" of Shaun here.
    delay 1000
    jump #dilehaunteTalkEnd
quit
#hearthExt
    if unlockingDoor quit
    ifnot #dilehaunteBattle quit
    if talkingDile msg Can't do that while someone is talking to you.
    if talkingDile quit
    if fireExtinguisher-count|>|0 msg You've already found {fireExtinguisher-name} &Shere.
    if fireExtinguisher-count|>|0 quit
    
    call #getItem|fireExtinguisher
    freeze
    delay 1000
    msg &]Dilehaunte: &xNow what could you possibly need that for?
    delay 1000
    unfreeze
quit
#hearth
    if unlockingDoor quit
    if talkingDile msg Can't do that while someone is talking to you.
    if talkingDile quit
    if fireExtinguisher-count|<|1 msg Yep, that's fire!
    if fireExtinguisher-count|<|1 quit
    freeze
    cmd effect explosionsteam 293 64 78 0 0 0
    tempchunk 291 57 77 295 60 79 291 63 77
    delay 1000
    msg &]Dilehaunte: &xOf course.
    set hearthOff true
    delay 1000
    unfreeze
quit
#dilehaunteFun
    ifnot #dilehaunteBattle quit
    if dilehaunteFun quit
    set dilehaunteFun true
    msg &]Dilehaunte: &xHaving fun up there?
    delay 1000
quit

// ---------------------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------- GHOST COIN --------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------

#ghostCoinGlass
    if unlockingDoor quit
    ifnot #firstBattle quit
    if ghostCoinGlassBroken jump #ghostCoin
    if item MAGIC_HAMMER jump #breakGhostCoinGlass
    freeze
    msg Seems to be some kind of magical barrier.
    if #dilehaunteBattle delay 1000
    if #dilehaunteBattle msg According to Dilehaunte, this coin should allow me to escape.
    if #dilehaunteBattle msg Is there an artifact in this house capable of breaking it?
    unfreeze
quit
#ghostCoin
    //already have
    if ghostCoin-count|>|0 quit
    set ghostCoin-count 1
    freeze
    cmd tbot model ghostcoin 0
    msg Found a supply: {ghostCoin-name}&S!
    msg Use &b/input supplies &Sto see them all.
    delay 1000
    msg &bI should be able to open the front door with this!
    delay 1000
    unfreeze
    set respawnLocation 8192 2336 3504 0 0
    call #moveShaunToDoor
quit
#breakGhostCoinGlass
    freeze
    msg You use the &6MAGIC HAMMER &Son the barrier.
    delay 1000
    tempchunk 254 74 137 257 76 140 254 74 113
    delay 50
    cmd effect explosionsteam 255.5 74.5 114.5 0 0 0
    set ghostCoinGlassBroken true
    msg &e*CRASH*
    unfreeze
quit
#resetShaun
    set shaunAtDoor false
    tempblock Board-W 253 64 94
    tempblock Board-W 253 65 94
    tempblock Board-W 253 66 94
    cmd tbot summon shaun 252 64 94 90 0
quit
#moveShaunToDoor
    //call #resetShaun
    delay 1000
    set shaunAtDoor true
    tempblock Board-N 253 64 94
    tempblock Board-N 253 65 94
    tempblock Board-N 253 66 94
    delay 500
    cmd tbot ai shaun move 253 64 94,wait 5,move 255.5 64 112 28,stare
quit
#shaunDoorTalk
    if #shaunBattle quit
    ifnot shaunAtDoor quit
    if shaunCutscene quit
    set shaunCutscene true
    
    call #stopTheme|main
    freeze
    changemodel invisible
    delay 1000
    setadd shaunCutsceneTimesSeen 1
    if shaunCutsceneTimesSeen|>|1 jump #shaunThreat
    
    set shaunPraise hero of the house
    if playerPronouns.|=|hehim set shaunPraise man of the hour
    if playerPronouns.|=|sheher set shaunPraise woman of the hour
    msg &6Shaun: &xWell well well! If it isn't the {shaunPraise}, @nick!
    if @Pestcontrol_usedPeteSlogan. delay msgDelay
    if @Pestcontrol_usedPeteSlogan. msg &6Shaun: &xIt really is like you say, then: No One Beats Pete's! Hahaha.
    delay msgDelay
    msg &6Shaun: &xSeems like you did a pretty good job at clearing out those "pests", and what's this?
    delay msgDelay
    msg &6Shaun: &xYou've even picked up the &6GHOST COIN&x just for me.
    delay msgDelay
    msg &6Shaun: &xNow, hand it over if you would.
    delay 1000
    reply 1|&bYou: &xI'd like to be paid for my time first.|#replyPaid
    reply 2|&bYou: &xIt doesn't belong to you.|#replyNo
    //unfreeze
    //changemodel
quit
#replyPaid
    msg &bYou: &xI'd like to be paid for my time first.
    delay 1000
    msg &6Shaun: &xPayment? Hah! You don't get it, do you. Once I own the &6GHOST COIN&x, I'll be above such things.
    delay msgDelay
    msg &6Shaun: &xWith the spirits under my control, not even the law will be able to stop me.
    delay msgDelay
    #shaunThreat
    msg &6Shaun: &xThis is non-negotiable. Give me the coin NOW, or I'll take it from your dead hands.
    delay 1000
    reply 1|&bYou: &xI'd like to see you try.|#replyClapBack
quit
#replyNo
    msg &bYou: &xIt doesn't belong to you.
    delay 1000
    msg &6Shaun: &xI don't care who it belongs to. Once I have the power to control the spirits, I'll take whatever I want, whenever I want.
    delay msgDelay
    jump #shaunThreat
quit
#replyClapBack
    msg &bYou: &xI'd like to see you try.
    delay 1000
    set curBattle #shaunBattle
    call #setCurArena|defaultArena
    call #setCurEnemy|shaun
    call #startBattle
    set overworldLocation 256 64 106 180 0
    //in case player dies the cutscene has to be turned off so it can play again
    set shaunCutscene false
quit



#answerChestRiddle
    ifnot gotRiddleHint quit
    if solvedRiddle msg You already solved the riddle.
    if solvedRiddle quit
    call #canAnswerRiddle?
    set riddleAnswer {inputRunArg2}
    msg &bYou: &x{riddleAnswer}?
    if riddleAnswer|=|hammer jump #answerChestRiddleCorrect
    if riddleAnswer|=|hammah jump #answerChestRiddleCorrect
    if riddleAnswer|=|hamma jump #answerChestRiddleCorrect
    if riddleAnswer|=|crowbar jump #answerChestRiddleCorrect
    delay 3000
    msg ...
    delay 1000
    msg That doesn't seem to be the answer.
    setadd wrongGuesses 1
    if wrongGuesses|=|3 msg &iSkull: &xPsst. It can be held in one hand.
    if wrongGuesses|=|6 msg &iSkull: &xPsst. It can aid destruction or construction.
quit
#answerChestRiddleCorrect
    tempblock magicchest 283 39 193
    delay 1000
    cmd effect sparkleprecise 283 40 193 0 0 0
    delay 250
    cmd effect sparkleprecise 283 39.75 193 0 0 0
    delay 250
    cmd effect sparkleprecise 283 39.5 193 0 0 0
    delay 250
    tempblock chest-s 283 39 193
    cmd effect blue 283 39 193 0 0 0
    msg The seal is gone!
    set solvedRiddle true
quit
#canAnswerRiddle?
    if PlayerX|<|227 goto #answerCloser
    if PlayerX|>|287 goto #answerCloser
    
    if PlayerY|<|38 goto #answerCloser
    if PlayerY|>|40 goto #answerCloser
    
    if PlayerZ|<|188 goto #answerCloser
    if PlayerZ|>|193 goto #answerCloser
quit
#answerCloser
    msg You need to be closer to the chest to answer the riddle.
    terminate
quit
#chestRiddle
    ifnot #magicHammerBattle quit
    msg &xThere's an inscription here.
    msg -
    msg I have a head, but can't see
    msg I have claws, but no fingers
    msg I can drive, but I won't take you anywhere.
    msg I can pry, but I am not nosy.
    msg What am I?
    msg -
    msg &xSeems like a riddle. Use &b/input riddle [answer] &xto answer!
    set gotRiddleHint true
quit
#riddleChest
    ifnot #magicHammerBattle quit
    ifnot solvedRiddle jump #riddleChestLocked
    tempblock openchest {MBCoords}
    if item MAGIC_HAMMER msg You already found the &6MAGIC HAMMER &Shere.
    item get MAGIC_HAMMER
    tempblock interest 279 40 189
quit
#riddleChestLocked
    msg A magic seal prevents it from opening!
    msg Maybe the plaque has a hint.
quit
#magicSkull
    ifnot item MAGIC_HAMMER quit
    if talkingMagicSkull quit
    set talkingMagicSkull true
    tempblock air 279 40 189
    freeze
    changemodel invisible
    msg &iSkull: &xPsst. I can take you to my twin at the other end of this dungeon. How about it?
    reply 1|&xTouch the skull|#skullTP
    reply 2|&xDo not touch|#noSkullTP
quit
#skullTP
    cmd tp 261 38 169
    delay 1000
    unfreeze
    changemodel
    set talkingMagicSkull false
    tempblock interest 279 40 189
quit
#noSkullTP
    msg &iSkull: &xCome on, I don't bite! I don't even have a lower jaw! Har har.
    delay 1000
    set talkingMagicSkull
    unfreeze
    changemodel
    tempblock interest 279 40 189
quit




