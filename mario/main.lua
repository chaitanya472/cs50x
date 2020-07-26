WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

Class = require 'class'
push = require 'push'

require 'Player'

require 'Util'

require 'Map'

-- Changes the filter that it will use so that when changing the size it is clear
love.graphics.setDefaultFilter('nearest', 'nearest')

math.randomseed(os.time())

-- Assigning map to class Map
map = Map()


-- Loads out our screen and assigns objects to a class
function love.load()

    -- Making the screen for our game
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

-- Updates the screen
function love.update(dt)

    -- Updates the map
    map:update(dt)
end

function love.draw()
    push:apply('start')

    -- Moves the screen from its strating place the values below
    love.graphics.translate(math.floor(-map.camX + 0.5), math.floor(-map.camY + 0.5))

    -- Sets the background color 
    love.graphics.clear(108/255, 140/255, 1, 1)

    -- Renders out the map making it visible
    map:render()
    push:apply('end')
end