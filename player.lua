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

local speed = 0
function playerMovement(dt)
    if love.keyboard.isdown('w', 'up') then
        speed = speed - dt
        print(speed)
    end
end


return Player