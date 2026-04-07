local Player = {}
Player.__index = Player

function Player.new(x, y, img)
    local instance = setmetatable({}, Player)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    instance.speed = 1
    instance.x_velocity = 0
    instance.y_velocity = 0
    instance.type = "Player"
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



local speed = 1
local x_velocity = 0
local y_velocity = 0
function Player:playerMovement()
    -- When keys pressed update the velocity
    if love.keyboard.isDown('w', 'up') then
        y_velocity = y_velocity - (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('s', 'down') then
        y_velocity = y_velocity + (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('a', 'left') then
        x_velocity = x_velocity - (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('d', 'right') then
        x_velocity = x_velocity + (1 * (speed / 1.5))
    end

    -- Update the position based on the velocity
    self.x = self.x + x_velocity
    self.y = self.y + y_velocity

    -- Apply damping to slow the player
    x_velocity = x_velocity * 0.95
    y_velocity = y_velocity * 0.95
    -- If the velocity is an insignificant amount then just set it to 0 
    if (x_velocity < 0.5 and x_velocity > -0.5) then
    
        x_velocity = 0;
    end
    if (y_velocity < 0.5 and y_velocity > -0.5) then
    
        y_velocity = 0;
    end
end

function Player:baseCollisionCheck(x, y, width, height)
    -- Player boundaries
    local pLeft   = self.x - (self.width / 2)
    local pRight  = self.x + (self.width / 2)
    local pTop    = self.y - (self.height / 2)
    local pBottom = self.y + (self.height / 2)
    -- Object boundaries
    local cLeft   = x - (width / 2)
    local cRight  = x + (width / 2)
    local cTop    = y - (height / 2)
    local cBottom = y + (height / 2)
    -- If any are true then the object and plaer aren't touching
    return pLeft < cRight and
           pRight > cLeft and
           pTop < cBottom and
           pBottom > cTop
end

function Player:checkCupcakes(cupcakeList)
    for i = #cupcakeList, 1, -1 do
        if(self:baseCollisionCheck(cupcakeList[i].x, cupcakeList[i].y, cupcakeList[i].width, cupcakeList[i].height) == true) then
            table.remove(cupcakeList, i)
        end
    end
end


return Player