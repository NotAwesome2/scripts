

#explain
    tempblock air {MBCoords}
    msg |
    msg Welcome to Minesweeper! Click the &agreen button&S to get started.
    msg The &eyellow&S and &oorange&S buttons change your click mode to &xclear&S a tile or &xflag&S a tile, respectively.
    delay 1000
    tempblock speech {MBCoords}
    
    if explained1 quit
    cmd effect explosionsteamsmall 6 1 12 0 0 0
    delay 250
    tempblock interest 6 1 12
    set explained1 true
quit
#explain2
    ifnot explained1 quit
    tempblock air {MBCoords}
    msg |
    msg The goal of the game is to clear all of the tiles that do not have mines under them.
    msg The number on a cleared tile tells you how many mines are next to it, including diagonals.
    delay 1000
    tempblock speech {MBCoords}
    
    if explained2 quit
    cmd effect explosionsteamsmall 8 1 12 0 0 0
    delay 250
    tempblock interest 8 1 12
    set explained2 true
quit

#explain3
    ifnot explained2 quit
    tempblock air {MBCoords}
        msg |
    msg If you suspect a tile has a mine under it, flag it! This helps you keep track and makes it so you can't accidentally click on them.
    //msg You can setup hotkeys with &b/input clear&S
    //msg &f>&S and &b/input flag&S if you don't want to have to click the buttons.
    delay 1000
    tempblock speech {MBCoords}
    
    
    set explained3 true
quit



#input
    if runArg1|=|InputMode.Clear goto #setInputMode|clear
    if runArg1|=|InputMode.Flag goto #setInputMode|flag
    
    msg Minesweeper: unknown input mode "&o{runArg1}&S"!
    msg Minesweeper: Valid input modes: &xclear&S, &xflag
quit

#canStartGame?
    set canStart true
    if gameState|=|GameState.Playing set canStart false
    if gameState|=|GameState.Losing set canStart false
    ifnot canStart msg You can't restart the game until you've won or lost.
    ifnot canStart terminate
quit

#startGame
    //runargs: board x and y length
    set BOARD_X_MAX {runArg1}
    set BOARD_Y_MAX {runArg2}
    //largest index, aka count -1
    setsub BOARD_X_MAX 1
    setsub BOARD_Y_MAX 1
    
    set GameState.Playing playing
    set GameState.Losing losing
    set GameState.Lost lost
    set GameState.Won won
    
    set InputMode.Flag flag
    set InputMode.Clear clear
    
    set Tile.State.Covered covered
    set Tile.State.Uncovered uncovered
    set Tile.State.Flagged flagged
    set Tile.Block.Mine hotcoals
    set Tile.Block.Clear concreteblock
    
    call #canStartGame?
    
    set curTotalCoveredSafeSpaces 0
    set hasMoved false
    
    call #2Dloop|0|0|{BOARD_X_MAX}|{BOARD_Y_MAX}|#setupTile
    cpemsg bot1 ☻
    cpemsg bot3
    //cpemsg bot3 Tiles left: &x{curTotalCoveredSafeSpaces}
    set gameState {GameState.Playing}
    msg Game setup!
    call #defineHotkeys
    //msg Clear all the tiles that don't have mines under them to win.
    //msg The number in a cleared tile tells you how many mines are next to the tile, counting diagonals.
quit

#defineHotkeys
    msg Press the &bV&S key to to enter &xflag&S mode
    msg Press the &b~&S key to to enter &xclear&S mode
    definehotkey flag|V
    definehotkey clear|GRAVE
quit


#setInputMode
    set inputMode {runArg1}
    msg Clicking mode set to: &x{inputMode}
    cpemsg bot2 Mode: &x{inputMode}
quit


#click
    if gameState|=| msg Game isn't setup yet!
    if gameState|=| quit
    if gameState|=|GameState.Losing msg The game is over.
    if gameState|=|GameState.Losing quit
    if gameState|=|GameState.Lost msg The game is over.
    if gameState|=|GameState.Lost quit
    call #clickAt|{MBX}|{MBY}
quit

#clickAt
    set x {runArg1}
    set y {runArg2}
    if inputMode|=|InputMode.Flag goto #tryFlagTile
    if inputMode|=|InputMode.Clear goto #tryClearTile|{x}|{y}
    msg Choose a clicking mode before clicking a tile!
quit

#2Dloop
    set xMin {runArg1}
    set yMin {runArg2}
    set xMax {runArg3}
    set yMax {runArg4}
    set loopTask {runArg5}
    
    
    set yi {yMin}
    #yLoop
        
        set xi {xMin}
        #xLoop
            call {loopTask}|{xi}|{yi}
            setadd xi 1
            if xi|>|xMax jump #xLoopBreak
        jump #xLoop
        #xLoopBreak
        
        
        setadd yi 1
        if yi|>|yMax quit
    jump #yLoop
quit

#setupTile
    set x {runArg1}
    set y {runArg2}
    setrandrangedecimal r 0 1
    set block {Tile.Block.Clear}
    setadd curTotalCoveredSafeSpaces 1
    if r|<=|0.2 call #isMine
    //was 0.2
    set tile[{x},{y}].block {block}
    set tile[{x},{y}].state {Tile.State.Covered}
    tempblock Iron {x} {y} 0
    //tempblock {tile[{x},{y}].block} {x} {y} 0
quit
#isMine
    set block {Tile.Block.Mine}
    setsub curTotalCoveredSafeSpaces 1
quit


