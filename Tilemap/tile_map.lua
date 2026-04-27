local TileMap = {}
TileMap.__index = TileMap
    
function TileMap.new(tileSize, tileAtlas)
    local instance = setmetatable({}, TileMap)
    instance.tileSize = tileSize
    instance.tileAtlas = tileAtlas
    return instance
end

function TileMap:draw(matrix)
    for i = 1, #matrix do
        for j = 1, #matrix[i] do
            love.graphics.draw(self.tileAtlas:getTileImg(matrix[i][j]), (j - 1) * self.tileSize, (i - 1) * self.tileSize)
        end
    end
end

return TileMap