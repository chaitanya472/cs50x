Map = Class{}

TILE_BRICK = 1
TILE_EMPTY = 4

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
   self.camY = 0

   -- Assigns the spreadsheet as quads to table tileSprites
   self.tileSprites = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

   -- Filling the map with empty tiles
   for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    -- starts halfway down the map and populates it with bricks
    for y = self.mapHeight / 2, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_BRICK)
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

-- Updates the values of a map
function Map:update(dt)

    -- Increases camX by SCROLL_SPEED each second
    self.camX = self.camX + SCROLL_SPEED * dt
end

-- renders out the map onto the screen making it visible
function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if self:getTile(x, y) == TILE_BRICK then
                -- draws out all of the values onto the map
                love.graphics.draw(self.spritesheet, self.tileSprites[self:getTile(x, y)],
                    (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
            end
        end
    end
end

return Map