local TileAtlas = {}
TileAtlas.__index = TileAtlas

function TileAtlas.new(tileset, scaling)
    local instance = setmetatable({}, TileAtlas)
    instance.tileImgs = {}
    instance.tileset = tileset
    instance.scaling = scaling or 1
    return instance
end

function TileAtlas:loadFromTileset()
    local tileW, tileH = 32, 32
    local sheetW, sheetH = self.tileset:getDimensions()
    for y = 0, (sheetH / tileH) - 1 do
        for x = 0, (sheetW / tileW) - 1 do
            local quad = love.graphics.newQuad(
                x * tileW, 
                y * tileH, 
                tileW, 
                tileH, 
                sheetW, 
                sheetH
            )
            table.insert(self.tileImgs, quad)
        end
    end
end

function TileAtlas:drawLayer(matrix)
    if matrix == nil then
        return nil
    end
    if matrix ~= nil then
        for i = 1, #matrix do
            for j = 1, #matrix[i] do
                if matrix[i][j] ~= 0 then
                     love.graphics.draw(self.tileset, self.tileImgs[matrix[i][j]], 32 * self.scaling * (j - 1), 32 * self.scaling * (i - 1), 0, self.scaling, self.scaling)
                end
            end
        end
    end
end

return TileAtlas