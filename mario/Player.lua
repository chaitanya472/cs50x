Player = Class{}

require 'Animation'

local MOVE_SPEED = 80
local JUMP_VELOCITY = 400
local GRAVITY = 40

-- Assigns all of the values of class Player to the object
function Player:init(map)

    -- The height and width of the player
    self.width = 16
    self.height = 20

    -- The starting x and y of the player
    self.x = map.tileWidth * 10
    self.y = map.tileHeight * (map.mapHeight / 2 - 1) - self.height

    self.dx = 0
    self.dy = 0

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

        -- Animation for walking
        ['walking'] = Animation {
            texture = self.texture,
            frames = {

                -- Uses frames 9, 10, and 11
                self.frames[9], self.frames[10], self.frames[11]
            },
            interval = 0.15
        },

        -- Animation for jumping
        ['jumping'] = Animation {
            texture = self.texture,
            frames = {

                -- only uses frame 3
                self.frames[3]
            },
            interval = 1
        }
    }

    -- Sets up the current animation
    self.animation = self.animations['idle']

    -- Assigns behaviors that the player will go through
    self.behaviors = {

        -- beavior for when player is idle
        ['idle'] = function(dt)

            -- When pressing space get ready to use the jumping behavior and animation
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']

            -- When pressing a move left and set animation to walking
            elseif love.keyboard.isDown('a') then
                self.dx = -MOVE_SPEED
                self.direction = 'left'
                self.animation = self.animations['walking']

            -- When pressing d move right and set animation to walking
            elseif love.keyboard.isDown('d') then
                self.dx = MOVE_SPEED
                self.direction = 'right'
                self.animation = self.animations['walking']
            else
                self.animation = self.animations['idle']
                self.dx = 0
            end
        end,

        -- behavior for when player is walking
        ['walking'] = function(dt)

            -- When pressing space get ready to use the jumping behavior and animation
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']

            -- When pressing a move left and keep animation as walking
            elseif love.keyboard.isDown('a') then
                self.dx = -MOVE_SPEED
                self.direction = 'left'
                self.animation = self.animations['walking']

            -- When pressing d move right and keep animation as walking
            elseif love.keyboard.isDown('d') then
                self.dx = MOVE_SPEED
                self.direction = 'right'
                self.animation = self.animations['walking']
            else
                self.animation = self.animations['idle']
                self.dx = 0
            end
        end,

        -- behavior for when player is jumping
        ['jumping'] = function(dt)
            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -MOVE_SPEED
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = MOVE_SPEED
            end

            -- Slowly pushes the player back down to the ground
            self.dy = self.dy + GRAVITY

            -- When the player has reached the groud set the state and animation to idle
            if self.y >= map.tileHeight * (map.mapHeight / 2 - 1) - self.height then
                self.y = map.tileHeight * (map.mapHeight / 2 - 1) - self.height
                self.dy = 0
                self.state = 'idle'
                self.animationn = self.animations[self.state]
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

    -- Updates the x and y by dx and dy
    self.x = self.x + self.dx * dt 
    self.y = self.y + self.dy * dt 

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