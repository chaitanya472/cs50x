-- Seperates the given spreadsheet into multiple small images and storing them to memory
function generateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            -- Assigns all of the quads to table quads
            quads[sheetCounter] = love.graphics.newQuad(x * tilewidth, 
                y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end
    return quads
end