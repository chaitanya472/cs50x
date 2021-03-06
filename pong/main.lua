WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
 
PADDLE_SPEED = 200


Class = require 'class'
push = require 'push'
Paddle = require 'Paddle'
Ball = require 'Ball'

-- Loads outs our screen for the game
function love.load()
    math.randomseed(os.time())

    -- Sets up the filter for love to minimize and magnify images and text clearly
    love.graphics.setDefaultFilter('nearest', 'nearest') 

    -- Changes the screens title to Pong
    love.window.setTitle("Pong")

    -- Sets up all of the fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    victoryFont = love.graphics.newFont('font.ttf', 24)

    -- Sets up all .wav files into table sounds
    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['point_scored'] = love.audio.newSource('score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static')
    }

    -- Sets up the players scores
    player1Score = 0
    player2Score = 0

    -- Sets who will be the starting serving player
    servingPlayer = math.random(2) == 1 and 1 or 2

    -- Sets up a placeholder for the winning player
    winningPlayer = 0

    -- Sets up the two players paddles
    paddle1 = Paddle(5, 20, 5, 20)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- Sets up the ball
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)

    -- Sets up the balls dx value depending on which player is the serving player
    if servingPlayer == 1 then
        ball.dx = 100
    else
        ball.dx = -100
    end

    --Sets up the state for the game
    gameState = 'start'

    -- Sets up the screeen and its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        vsync = true,
        resizable = true
    })
end

-- Allows for the screen to be resized without stretching out sides of the screen
function love.resize(w, h)
    push:resize(w, h)
end

-- Updates the code regardless of the frame rate
function love.update(dt)

    -- When player 2 scores adds to player2Score and returns ball to default position
    -- Played sound point_scored and sets up the serving player as player 1
    if ball.x <= 0 then
        player2Score = player2Score + 1
        sounds['point_scored']:play()
        ball:reset()
        servingPlayer = 1
        ball.dx = 100

        -- Sets the winning player to player 2 and state to victory if player 2 wins
        if player2Score >= 3 then
            gameState = 'victory'
            winningPlayer = 2
        else
            gameState = 'serve'
        end
    end

    -- When player 1 scores adds to player1Score and returns ball to default position
    -- Plays sound point_scored and sets up the serving player as player 2
    if ball.x >= VIRTUAL_WIDTH - 4 then
        player1Score = player1Score + 1
        sounds['point_scored']:play()
        ball:reset()
        servingPlayer = 2
        ball.dx = -100

        -- Sets the winning player to player 2 and state to victory if player 2 wins
        if player1Score >= 3 then
            gameState = 'victory'
            winningPlayer = 1
        else
            gameState = 'serve'
        end
    end
    -- If the balls hit either paddle deflect the ball to the opposite direction 
    -- Also makes the ball faster when colliding with a paddle
    -- Plays sound paddle_hit
    if ball:collides(paddle1) then
        ball.dx = -ball.dx * 1.03
        ball.speed = ball.speed + 0.05
        ball.x = paddle1.x + 5
        sounds['paddle_hit']:play()
    elseif ball:collides(paddle2) then
        ball.dx = - ball.dx * 1.03
        ball.speed = ball.speed + 0.03
        ball.x = paddle2.x - 5
        sounds['paddle_hit']:play()
    end

    -- If the ball hits the bottom edge deflects it upwards and makes it faster
    -- Plays sound wall_hit
    if ball.y <= 0 then
        ball.dy = -ball.dy
        ball.speed = ball.speed + 0.03
        ball.y = 0
        sounds['wall_hit']:play()
    end

    -- If the ball hits the top edge deflects it downwards annd makes it faster
    -- Plays sound wall_hit
    if ball.y >= VIRTUAL_HEIGHT - 4 then
        ball.dy = -ball.dy
        ball.speed = ball.speed + 0.03
        ball.y = VIRTUAL_HEIGHT - 4
        sounds['wall_hit']:play()
    end
    -- if player 1 is pressing w paddle will move up and s will make it move down
    if love.keyboard.isDown('w') then
        paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        paddle1.dy = PADDLE_SPEED
    else
        paddle1.dy = 0
    end

    -- Allows for the ball and paddle to move when the gameState is play
    if gameState == 'play' then
        ball:update(dt)

        -- Makes a range in which the paddle will track the ball
        if ball.x >= VIRTUAL_WIDTH * 2 / 3  then

            -- If paddle 2 is balow the ball it will move up
            -- If it is above the ball it will move down
            if ball.y + ball.width <= paddle2.y then
                paddle2.dy = -PADDLE_SPEED
            elseif ball.y >= paddle2.y + paddle2.height then
                paddle2.dy = PADDLE_SPEED
            else
                paddle2.dy = 0
            end
        else

            -- If the ball is out of its range moves paddle to center of the screen
            if paddle2.y >=  VIRTUAL_HEIGHT/ 2 then
                paddle2.dy = -PADDLE_SPEED
            elseif paddle2.y + paddle2.height <= VIRTUAL_HEIGHT/ 2  then
                paddle2.dy = PADDLE_SPEED
            else
                paddle2.dy = 0
            end
        end
    end
    paddle1:update(dt)
    paddle2:update(dt)
end

-- Updates the code when a specific key is pressed
function love.keypressed(key)

    -- When user presses the escape key the screen closes and the code stops
    if key == 'escape' then
        love.event.quit()

    -- When the user presses the enter key the game will swap its gameState
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'victory' then
            gameState = 'start'
            player2Score = 0
            player1Score = 0
        elseif gameState == 'serve' then
            gameState = 'play'
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

    -- Prints out the starting message to the user
    if gameState == 'start' then
        love.graphics.printf("Welcome to Pong!", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Play!", 0, 32, VIRTUAL_WIDTH, 'center')
    
    -- Prints out which player's turn it is to serve
    elseif gameState == 'serve' then
        love.graphics.printf("Player ".. tostring(servingPlayer) .. "'s turn", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Serve!", 0, 32, VIRTUAL_WIDTH, 'center')
    -- Draws a victory message
    elseif gameState == 'victory' then 
        love.graphics.setFont(victoryFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. " wins!",
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Play!", 0, 42, VIRTUAL_WIDTH, 'center')
        
        
    end
    
    -- Displayes the score
    displayScore()


    -- Makes the ball at the center of the screeen
    ball:render()

    -- Makes the two paddle at opposite sides of the screen
    paddle1:render()
    paddle2:render()

    -- Displays the fps onto the screen
    displayFPS()

    push:apply("end")
end

-- Prints out the current fps in a different noticble color
function displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print("FPS: ".. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
end

function displayScore()
    -- Sets font to score font
    love.graphics.setFont(scoreFont)

    -- Print out the scores of both players onto the screen
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end