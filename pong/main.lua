WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'

-- Loads outs our screen for the game
function love.load()
    -- Sets up the filter for love to minimize and magnify images and text clearly
    love.graphics.setDefaultFilter('nearest', 'nearest') 

    -- Sets a font to the variable smallFont from file font.TTf with a size of 8
    smallFont = love.graphics.newFont('font.ttf', 8)
    
    -- Sets a font to the variable scoreFont from file font.TTf with a size of 32
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Sets up the players scores and the y value for their paddles
    player1Score = 0
    player2Score = 0
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 40


    ballStartUp()

    --Sets up the state for th gam
    gameState = 'start'

    -- Sets up the screeen and its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        vsync = true,
        resizable = false
    })
end

-- Sets the balls x and y and velocity values to its starting values
function ballStartUp()
    math.randomseed(os.time())
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2
    ballDX = math.random(2) == 1 and -100 or 100
    ballDY = math.random(-50, 50)
end

-- Updates the code regardless of the frame rate
function love.update(dt)

    -- if player 1 is pressing w paddle will move up and s will make it move down
    -- clamps th y value at the edges for paddle 1
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- if player 2 is pressing up paddle will move up and down will make it move down
    -- clamps the y value at the edges for paddle 2
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown("down") then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

-- Updates the code when a specific key is pressed
function love.keypressed(key)
    -- When user presses the escape key the screen closes and the code stops
    if key == 'escape' then
        love.event.quit()

    -- When the user presses the enter key the game will swap its gameState
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'play' then
            gameState = 'start'
            ballStartUp()
        end
    end
end

-- When the screen opens up draws images and text onto the screen
function love.draw()
    push:apply('start')


    -- Sets the background to a different color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    --Sets font to small font
    love.graphics.setFont(smallFont)

    -- Prints hello and the current state above the ball using the new font
    if gameState == 'start' then
        love.graphics.printf("Hello Start State!", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf("Hello Play State!", 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- Sets font to score font
    love.graphics.setFont(scoreFont)

    -- Print out the scores of both players onto the screen
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)


    -- Makes the ball at the center of the screeen
    love.graphics.rectangle('fill', ballX, ballY, 5, 5)

    -- Makes the two paddle at opposite sides of the screen
    love.graphics.rectangle('fill', 5, player1Y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    push:apply("end")
end