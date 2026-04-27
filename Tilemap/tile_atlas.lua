local TileAtlas = {}
TileAtlas.__index = TileAtlas

function TileAtlas.new(tileImgs)
    local instance = setmetatable({}, TileAtlas)
    instance.tileImgs = tileImgs
    return instance
end

function TileAtlas:getTileImg(index)
    return self.tileImgs[index]
end

return TileAtlas