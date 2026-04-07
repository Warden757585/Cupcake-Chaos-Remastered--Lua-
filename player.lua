local Player = {}
Player.__index = Player

function Player.new(x, y, img)
    local instance = setmetatable({}, Player)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    instance.type = "Cupcake"
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



function Player:playerMovement()
    local speed = 1
    local x_velocity = 0
    local y_velocity = 0

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

function Player:checkCollisions(cupcakeList)
    for i = #cupcakeList, 1, -1 do
        if((self.x + self.width) > cupcakeList[i].x --[[Player !right of cupcake]] and self.x < (cupcakeList[i].x + cupcakeList[i].width)) then
            table.remove(cupcakeList, i)
        end
    end
end


return Player