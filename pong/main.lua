WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

-- Loads outs our window for the game
function love.load()
    -- Sets up the filter for love to minimize and magnify images and text clearly
    love.graphics.setDefaultFilter('nearest', 'nearest') 

    -- Sets the font to the font from the text file with a font size of 8
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    -- Sets up the windo and its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        vsync = true,
        resizable = false
    })
end

-- When user presses the escape key the window closes and the code stops
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- When the windo opens up draws images and text onto the screen
function love.draw()
    push:apply('start')

    -- Sets the background to a different color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- Makes the ball at the center of the screeen
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 5, 5)

    -- Makes the two paddle at opposite sides of the screen
    love.graphics.rectangle('fill', 5, 20, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    -- Prints hello above the ball using the new font
    love.graphics.printf( "Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    push:apply("end")
end