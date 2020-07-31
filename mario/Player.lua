Player = Class{}

require 'Animation'

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

    -- Sets up a state for the player
    self.state = 'idle'

    -- Assigns animation for the player to go through
    self.animations = {

        -- Animation for when idle
        ['idle'] = Animation {
            texture = self.texture,
            frames = {

                -- only uses frame 1
                self.frames[1]
            },
            interval = 1
        },

        -- Animation for when walking
        ['walking'] = Animation {
            texture = self.texture,
            frames = {

                -- Uses frames 9, 10, and 11
                self.frames[9], self.frames[10], self.frames[11]
            },
            interval = 0.15
        }
    }

    -- Sets up the current animation
    self.animation = self.animations['idle']

    -- Assigns behaviors that the player will go through
    self.behaviors = {

        -- beavior for when player is idle
        ['idle'] = function(dt)

            -- When pressing a move left and set animation to walking
            if love.keyboard.isDown('a') then
                self.x = self.x - MOVE_SPEED * dt 
                self.direction = 'left'
                self.animation = self.animations['walking']

            -- When pressing d move right and set animation to walking
            elseif love.keyboard.isDown('d') then
                self.x = self.x + MOVE_SPEED * dt
                self.direction = 'right'
                self.animation = self.animations['walking']
            else
                self.animation = self.animations['idle']
            end
        end,

        -- behavior for when player is walking
        ['walking'] = function(dt)

            -- When pressing a move left and keep animation as walking
            if love.keyboard.isDown('a') then
                self.x = self.x - MOVE_SPEED * dt
                self.direction = 'left'
                self.animation = self.animations['walking']

            -- When pressing d move right and keep animation as walking
            elseif love.keyboard.isDown('d') then
                self.x = self.x + MOVE_SPEED * dt
                self.direction = 'right'
                self.animation = self.animations['walking']
            else
                self.animation = self.animations['idle']
            end
        end
    }
end

-- Updates the values of player
function Player:update(dt)

    -- Runs the behavior depending on what state it is
    self.behaviors[self.state](dt)

    -- Updates the animation
    self.animation:update(dt)

end

-- Renders out the player onto the screen
function Player:render()

    local scaleX

    -- When the direction isn't right flips the player when drawn
    if self.direction == 'right' then
        scaleX = 1
    else
        scaleX = -1
    end

    -- Draws out the player whith its origin point being in the middle of the sprite
    love.graphics.draw(self.texture, self.animation:getCurrentFrame(), 
        math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2),
        0, scaleX, 1, 
        self.width / 2, self.height / 2)
end