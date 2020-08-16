Player = Class{}

require 'Animation'


local MOVE_SPEED = 140
local JUMP_VELOCITY = 400

-- Assigns all of the values of class Player to the object
function Player:init(map)

    self.map = map

    -- The height and width of the player
    self.width = 16
    self.height = 20

    -- Sets up the x and y of the player
    self.y = map.tileHeight * ((map.mapHeight - 2) / 2) - self.height
    self.x = map.tileWidth * 10

    self.dx = 0
    self.dy = 0

    -- offset from top left to center to help with sprite flipping
    self.xOffset = 8
    self.yOffset = 10

    -- Assigns the png file holding all of the player frames to memory
    self.texture = love.graphics.newImage('graphics/blue_alien.png')

    -- sound effects for the game
    self.sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
        ['coin'] = love.audio.newSource('sounds/coin.wav', 'static')
    }

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
                self.sounds['jump']:play()

            -- When pressing a move left and set animation to walking
            elseif love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -MOVE_SPEED
                self.animation = self.animations['walking']
                self.state = 'walking'
                self.animations['walking']:restart()

            -- When pressing d move right and set animation to walking
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = MOVE_SPEED
                self.animation = self.animations['walking']
                self.state = 'walking'
                self.animations['walking']:restart()

            -- When not moving keep state and animation at idle
            else
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
                self.sounds['jump']:play()

            -- When pressing a move left and keep animation as walking
            elseif love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -MOVE_SPEED

            -- When pressing d move right and keep animation as walking
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = MOVE_SPEED

            -- When not moving change state to idle
            else
                self.animation = self.animations['idle']
                self.state = 'idle'
                self.dx = 0
            end

            -- check for collisions when moving left and right
            self:checkRightCollision()
            self:checkLeftCollision()

            -- check if there is a tile underneath the player
            if not self.map:collides(self.map:tileAt(self.x, self.y + self.height)) 
                and not self.map:collides(self.map:tileAt(self.x + self.width - 1,
                    self.y + self.height)) then

                -- if the player is atop no blocks then the player wil start to fall
                self.state = 'jumping'
                self.animation = self.animations['jumping']
            end

        end,

        -- behavior for when player is jumping
        ['jumping'] = function(dt)

            -- stop code if we are below the map
            if self.y > 300 then
                return
            end

            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -MOVE_SPEED
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = MOVE_SPEED
            end

            -- Slowly pushes the player back down to the ground
            self.dy = self.dy + self.map.gravity

            -- When the player has reached the groud reset the velocity
            if self.map:collides(self.map:tileAt(self.x, self.y + self.height)) or
                self.map:collides(self.map:tileAt(self.x + self.width - 1, self.y + self.height)) then
                self.dy = 0

                -- Changes state and animation back to idle
                self.state = 'idle'
                self.animation = self.animations[self.state]
                self.y = (self.map:tileAt(self.x, self.y + self.height).y - 1) * 
                    self.map.tileHeight - self.height       
            end

            -- check for collisions when moving left and right
            self:checkRightCollision()
            self:checkLeftCollision()
        end
    }
end

-- Updates the values of player
function Player:update(dt)

    -- Runs the behavior depending on what state it is
    self.behaviors[self.state](dt)

    -- Updates the animation
    self.animation:update(dt)

    -- Updates the x by the dx value
    self.x = self.x + self.dx * dt 

    self:calculateJumps()

    -- Updates the y value by the dy value
    self.y = self.y + self.dy * dt 
end 

-- Jumping and block hitting logic
function Player:calculateJumps()

    -- While jumping checks to see if the player collides with any block 
    -- that is not empty
    if self.dy < 0 then
        if self.map:tileAt(self.x, self.y).id ~= TILE_EMPTY or
            self.map:tileAt(self.x + self.width - 1, self.y).id ~= TILE_EMPTY then

            -- reset y velocity
            self.dy = 0

            -- Variables to keep track of when to play which soun
            local playCoin = false
            local playHit = false

            --changes JUMP_BLOCK to JUMP_BLOCK_HIT
            if self.map:tileAt(self.x, self.y).id == JUMP_BLOCK then
                self.map:setTile(math.floor(self.x / self.map.tileWidth) + 1,
                    math.floor(self.y / self.map.tileHeight) + 1, JUMP_BLOCK_HIT)
                    playCoin = true 
            else
                playHit = true 
            end
            if self.map:tileAt(self.x + self.width - 1, self.y).id == JUMP_BLOCK then
                self.map:setTile(math.floor((self.x + self.width - 1) / self.map.tileWidth) + 1,
                    math.floor(self.y / self.map.tileHeight) + 1, JUMP_BLOCK_HIT)
                playCoin = true
            else
                playHit = true
            end

            -- When playCoin has been set to true plays coin sound
            if playCoin then
                self.sounds['coin']:play()

            -- When playHit has been set to true plays hit sound
            elseif playHit then
                self.sounds['hit']:play()
            end
        end
    end
end

-- checks two tiles to players left to see if a collision occured
function Player:checkLeftCollision()
    if self.dx < 0 then

        -- Checks to see if there is a tile to the left og us
        if self.map:collides(self.map:tileAt(self.x - 1, self.y)) or
            self.map:collides(self.map:tileAt(self.x - 1, self.y + self.height - 1)) then

                -- if so, reset velocity and position and change state
                self.dx = 0
                self.x = self.map:tileAt(self.x - 1, self.y).x * self.map.tileWidth
        end
    end
end

-- checks two tiles to players right to see if a collision occured
function Player:checkRightCollision()
    if self.dx > 0 then

        -- Checks to see if there is a tile to the right of us
        if self.map:collides(self.map:tileAt(self.x + self.width, self.y)) or
            self.map:collides(self.map:tileAt(self.x + self.width, self.y + self.height - 1)) then

                -- if so, reset velocity and position and change state
                self.dx = 0
                self.x = (self.map:tileAt(self.x + self.width, self.y).x - 1) * self.map.tileWidth - self.width
        end
    end
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
        math.floor(self.x + self.xOffset), math.floor(self.y + self.yOffset),
        0, scaleX, 1, 
        self.xOffset, self.yOffset)
end
