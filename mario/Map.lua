Map = Class{}

TILE_BRICK = 1
TILE_EMPTY = 4

-- cloud tiles
CLOUD_LEFT = 6
CLOUD_RIGHT = 7

-- bush tiles
BUSH_LEFT = 2
BUSH_RIGHT = 3

-- mushroom tiles
MUSHROOM_TOP = 10
MUSHROOM_BOTTOM = 11

-- jump block
JUMP_BLOCK = 5

local SCROLL_SPEED = 62

-- Assigns all of the values of class map to the object
function Map:init()
   self.spritesheet = love.graphics.newImage('graphics/spritesheet.png')

   -- The pixel heigt and width of each tile in our map
   self.tileWidth = 16
   self.tileHeight = 16

   -- The tile height and width of the whole map
   self.mapWidth = 30
   self.mapHeight = 28

   -- The tile map data for the map
   self.tiles = {}

   -- Sets up the velocity for the camera will move
   self.camX = 0
   self.camY = -3

   -- Assigns the spreadsheet as quads to table tileSprites
   self.tileSprites = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

   -- Gets the map width and height in pixels
   self.mapWidthPixels = self.mapWidth * self.tileWidth
   self.mapHeightPixels = self.mapHeight * self.tileHeight

   -- Filling the map with empty tiles
   for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    local x = 1
    while x < self.mapWidth do

        -- 1/20 chance to generate clouds when at least 2 spaces from the edge
        if x < self.mapWidth - 2 then
            if math.random(20) == 1 then

                -- Makes sure clouds won't generate on top of other tiles
                local cloudStart = math.random(self.mapHeight / 2 - 6)
                self:setTile(x, cloudStart, CLOUD_LEFT)
                self:setTile(x + 1, cloudStart, CLOUD_RIGHT)
            end
        end

        -- 1/20 chance to generate a mushroom
        if math.random(20) == 1 then
            self:setTile(x, self.mapHeight / 2 - 2, MUSHROOM_TOP)
            self:setTile(x, self.mapHeight / 2 - 1, MUSHROOM_BOTTOM)

            -- Under the mushroom generates a colomn of bricks to the edge of the map
            self:brickColomn(x)

            -- increments x to push the loop to generate the next colomn of the map
            x = x + 1

        -- 1/10 chance to generate a bush away from the edge
        elseif math.random(10) == 1 and x < self.mapWidth - 3 then
            local bushLevel = self.mapHeight / 2 - 1 

            -- Generates left bush with bricks underneath
            self:setTile(x, bushLevel, BUSH_LEFT)
            self:brickColomn(x)
            x = x + 1
            self:setTile(x, bushLevel, BUSH_RIGHT)
            self:brickColomn(x)
            x = x + 1
        
        -- 1/10 chance to generate a gap
        elseif math.random(10) ~= 1 then

            -- Generates a colomn of bricks to the bottom
            self:brickColomn(x)
            
            -- 1/15 chance to generate a jump block
            if math.random(15) == 1 then 
                self:setTile(x, self.mapHeight / 2 -4, JUMP_BLOCK)
            end

            -- Goes to the next vertical line
            x = x + 1
        else

            -- Skips two lines making a gap
            x = x + 2
        end
    end              
end

-- Sets given tile to table tile
function Map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end

-- Returns the tile of th e given x and y value
function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

-- Makes a colomn of bricks to the bottom edge of the map
function Map:brickColomn(x)
    for y = self.mapHeight / 2, self.mapHeight do
        self:setTile(x, y, TILE_BRICK)
    end
end
-- Updates the values of a map
function Map:update(dt)
 
    -- Allows for user to control the camera with w, a, s, and d
    -- Clamps the user at the edges of the map
    if love.keyboard.isDown('w') then

        -- Increases camY by negative SCROLL_SPEED each second
        self.camY = math.max(0, math.floor(self.camY - SCROLL_SPEED * dt))
    elseif love.keyboard.isDown('a') then

        -- Increases camX by negative SCROLL_SPEED each second
        self.camX = math.max(0, math.floor(self.camX - SCROLL_SPEED * dt))
    elseif love.keyboard.isDown('s') then

        -- Increases camY by SCROLL_SPEED each second
        self.camY = math.min(self.mapHeightPixels - VIRTUAL_HEIGHT, math.floor(self.camY + SCROLL_SPEED * dt))
    elseif love.keyboard.isDown('d') then

        -- Increases camX by SCROLL_SPEED each second
        self.camX = math.min(self.mapWidthPixels - VIRTUAL_WIDTH, math.floor(self.camX + SCROLL_SPEED * dt))
    end
end

-- renders out the map onto the screen making it visible
function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            local tile = self:getTile(x, y)
            love.graphics.draw(self.spritesheet, self.tileSprites[tile],
                (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
        end
    end
end

