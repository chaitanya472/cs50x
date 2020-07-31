Animation = Class{}

-- Assigns all of the values of class Animation to objct
function Animation:init(params)

    -- obtains both the texture and frames to animate through from params
    self.texture = params.texture
    self.frames = params.frames

    -- Either takes the given interval from params or 0.5
    self.interval = params.interval or 0.5

    -- Sets up a timer for the animation
    self.timer = 0

    -- Sets up a place to hold the index for the current frame
    self.currentFrame = 1
end

-- Returns the current frame
function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

-- Resets the animation
function Animation:restart()

    -- Restarts the timer and sets the currentFrame to its first value
    self.timer = 0
    self.currentFrame = 1
end

-- Updates the animation
function Animation:update(dt)

    -- Updates the timer by delta time
    self.timer = self.timer + dt

    -- If there is only one frame in frames then it wil just return self.currentFrame
    if #self.frames == 1 then
        return self.currentFrame
    else

        -- While the timer is greater then the interval 
        while self.timer > self.interval do

            -- Decreases timer by interval 
            self.timer = self.timer - self.interval

            -- Increments up currentFrame until Current Frame is equal to the size of frames
            -- Then set currentFrame to 0
            self.currentFrame = (self.currentFrame + 1) % (#self.frames + 1)

            -- Once the current frame is set to 0 set it back to 1
            if self.currentFrame == 0 then self.currentFrame = 1 end 
        end
    end
end