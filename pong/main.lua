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

    -- Sets up the score for both players
    player1Score = 0
    player2Score = 0

    -- Sets up the y value for each players paddles
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 40

    -- Sets up the screeen and its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        vsync = true,
        resizable = false
    })
end

-- Updates the code regardless of the frame rate
function love.update(dt)

    -- if player 1 is pressing w paddle will move up and s will make it move down
    if love.keyboard.isDown('w') then
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- if player 2 is pressing up paddle will move up and down will make it move down
    if love.keyboard.isDown('up') then
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown("down") then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

-- When user presses the escape key the screen closes and the code stops
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- When the screen opens up draws images and text onto the screen
function love.draw()
    push:apply('start')


    -- Sets the background to a different color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    --Sets font to small font
    love.graphics.setFont(smallFont)

    -- Prints hello above the ball using the new font
    love.graphics.printf( "Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    -- Sets font to score font
    love.graphics.setFont(scoreFont)

    -- Print out the scores of both players onto the screen
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)


    -- Makes the ball at the center of the screeen
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)

    -- Makes the two paddle at opposite sides of the screen
    love.graphics.rectangle('fill', 5, player1Y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    
    push:apply("end")
end