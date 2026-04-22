local Button = {}
Button.__index = Button

local Timer = require("Components.Interactive.timer")

function Button.new(x, y, img, text, font, inputDelay)
    local instance = setmetatable({}, Button)
    instance.img = img
    instance.text = text or ""
    instance.font = font or love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    instance.x = x - (instance.width / 2)
    instance.y = y - (instance.height / 2)
    instance.inputDelay = inputDelay or 0.2
    instance.inputTimer = Timer.new(instance.inputDelay)
    instance.inputTimer:startCounting()
    instance.isClickable = false
    return instance
end

function Button:draw()
    love.graphics.draw(self.img, self.x, self.y)
    love.graphics.printf( self.text, self.font, self.x, self.y + ((self.height / 2) - (self.font:getHeight() / 2)), self.width, "center")
end

function Button:isMouseOver()
    local mx, my = love.mouse.getPosition()
    if self.x < mx and mx < self.x + self.width and self.y < my and my < self.y + self.height then
        return true
    else
        return false
    end
end

function Button:isClicked(dt, pressSound)
    self.inputTimer:updateTime(dt)
    if self.inputTimer:getTicksPassed() > 0 then
        self.inputTimer:resetTicks()
        self.isClickable = true
    end

    if love.mouse.isDown(1) and self:isMouseOver() and self.isClickable then
            self.isClickable = false
            if pressSound ~= nil then
                love.audio.play(pressSound)
            end
            return true
        else
            return false
        end
end

return Button