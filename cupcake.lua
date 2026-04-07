local Cupcake = {}
Cupcake.__index = Cupcake

function Cupcake.new(x, y, img)
    local instance = setmetatable({}, Cupcake)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    return instance
end

function Cupcake:draw()
    love.graphics.draw(self.img, self.x - (self.width / 2), self.y - (self.height / 2))
end

return Cupcake