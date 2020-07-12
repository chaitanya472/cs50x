Ball = Class{}

-- Sets up all of the values for the object taking the class Ball
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.height = height
    self.width = width

    self.dx = 0
    self.dy = math.random(-50, 50)
end

-- Checks to see if the ball has collided with the given value for box
function Ball:collides(box)
    if self.x > box.x + box.width or self.x + self.width < box.x then
        return false
    end
    if self.y > box.y + box.height or self.y + self.height < box.y then
        return false
    end
    return true
end

-- Resets the ball's position back to its starting position
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(-50, 50)
end

-- Updates the ball's position based on its dx and dy value
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

-- Renders the ball onto the screen
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end

return Ball