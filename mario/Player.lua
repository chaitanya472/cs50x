Player = Class{}

MOVE_SPEED = 80

-- Assigns all of the values of class Player to the object
function Player:init(map)

    -- The height and width of the player
    self.width = 16
    self.height = 20

    -- The starting x and y of the player
    self.x = map.tileWidth * 10
    self.y = map.tileHeight * (map.mapHeight / 2 - 1) - self.height

    -- Assigns the png file holding all of the player frames to memory
    self.texture = love.graphics.newImage('graphics/blue_alien.png')

    -- Assigns texture as quads to table frames
    self.frames = generateQuads(self.texture, 16, 20)
end

-- Updates the values of player
function Player:update(dt)

    -- Allows for the player sprite to move depending on which key is down
    if love.keyboard.isDown('a') then
        self.x = self.x - MOVE_SPEED * dt
    elseif love.keyboard.isDown('d') then
        self.x = self.x + MOVE_SPEED * dt
    end
end

-- Renders out the player onto the screen
function Player:render()
    love.graphics.draw(self.texture, self.frames[1], self.x, self.y)
end