#tryFlagTile
    if tile[{x},{y}].state|=|Tile.State.Covered goto #flagTile
    if tile[{x},{y}].state|=|Tile.State.Flagged goto #unflagTile
quit

#flagTile
    set tile[{x},{y}].state {Tile.State.Flagged}
    tempblock Flagged {x} {y} 0
quit
#unflagTile
    set tile[{x},{y}].state {Tile.State.Covered}
    tempblock Iron {x} {y} 0
quit



#tryClearTile
    set x {runArg1}
    set y {runArg2}
    ifnot tile[{x},{y}].state|=|Tile.State.Covered quit
    
    call #tryClearTileCore
    //If there are no mines around this tile, try to clear everything around it
    if curTotalMines|=|0 call #tryFillClear
quit
#tryClearTileCore

    cmd effect electric {x} {y} 1 0 0 0
    
    ifnot hasMoved call #checkIfFirstMoveIsMine
    set hasMoved true
    
    cpemsg bot1 ═
    call #calcNumberOfMinesAroundCell
    call #placeTileBlock
    if tile[{x},{y}].block|=|Tile.Block.Mine goto #gameOver
    setsub curTotalCoveredSafeSpaces 1
    cpemsg bot3 Tiles left: &x{curTotalCoveredSafeSpaces}
    set tile[{x},{y}].state {Tile.State.Uncovered}
    cpemsg bot1 ☻
    if curTotalCoveredSafeSpaces|=|0 goto #won
quit
#checkIfFirstMoveIsMine
    ifnot tile[{x},{y}].block|=|Tile.Block.Mine quit
    setadd curTotalCoveredSafeSpaces 1
    set tile[{x},{y}].block {Tile.Block.Clear}
quit


// ---------------------------------------------------------------------------------------- Fill v
//runArgs: x y pos of node
#queueNode
    set stack[{stack-count}].x {runArg1}
    set stack[{stack-count}].y {runArg2}
    setadd stack-count 1
quit
//inserts the last entry of the stack into curNode Vector2 structure
#dequeueNode
    setadd stack-count -1
    set curNode.x {stack[{stack-count}].x}
    set curNode.y {stack[{stack-count}].y}
quit
#tryFillClear
    set stack-count 0
    call #queueNode|{x}|{y}
    
    #fillLoop
        call #dequeueNode
        set x {curNode.x}
        set y {curNode.y}
        
        
        setadd x -1
        setadd y -1
        
        call #fillBody
        setadd x 1
        call #fillBody
        setadd x 1
        call #fillBody
        setadd y 1
        setadd x -2
        
        call #fillBody
        setadd x 1
        call #fillBody
        setadd x 1
        call #fillBody
        setadd y 1
        setadd x -2
        
        call #fillBody
        setadd x 1
        call #fillBody
        setadd x 1
        call #fillBody
        setadd y 1
        setadd x -2
        
    if stack-count|>|0 jump #fillLoop
    //msg Done fill clear.
quit
#fillBody
    if x|<|0 quit
    if y|<|0 quit
    if x|>|BOARD_X_MAX quit
    if y|>|BOARD_Y_MAX quit
    
    //msg fill body {x} {y}
    //only act on uncleared tiles
    ifnot tile[{x},{y}].state|=|Tile.State.Covered quit
    
    //clear the tile
    call #tryClearTileCore|{x}|{y}
    
    
    call #calcNumberOfMinesAroundCell
    ifnot curTotalMines|=|0 quit
    //only queue to do another round of fill if there's no mines at the spot we just uncovered
    call #queueNode|{x}|{y}
quit
// ---------------------------------------------------------------------------------------- Fill ^

#placeTileBlock
    set block {tile[{x},{y}].block}
    if block|=|Tile.Block.Mine jump #placeIt
    
    if curTotalMines|>|0 set block 484
    if curTotalMines|>|0 setadd block curTotalMines
    #placeIt
    tempblock {block} {x} {y} 0
quit

#calcNumberOfMinesAroundCell
    set curTotalMines 0
    
    set xMin {x}
    setadd xMin -1
    set yMin {y}
    setadd yMin -1
    
    set xMax {x}
    setadd xMax 1
    set yMax {y}
    setadd yMax 1
    
    call #2Dloop|{xMin}|{yMin}|{xMax}|{yMax}|#checkMine
    //show curTotalMines
quit

#checkMine
    set xMineCheck {runArg1}
    set yMineCheck {runArg2}
    if tile[{xMineCheck},{yMineCheck}].block|=|Tile.Block.Mine setadd curTotalMines 1
quit

#explodeMine
    set x {runArg1}
    set y {runArg2}
    if tile[{x},{y}].block|=|Tile.Block.Mine call #doExplosion
quit
#doExplosion
    cmd effect explosion {x} {y} 0 0 0 0
    tempblock {Tile.Block.Mine} {x} {y} 0
    //delay 100
quit

#gameOver
    cmd effect explosion {MBCoords} 0 0 0
    cpemsg announce &cGAME OVER
    msg &cGAME OVER
    cpemsg bot1 ┘
    msg You died with &x{curTotalCoveredSafeSpaces}&S tiles left to clear.
    set gameState {GameState.Losing}
    call #2Dloop|0|0|{BOARD_X_MAX}|{BOARD_Y_MAX}|#explodeMine
    set gameState {GameState.Lost}
quit

#won
    cpemsg announce &aYOU WIN!
    msg &aYOU WIN!
    cpemsg bot1 ╔
    set gameState {GameState.Won}
quit

