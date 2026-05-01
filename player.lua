local Player = {}
Player.__index = Player

function Player.new(x, y, img, seed, scaling, rotation)
    local instance = setmetatable({}, Player)
    instance.img = img
    instance.seed = seed
    instance.scaling = scaling or 1
    instance.rotation = rotation or 0
    instance.width = instance.img:getWidth() * instance.scaling
    instance.height = instance.img:getHeight() * instance.scaling
    instance.x = 0
    instance.y = 0 
    instance.score = 0
    instance.speed = 1
    instance.x_velocity = 0
    instance.y_velocity = 0
    instance.type = "Player"
    return instance
end

function Player:changePosition()
    math.randomseed(self.seed)
    self.x = math.random(self.width / 2, love.graphics.getWidth() - self.width / 2)
    self.y = math.random(self.height / 2, love.graphics.getHeight() - self.height / 2)
    self.seed = self.seed + 1
end

function Player:draw(spriteBatch)
    if not self.quad then
        self.quad = love.graphics.newQuad(0, 0, self.img:getWidth(), self.img:getHeight(), self.img)
    end
    spriteBatch:add(self.quad, self.x, self.y, self.rotation, self.scaling, self.scaling)
end


function Player:playerMovement()
    -- Re-adjust the speed variable based on the score as long as the speed is below 3 or else it gets too fast
    if(self.speed < 3) then
        self.speed = 1 + (self.score * 0.025)
    end
    -- When keys pressed update the velocity
    if love.keyboard.isDown('w', 'up') then
        self.y_velocity = self.y_velocity - (1 * (self.speed / 1.5))
    end

    if love.keyboard.isDown('s', 'down') then
        self.y_velocity = self.y_velocity + (1 * (self.speed / 1.5))
    end

    if love.keyboard.isDown('a', 'left') then
        self.x_velocity = self.x_velocity - (1 * (self.speed / 1.5))
    end

    if love.keyboard.isDown('d', 'right') then
        self.x_velocity = self.x_velocity + (1 * (self.speed / 1.5))
    end

    -- Calculate center position
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2

    -- Update the position based on the velocity
    centerX = centerX + self.x_velocity
    centerY = centerY + self.y_velocity

    -- Recalculate top-left position
    self.x = centerX - self.width / 2
    self.y = centerY - self.height / 2

    -- Apply damping to slow the player
    self.x_velocity = self.x_velocity * 0.94
    self.y_velocity = self.y_velocity * 0.94
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
    local pLeft   = self.x
    local pRight  = self.x + self.width
    local pTop    = self.y
    local pBottom = self.y + self.height
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
            self.score = self.score + 1
        end
    end
end

function Player:renderHatAccesory(hatImg, spriteBatch)
    if hatImg ~= nil then
        local hatScale = self.scaling * 2
        local hatWidth = hatImg:getWidth() * hatScale
        local hatHeight = hatImg:getHeight() * hatScale
        local hatX = self.x + (self.width - hatWidth) / 2
        local hatY = self.y - hatHeight / 2
        if not self.hatQuad then
            self.hatQuad = love.graphics.newQuad(0, 0, hatImg:getWidth(), hatImg:getHeight(), hatImg)
        end
        spriteBatch:add(self.hatQuad, hatX, hatY, self.rotation, hatScale, hatScale)
    end
end

return Player