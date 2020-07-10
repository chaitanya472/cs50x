Ball = Class{}

-- Sets up all of the values for the object taking the class Ball
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.height = height
    self.width = width

    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

-- Resets the ball's position back to its starting position
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
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