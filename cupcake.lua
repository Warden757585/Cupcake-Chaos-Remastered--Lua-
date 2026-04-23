local Cupcake = {}
Cupcake.__index = Cupcake

function Cupcake.new(x, y, img, seed, scoreSound)
    local instance = setmetatable({}, Cupcake)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.seed = seed
    instance.scoreSound = scoreSound
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    instance.type = "Cupcake"
    return instance
end

function Cupcake:draw(spriteBatch)
    if not self.quad then
        self.quad = love.graphics.newQuad(0, 0, self.width, self.height, self.img)
    end
    spriteBatch:add(self.quad, self.x - (self.width / 2), self.y - (self.height / 2), 0, 1, 1)
end

function Cupcake:rePosition()
    math.randomseed(self.seed)
    self.x = math.random(self.width / 2, love.graphics.getWidth() - self.width / 2)
    self.y = math.random(self.height / 2, love.graphics.getHeight() - self.height / 2)
    self.seed = self.seed + 1
    love.audio.play(self.scoreSound)
end

return Cupcake