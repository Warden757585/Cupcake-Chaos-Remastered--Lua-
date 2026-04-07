local Player = {}
Player.__index = Player

function Player.new(x, y, img)
    local instance = setmetatable({}, Player)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    return instance
end

function Player:draw()
    love.graphics.draw(self.img, self.x - (self.width / 2), self.y - (self.height / 2))
end

function Player:getWidth()
    return self.width
end

function Player:getHeight()
    return self.height
end


local speed = 3.5
function Player:playerMovement(dt)
    if love.keyboard.isDown('w', 'up') then
        self.y = self.y - speed
    end
    if love.keyboard.isDown('s', 'down') then
        self.y = self.y + speed
    end
    if love.keyboard.isDown('a', 'left') then
        self.x = self.x - speed
    end
    if love.keyboard.isDown('d', 'right') then
        self.x = self.x + speed
    end
end


return Player