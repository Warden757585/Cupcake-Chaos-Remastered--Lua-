local Player = {}
Player.__index = Player

function Player.new(x, y, img, seed)
    local instance = setmetatable({}, Player)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.seed = seed
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


function Player:playerMovement()
    -- Declare all local variables
    local speed = 1

    -- When keys pressed update the velocity
    if love.keyboard.isDown('w', 'up') then
        self.y_velocity = self.y_velocity - (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('s', 'down') then
        self.y_velocity = self.y_velocity + (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('a', 'left') then
        self.x_velocity = self.x_velocity - (1 * (speed / 1.5))
    end

    if love.keyboard.isDown('d', 'right') then
        self.x_velocity = self.x_velocity + (1 * (speed / 1.5))
    end

    -- Update the position based on the velocity
    self.x = self.x + self.x_velocity
    self.y = self.y + self.y_velocity

    -- Apply damping to slow the player
    self.x_velocity = self.x_velocity * 0.95
    self.y_velocity = self.y_velocity * 0.95
    -- If the velocity is an insignificant amount then just set it to 0 
    if (self.x_velocity < 0.5 and self.x_velocity > -0.5) then
    
        self.x_velocity = 0;
    end
    if (self.y_velocity < 0.5 and self.y_velocity > -0.5) then
        self.y_velocity = 0;
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
            cupcakeList[i]:rePosition()
        end
    end
end


return Player