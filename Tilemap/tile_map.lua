local TileMap = {}
TileMap.__index = TileMap
    
function TileMap.new(tileSize, tileAtlas)
    local instance = setmetatable({}, TileMap)
    instance.tileSize = tileSize
    instance.tileAtlas = tileAtlas
    return instance
end

function TileMap:drawFloor(matrix)
    if matrix == nil then
        for i = 1, math.ceil(love.graphics.getHeight() / self.tileSize) do
            for j = 1, math.ceil(love.graphics.getWidth() / self.tileSize) do
                love.graphics.draw(self.tileAtlas:getTileImg(1), (j - 1) * self.tileSize, (i - 1) * self.tileSize)
            end
        end
    end
    if matrix ~= nil then
        for i = 1, #matrix do
            for j = 1, #matrix[i] do
                love.graphics.draw(self.tileAtlas:getTileImg(matrix[i][j]), (j - 1) * self.tileSize, (i - 1) * self.tileSize)
            end
        end
    end
end

function TileMap:drawLayer(matrix)
    if matrix == nil then
        return nil
    end
    if matrix ~= nil then
        for i = 1, #matrix do
            for j = 1, #matrix[i] do
                if matrix[i][j] ~= 0 then
                     love.graphics.draw(self.tileAtlas:getTileImg(matrix[i][j]), (j - 1) * self.tileSize, (i - 1) * self.tileSize)
                end
            end
        end
    end
end


return TileMap