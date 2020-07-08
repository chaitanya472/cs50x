WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

-- Loads outs our window for the game
function love.load()
    -- Sets up the filter for love to minimize and magnify images and text clearly
    love.graphics.setDefaultFilter('nearest', 'nearest') 

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

    love.graphics.printf(
        'Hello Pong!', -- text to render
        0,                          -- starting x (0 since it should be in the center)
        VIRTUAL_HEIGHT / 2 - 6,     -- starting y (halfway down the screen)
        VIRTUAL_WIDTH,              -- number of pixels to center 
        'center')                   -- alignment mode

    push:apply("end")
end